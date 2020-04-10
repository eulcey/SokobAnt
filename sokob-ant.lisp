(cl:defpackage :sokob-ant
  (:use :cl)
  (:export sokob-ant))

(cl:in-package :sokob-ant)


;; constants
(defvar *canvas-width* 800)
(defvar *canvas-height* 600)
(defvar *title* "Sokob-Ant")

;; state variables
(defvar *player-position* (gamekit:vec2 0 0))
(defvar *level-time* 0)
(defvar *level-steps* 0)

;; register assets
(gamekit:register-resource-package :keyword
				   (asdf:system-relative-pathname :sokob-ant "assets/"))

(gamekit:define-image :player-ant "graphics/default_ant.png")
(gamekit:define-sound :step-sound "sounds/step_sound.wav")


;; init game

(gamekit:defgame sokob-ant () ()
		 (:viewport-width *canvas-width*)
		 (:viewport-height *canvas-height*)
		 (:viewport-title *title*))

;; (defmethod gamekit:post-initialze ((app sokob-ant))
;;   )
