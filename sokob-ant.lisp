(cl:in-package :sokob-ant)


;; constants
(defvar *canvas-width* 1024)
(defvar *canvas-height* 1024)
(defvar *title* "Sokob-Ant")
(defvar *stepsize* 5)
(defvar *tile-size* 32)

;; colors
(defvar *menu-button-stroke-color* (gamekit:vec4 0 0 0 1.0))
(defvar *menu-button-color* (gamekit:vec4 0.8 0.4 0.1 0.8))
(defvar *menu-text-color* (gamekit:vec4 0.1 0.7 0.7 1.0))
(defvar *menu-button-color-selected* (gamekit:vec4 0.7 0.6 0.2 1))
(defvar *menu-text-color-selected* (gamekit:vec4 0.2 0.5 0.5 1.0))
(defvar *ingame-menu-background-color* (gamekit:vec4 0.7 0.7 0.7 0.5))

;; state variables
(defvar *current-level* nil)
(defvar *level-time* 0)
(defvar *level-steps* 0)

(defvar *items* (list
	       (cons :default-leaf (gamekit:vec2 4 4))
	       (cons :rock (gamekit:vec2 3 3))))

(defvar *main-menu-state* (list)) 
(defvar *level-state* (list)) 
(defvar *game-state* *main-menu-state*) ;; :level, :paused
(defvar *selected-option* nil)

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
(gamekit:define-image :straight-wall "graphics/straight_wall.png")
(gamekit:define-image :outer-corner "graphics/outer_corner_wall.png")
(gamekit:define-image :inner-corner "graphics/inner_corner_wall.png")
(gamekit:define-image :inner-wall "graphics/inner_wall.png")

;; sound assets
(gamekit:define-sound :step-sound "sounds/default_steps.wav")

