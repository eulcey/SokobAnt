(asdf:defsystem :sokob-ant
  :description "Sokoban-Style game with Ants"
  :version "0.0.3"
  :depends-on (trivial-gamekit)
  :components ((:file "packages")
	       (:file "constants")
	       (:file "player")
	       (:file "level")
	       (:file "level-definitions-2")
	       (:file "level-definitions")
	       (:file "sokob-ant")))
