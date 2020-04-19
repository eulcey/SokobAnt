Sokob-Ant Game
=========================

The Game
-----------
A Sokoban style game for the Lisp Game Jam Spring 2020.
https://itch.io/jam/spring-lisp-game-jam-2020


Building and Running the Game
-------------------------------

Running from the REPL:
	(ql:quickload :trivial-gamekit/distribution)
	(asdf:load-system "game")
	(in-package :sokob-ant)
	(start-game)

Building the game from the REPL:
	(ql:quickload :trivial-gamekit/distribution)
	(asdf:load-system "game")
	(gamekit.distribution:deliver :game 'package-name:game)

Controls
-----------

Controls are Keyboard only.
Arrow keys:
	Selecting options and moving the character
	
R:
	Restarting a level
	
Enter:
	Choosing the selected option
	
Esc:
	Showing the Menu


Used Libraries
--------------

Trivial-Gamekit
https://borodust.github.io/projects/trivial-gamekit/
