// export function initialize(link, application) {
export function initialize(link) {
	console.log('Linking to SFDC...')

	if (!window.parent.link_SFDC || !window.parent.navigate_SFDC) {
		console.log('Could not connect link to salesforce')
		return;
	}

	window.parent.link_SFDC(link);

	window.onhashchange = function() {
		window.parent.navigate_SFDC(
			window.location.hash.substring(1)
		)
	}

}

export default {
  name: 'link-sfdc',
  initialize
};
