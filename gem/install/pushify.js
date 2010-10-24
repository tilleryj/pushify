var Pushify = (function() {
	var root = window.location.protocol + "//" + window.location.host;
	
	var strip = function(str) {
	    return str.replace(/^\s+/, '').replace(/\s+$/, '');
	};

	var handleCssFile = function(file) {
		var links = document.getElementsByTagName("link");
		var css = "/stylesheets" + file;
		for (var i=0, length=links.length; i<length; i++) {
			var l = links[i];
			var link = strip(l.href).toLowerCase();

			var compare = link.indexOf(root) >= 0 ? root + css : css;
			if (link == compare || link.indexOf(compare + "?") >= 0) {
				l.href = compare + "?" + Math.random();
			}
		}
	};

	var handleImageFile = function(file) {
		var images = document.getElementsByTagName("img");
		var imgSrc = "/images" + file;
		for (var i=0, length=images.length; i<length; i++) {
			var img = images[i];
			var src = strip(img.src).toLowerCase();

			var compare = src.indexOf(root) >= 0 ? root + imgSrc : imgSrc;
			if (src == compare || src.indexOf(compare + "?") >= 0) {
				img.src = compare + "?" + Math.random();
			}
		}
	};
	
	var handleJsFile = function(file) {
		var scripts = document.getElementsByTagName("script");
		var scriptSrc = "/javascripts" + file;
		for (var i=0, length=scripts.length; i<length; i++) {
			var script = scripts[i];
			var src = strip(script.src).toLowerCase();

			var compare = src.indexOf(root) >= 0 ? root + scriptSrc : scriptSrc;
			if (src == compare || src.indexOf(compare + "?") >= 0) {
				var newScript = document.createElement("script");
				newScript.src = compare + "?" + Math.random();
				script.parentNode.replaceChild(newScript, script);
			}
		}
	};
	
	
	return {
		touch: function(files) {

			for (var i=0, length=files.length; i<length; i++) {
				var file = strip(files[i]).toLowerCase();
				if (file.match(/\.css($|\?)/)) {
					handleCssFile(file);
				} else if (file.match(/\.js($|\?)/)) {
					handleJsFile(file);
				} else {
					handleImageFile(file);
				}
			}
		}
	};
})();
