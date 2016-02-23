Meteor.startup ->
	RocketChat.TabBar.addButton({
		groups: ['channel', 'privategroup', 'directmessage'],
		id: 'starred-messages',
		i18nTitle: 'Journal Entries',
		icon: 'icon-book',
		template: 'starredMessages',
		order: 3
	})
