# Pushify = way faster CSS development
See updates you make to css files appear immediately in all of your browsers without having to refresh them.

If you've ever spent more than 5 minutes making changes to a css file you should really love this tool. Pushify instruments your application in development mode with pushify.js. It then creates a socket connection from your browser back to the pushify server with the help of juggernaut. When you save a css file, pushify notifies your browser (or browsers) and reloads only that file. This makes style changes appear in your browser almost instantly, letting you develop your stylesheets way faster.

# Installation

	# Install the gem
	sudo gem install pushify
	# Install pushify into your rails app and start the pushify server
	pushify install

# Starting and stopping the pushify server
	# Start the server with pushify start
	pushify start
	# Stop the server with pushify stop
	pushify stop

# That's it
That's it.  Load your app in a browser and update the CSS file in your editor.

Now open up a different browser and update the CSS.  Now you can watch the effect of your CSS updates on multiple browsers without refreshing.

# Future
There are two big sets of improvements that need to be made to pushify.

1. Support for more frameworks
2. The ability to auto-update more than just CSS. Pushify actually already supports image file updates, but it will be really cool when it supports js and html changes.

_Check the issues list for specific tasks_

# Limitations
* Not tested on windows
* Currently only compatible with rails

# Authors
* Jason Tillery
* Vishu Ramanathan

