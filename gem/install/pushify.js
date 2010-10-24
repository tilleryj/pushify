var Pushify = (function() {

	return {
		touch: function(files) {
			var links = document.getElementsByTagName("link");
			var images = document.getElementsByTagName("img");
			var root = window.location.protocol + "//" + window.location.host;

			var strip = function(str) {
			    return str.replace(/^\s+/, '').replace(/\s+$/, '');
			};

			for (var i=0, length=files.length; i<length; i++) {
				var file = strip(files[i]).toLowerCase();
				if (file.match(/\.css($|\?)/)) {
					var css = "/stylesheets" + file;
					for (var j=0; j<links.length; j++) {
						var l = links[j];
						var link = strip(l.href).toLowerCase();

						var compare = link.indexOf(root) >= 0 ? root + css : css;
						if (link == compare || link.indexOf(compare + "?") >= 0) {
							l.href = compare + "?" + Math.random();
						}
					}
				} else {
					var imgSrc = "/images" + file;
					for (var j=0; j<images.length; j++) {
						var img = images[j];
						var src = strip(img.src).toLowerCase();

						var compare = src.indexOf(root) >= 0 ? root + imgSrc : imgSrc;
						if (src == compare || src.indexOf(compare + "?") >= 0) {
							img.src = compare + "?" + Math.random();
						}
					}
				}
				
			}
		}
	};

})();
