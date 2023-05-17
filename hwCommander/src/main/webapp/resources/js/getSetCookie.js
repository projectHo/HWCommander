/*--------------------------------------------------
 - 2023.05.13 cookie js 추가(adminPage 보기단위에 쓰임)
--------------------------------------------------*/
function getCookie(name) {
	let matches = document.cookie.match(new RegExp("(?:^|; )"
			+ name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1')
			+ "=([^;]*)"));
	return matches ? decodeURIComponent(matches[1]) : undefined;
}

function setCookie(name, value, options) {
	if (options.expires instanceof Date) {
		options.expires = options.expires.toUTCString();
	}

	let updatedCookie = encodeURIComponent(name) + "="
			+ encodeURIComponent(value);

	for ( let optionKey in options) {
		updatedCookie += "; " + optionKey;
		let optionValue = options[optionKey];
		if (optionValue !== true) {
			updatedCookie += "=" + optionValue;
		}
	}

	document.cookie = updatedCookie;
}

function setDisplayLength() {
	var displayLength = getCookie("displayLength"); 
	
	if(undefined === displayLength
			|| "null" == displayLength) {
		displayLength = 10;
	}
	
	return parseInt(displayLength);
}