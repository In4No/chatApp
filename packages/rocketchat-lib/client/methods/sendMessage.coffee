Meteor.methods
	sendMessage: (message) ->
		if not Meteor.userId()
			throw new Meteor.Error 203, t('User_logged_out')

		if _.trim(message.msg) isnt ''

			message.ts = new Date(Date.now() + TimeSync.serverOffset())

			message.u =
				_id: Meteor.userId()
				username: Meteor.user().username

			message.temp = true

			message = RocketChat.callbacks.run 'beforeSaveMessage', message

			checkJournal = message.msg.indexOf '@Journal'
			if checkJournal > -1
				message.starred = {}
				message.starred._id = Meteor.userId()
				Meteor.call 'starMessage', message, (error, result) ->
					if error
						return Errors.throw error.reason

			ChatMessage.insert message
