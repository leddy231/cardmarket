var config = {
  apiKey: "AIzaSyACHHgEdmn9xN0qMY7vMKJ4_45OVGJdyz4",
  authDomain: "steffescardmarket.firebaseapp.com",
  databaseURL: "https://steffescardmarket.firebaseio.com",
  projectId: "steffescardmarket",
  storageBucket: "steffescardmarket.appspot.com",
  messagingSenderId: "341110918431"
};
firebase.initializeApp(config);

function httpGetAsync(theUrl, callback) {
  var xmlHttp = new XMLHttpRequest();
  xmlHttp.onreadystatechange = function() {
    if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
      callback(xmlHttp.responseText);
  }
  xmlHttp.open("GET", theUrl, true);
  xmlHttp.send(null);
}

function httpPostAsync(theUrl, type, data, callback) {
  var xmlHttp = new XMLHttpRequest();
	if (callback) {
		xmlHttp.onreadystatechange = function() {
	    if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
	      callback(xmlHttp.responseText);
	  }
	}
	xmlHttp.open("POST", theUrl, true);
	xmlHttp.setRequestHeader('Content-Type', type);
  xmlHttp.send(data);
}