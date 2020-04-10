(cl:defpackage :sokob-ant
  (:use :cl)
  (:export sokob-ant))

(cl:in-package :sokob-ant)


;; constants
(defvar *canvas-width* 800)
(defvar *canvas-height* 600)
(defvar *title* "Sokob-Ant")
(defvar *stepsize* 5)

;; colors
(defvar *menu-button-stroke-color* (gamekit:vec4 0 0 0 1.0))
(defvar *menu-button-color* (gamekit:vec4 0.8 0.4 0.1 0.8))
(defvar *menu-text-color* (gamekit:vec4 0.1 0.7 0.7 1.0))

;; state variables
(defvar *level-time* 0)
(defvar *level-steps* 0)
;;
;; register assets
;;
(gamekit:register-resource-package :keyword
				   (asdf:system-relative-pathname :sokob-ant "assets/"))

;; image assets
(gamekit:define-image :rock "graphics/rock.png")
(gamekit:define-image :default-leaf "graphics/default_leaf.png")
(gamekit:define-image :player-ant "graphics/default_ant.png")
(gamekit:define-image :bg-dirt "graphics/bg_dirt.png")

;; sound assets
(gamekit:define-sound :step-sound "sounds/default_steps.wav")


;;
;; init game
;;

(gamekit:defgame sokob-ant () ()
		 (:viewport-width *canvas-width*)
		 (:viewport-height *canvas-height*)
		 (:viewport-title *title*))

(defmethod gamekit:post-initialize ((app sokob-ant))
  (init-controls))

(defun draw-main-menu ()
  (draw-background *canvas-width* *canvas-height* 0 0)
  (gamekit:draw-rect (gamekit:vec2 (- (/ *canvas-width* 2) 50)
				   (* (/ *canvas-height* 4) 3))
		     100
		     50
		     :fill-paint *menu-button-color*
		     :stroke-paint *menu-button-stroke-color*)
  (gamekit:draw-text "Play" (gamekit:vec2 (- (/ *canvas-width* 2) 50)
					  (* (/ *canvas-height* 4) 3)))
  (gamekit:draw-rect (gamekit:vec2 (- (/ *canvas-width* 2) 50)
  				   (* (/ *canvas-height* 4) 2))
  		     100
  		     50
  		     :fill-paint *menu-button-color*
  		     :stroke-paint *menu-button-stroke-color*)
  (gamekit:draw-text "Exit" (gamekit:vec2 (- (/ *canvas-width* 2) 50)
  					  (* (/ *canvas-height* 4) 2))))

(defun handle-main-menu ())

(defun draw-level ()
  (draw-background *canvas-width* *canvas-height* 0 0)
  (gamekit:scale-canvas 2.0 2.0)
  (gamekit:draw-image *player-position* :player-ant)
  (gamekit:scale-canvas 2.0 2.0)
  (gamekit:draw-image (gamekit:vec2 50 25) :default-leaf)
  (gamekit:draw-image (gamekit:vec2 150 25) :rock))

(defun draw-background (width height pos-x pos-y)
  (gamekit:scale-canvas 4.0 4.0)
  (gamekit:draw-image (gamekit:vec2 pos-x pos-y) :bg-dirt)
  (gamekit:scale-canvas 0.25 0.25)
  (if (< (* 4 128) width)
      (draw-background (- width (* 4 128)) height 128 pos-y))
  (if (< (* 4 128) height)
      (draw-background width (- height (* 4 128)) pos-x 128)))

(defvar *main-menu-state* (list :main-menu #'draw-main-menu #'handle-main-menu))
(defvar *level-state* (list :level #'draw-level #'handle-player-move))
(defvar *game-state* *main-menu-state*) ;; :level, :paused

(defmethod gamekit:draw ((app sokob-ant))
  (funcall (cadr *game-state*)))

(defmethod gamekit:act ((app sokob-ant))
  (funcall (caddr *game-state*)))
