(asdf:defsystem :sokob-ant
  :description "Sokoban-Style game with Ants"
  :version "0.0.1"
  :depends-on (trivial-gamekit)
  :components ((:file "packages")
	       (:file "player")
	       (:file "level")
	       (:file "sokob-ant")))