;; font assets
(gamekit:define-font :menu-font "fonts/courier_prime_bold.ttf")
;; (defvar *main-font* (gamekit:make-font 'menu-font 18))
;;

;; init game
;;

(gamekit:defgame sokob-ant () ()
		 (:viewport-width *canvas-width*)
		 (:viewport-height *canvas-height*)
		 (:viewport-title *title*))

(defmethod gamekit:post-initialize ((app sokob-ant))
  (init-controls))

(defun draw-button (text mid-x mid-y &key (selected nil))
  (let* ((width 100)
  	 (height 50)
  	 (trans-x (- mid-x (/ width 2)))
  	 (trans-y (- mid-y (/ height 2)))
  	 (main-font (gamekit:make-font :menu-font 24))
  	 (text-bounds (multiple-value-list (gamekit:calc-text-bounds text main-font)))
  	 (text-width (cadr text-bounds))
  	 (text-height (caddr text-bounds))
  	 (text-x (/ (- width text-width) 2))
  	 (text-y (/ (- height text-height) 2))
	 )
    (gamekit:translate-canvas trans-x trans-y)
    (gamekit:draw-rect (gamekit:vec2 0 0) width height
  		       :fill-paint (if selected
					 *menu-button-color-selected*
					 *menu-button-color*)
  		       :stroke-paint (if selected
					 *menu-button-color*
					 *menu-button-stroke-color*))
    (gamekit:draw-text text (gamekit:vec2 text-x text-y)
		       :font main-font
		       :fill-color (if selected
				       *menu-text-color-selected*
				       *menu-text-color*))
    (gamekit:translate-canvas (- trans-x) (- trans-y))))


(defun draw-main-menu (level)
  (draw-background *canvas-width* *canvas-height* 0 0)
  (let* ((text "Sokob-Ant")
	 (title-font (gamekit:make-font :menu-font 35))
  	 (text-bounds (multiple-value-list (gamekit:calc-text-bounds text title-font)))
   	 (text-width (cadr text-bounds))
  	 (text-height (caddr text-bounds)))
    (gamekit:draw-text text (gamekit:vec2 (/ (- *canvas-width* text-width) 2)
					  (/ (- *canvas-height* text-height) 2))
		       :font title-font))
  (draw-button "Play" (/ *canvas-width* 2) (* (/ *canvas-height* 4) 3)
	       :selected (equal *selected-option* :start-level))
  (draw-button "Exit" (/ *canvas-width* 2) (* (/ *canvas-height* 4) 2)
	       :selected (equal *selected-option* :exit-game)))

(defun draw-ingame-menu (level)
  (draw-gamefield level)
  (gamekit:draw-rect (gamekit:vec2 0 0) *canvas-width* *canvas-height*
		     :fill-paint *ingame-menu-background-color*)
  (let* ((text "Sokob-Ant")
	 (title-font (gamekit:make-font :menu-font 35))
  	 (text-bounds (multiple-value-list (gamekit:calc-text-bounds text title-font)))
   	 (text-width (cadr text-bounds))
  	 (text-height (caddr text-bounds)))
    (gamekit:draw-text text (gamekit:vec2 (/ (- *canvas-width* text-width) 2)
					  (- *canvas-height* 30))
		       :font title-font))
  (draw-button "Continue" (/ *canvas-width* 2) (* (/ *canvas-height* 4) 3)
	       :selected (equal *selected-option* :continue))
  (draw-button "Exit to Main Menu" (/ *canvas-width* 2) (* (/ *canvas-height* 4) 2)
	       :selected (equal *selected-option* :exit-to-menu)))
 
(defun handle-paused-menu (level)
   (if (car *pressed-directions*)
      (setf *selected-option* :continue)
      (if (cadr *pressed-directions*)
	  (setf *selected-option* :exit-to-menu)
	  (when *pressed-enter*
	    (case *selected-option*
	      (:continue (start-level))
	      (:exit-to-menu (exit-to-menu)))
	    (setf *pressed-enter* nil)))))

(defun handle-main-menu (level)
  (if (car *pressed-directions*)
      (setf *selected-option* :start-level)
      (if (cadr *pressed-directions*)
	  (setf *selected-option* :exit-game)
	  (when *pressed-enter*
	    (case *selected-option*
	      (:start-level (start-level))
	      (:exit-game (exit-game)))
	    (setf *pressed-enter* nil)))))

(defun draw-object (object position)
  (gamekit:translate-canvas (gamekit:x position) (gamekit:y position))
  (gamekit:scale-canvas 2.0 2.0)
  (gamekit:draw-image (gamekit:mult position *tile-size*) object)
  (gamekit:scale-canvas 0.5 0.5)
  (gamekit:translate-canvas (- (gamekit:x position)) (- (gamekit:y position))))

(defun draw-items (level items)
  (mapcar (lambda (item)
	    (draw-object (car item) (cdr item)))
	  items))

(defun draw-gamefield (level)
  (draw-background *canvas-width* *canvas-height* 0 0)
  (draw-level-walls level) 
  (let ((rotation (case *last-direction*
		    (:up 0)
		    (:down 3.1415)
		    (:left 1.5758)
		    (:right 4.7173))))
    (draw-player rotation *player-position*))
  (draw-items level *items*))


(defun draw-background (width height pos-x pos-y &key (tile nil))
  (gamekit:scale-canvas 4.0 4.0)
  (if tile
      (gamekit:draw-image (gamekit:vec2 pos-x pos-y) tile)
      (gamekit:draw-rect (gamekit:vec2 pos-x pos-y) *tile-size* *tile-size*
			 :fill-paint (gamekit:vec4 0.1 0.1 0.1 0.1)))
  (gamekit:scale-canvas 0.25 0.25)
  (if (< (* 4 *tile-size*) width)
      (draw-background (- width (* 4 *tile-size*)) height *tile-size* pos-y))
  (if (< (* 4 *tile-size*) height)
      (draw-background width (- height (* 4 *tile-size*)) pos-x *tile-size*)))

(setf *main-menu-state* (list :main-menu #'draw-main-menu #'handle-main-menu))
(setf *level-state* (list :level #'draw-gamefield #'handle-player-move))
(setf *paused-state* (list :paused #'draw-ingame-menu #'handle-paused-menu))

(setf *game-state* *main-menu-state*) ;; :level, :paused
(setf *current-level* *first-level*)
(setf *selected-option* :start-level)

(defun start-level ()
  (setf *game-state* *level-state*))

(defun start-game ()
  (gamekit:start 'sokob-ant))

(defun exit-to-menu ()
  (setf *game-state* *main-menu-state*))

(defun exit-game ()
  (gamekit:stop))

(defmethod gamekit:draw ((app sokob-ant))
  (funcall (cadr *game-state*) *current-level*))

(defmethod gamekit:act ((app sokob-ant))
  (funcall (caddr *game-state*) *current-level*))
