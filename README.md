Sokob-Ant Game
=========================

The Game
-----------
A Sokoban style game for the Lisp Game Jam Spring 2020.
https://itch.io/jam/spring-lisp-game-jam-2020


Building and Running the Game
-------------------------------

Running from the REPL:
```lisp
(require 'asdf)
(asdf:load-system "sokob-ant")
(in-package :sokob-ant)
(start-game)
```

Building the game from the REPL:
```lisp
(ql:quickload :trivial-gamekit/distribution)
(asdf:load-system "sokob-ant")
(gamekit.distribution:deliver :sokob-ant 'sokob-ant:sokob-ant)
```

Controls
-----------

Controls are Keyboard only.
Arrow keys:
	Selecting options and moving the character
	
r:
	Restarting a level

z:
	Revert one step
	
Enter:
	Choosing the selected option
	
Esc:
	Showing the Menu


Used Libraries
--------------

Trivial-Gamekit
https://borodust.github.io/projects/trivial-gamekit/
