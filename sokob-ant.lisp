(cl:in-package :sokob-ant)


;; colors
(defvar *menu-button-stroke-color* (gamekit:vec4 0 0 0 1.0))
(defvar *menu-button-color* (gamekit:vec4 0.7 0.6 0.2 0.8))
(defvar *menu-text-color* (gamekit:vec4 0.1 0.7 0.7 1.0))
(defvar *menu-button-color-selected* (gamekit:vec4 0.8 0.4 0.1 1))
(defvar *menu-text-color-selected* (gamekit:vec4 0.2 0.5 0.5 1.0))
(defvar *ingame-menu-background-color* (gamekit:vec4 0.7 0.7 0.7 0.5))
(defvar *top-banner-color* (gamekit:vec4 0.18 0.44 0.29 1))
(defvar *top-border-color* (gamekit:vec4 0 0 0 1))

;; state variables
(defvar *current-level* nil)
;;(defvar *current-items-fun* nil)
(defvar *current-targets* nil)
(defvar *level-time* 0)
(defvar *level-steps* 0)

(defvar *items* nil)
(defvar *state-stack* '())

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
(gamekit:define-image :twig "graphics/twig.png")
(gamekit:define-image :aphid "graphics/aphid.png")
(gamekit:define-image :ant-hole "graphics/ant_hole.png")
(gamekit:define-image :big-ant-hole "graphics/big_ant_hole.png")
(gamekit:define-image :title-pic "graphics/title.png")

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
  (init-controls)
  (setf *current-level* (get-level-list)))

(defun draw-button (text mid-x mid-y &key (selected nil))
  (let* ((width 300)
  	 (height 100)
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


(defun draw-main-menu (level items targets)
  (draw-background *canvas-width* *canvas-height* 0 0)
  (gamekit:draw-image (gamekit:vec2 0 0) :title-pic)
  (let* ((text "Sokob-Ant")
	 (title-font (gamekit:make-font :menu-font 35))
  	 (text-bounds (multiple-value-list (gamekit:calc-text-bounds text title-font)))
   	 (text-width (cadr text-bounds))
  	 (text-height (caddr text-bounds)))
    (gamekit:draw-text text (gamekit:vec2 (/ (- *canvas-width* text-width) 2)
					  (- *canvas-height* (+ text-height 20)))
		       :font title-font))
  (draw-button "Play" (/ *canvas-width* 2) (* (/ *canvas-height* 4) 3)
	       :selected (equal *selected-option* :start-level))
  (draw-button "Exit" (/ *canvas-width* 2) (* (/ *canvas-height* 4) 2)
	       :selected (equal *selected-option* :exit-game)))

(defun draw-ingame-menu (level items targets)
  (draw-gamefield level items targets)
  (gamekit:draw-rect (gamekit:vec2 0 0) *canvas-width* *canvas-height*
		     :fill-paint *ingame-menu-background-color*)
  (let* ((text "Sokob-Ant")
	 (title-font (gamekit:make-font :menu-font 35))
  	 (text-bounds (multiple-value-list (gamekit:calc-text-bounds text title-font)))
   	 (text-width (cadr text-bounds))
  	 (text-height (caddr text-bounds)))
    (gamekit:draw-text text (gamekit:vec2 (/ (- *canvas-width* text-width) 2)
					  (- *canvas-height* (+ text-height 20)))
		       :font title-font))
  (draw-button "Continue" (/ *canvas-width* 2) (* (/ *canvas-height* 4) 3)
	       :selected (equal *selected-option* :continue))
  (draw-button "Exit to Main Menu" (/ *canvas-width* 2) (* (/ *canvas-height* 4) 2)
	       :selected (equal *selected-option* :exit-to-menu)))

(defun draw-result-menu (level items targets)
  (draw-gamefield level items targets)
  (gamekit:draw-rect (gamekit:vec2 0 0) *canvas-width* *canvas-height*
		     :fill-paint *ingame-menu-background-color*)
  (let* ((text "Level Completed")
	 (title-font (gamekit:make-font :menu-font 35))
  	 (text-bounds (multiple-value-list (gamekit:calc-text-bounds text title-font)))
   	 (text-width (cadr text-bounds))
  	 (text-height (caddr text-bounds)))
    (gamekit:draw-text text (gamekit:vec2 (/ (- *canvas-width* text-width) 2)
					  (- *canvas-height* (* (+ text-height 20) 2))
		       :font title-font))
  (draw-button "Next Level" (/ *canvas-width* 2) (* (/ *canvas-height* 4) 3)
	       :selected (equal *selected-option* :next-level))
  (draw-button "Exit to Main Menu" (/ *canvas-width* 2) (* (/ *canvas-height* 4) 2)
	       :selected (equal *selected-option* :exit-to-menu)))

(defun handle-paused-menu (level items targets)
   (if (car *pressed-directions*)
      (setf *selected-option* :continue)
      (if (cadr *pressed-directions*)
	  (setf *selected-option* :exit-to-menu)
	  (when *pressed-enter*
	    (case *selected-option*
	      (:continue (continue-level))
	      (:exit-to-menu (exit-to-menu)))
	    (setf *pressed-enter* nil)))))

(defun handle-result-menu (level items targets)
   (if (car *pressed-directions*)
      (setf *selected-option* :next-level)
      (if (cadr *pressed-directions*)
	  (setf *selected-option* :exit-to-menu)
	  (when *pressed-enter*
	    (case *selected-option*
	      (:next-level (set-next-level))
	      (:exit-to-menu (exit-to-menu)))
	    (setf *pressed-enter* nil)))))

(defun handle-main-menu (level items targets)
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

(defun draw-items (level items targets)
  (mapcar (lambda (target)
	    (draw-object (get-object-type target) (car (get-object-position target))))
	  targets)
  (mapcar (lambda (item)
	    (draw-object (get-object-type item) (car (get-object-position item))))
	  items))

(defun draw-top-banner (level)
  (gamekit:draw-rect (gamekit:vec2 0 (* 32 30) ) *canvas-width* (- *canvas-width* (* 32 30)) 
		     :fill-paint *top-banner-color*
		     :stroke-paint *top-border-color*)
  (let* ((text (format nil "Level ~S" (- (length (get-level-list)) (length *current-level*))))
	 (title-font (gamekit:make-font :menu-font 35))
  	 (text-bounds (multiple-value-list (gamekit:calc-text-bounds text title-font)))
   	 (text-width (cadr text-bounds))
  	 (text-height (caddr text-bounds)))
    (gamekit:draw-text text (gamekit:vec2 (/ (- *canvas-width* text-width) 2)
					  (- *canvas-height* (+ text-height 20)))
		       :font title-font)))

(defun draw-gamefield (level items targets)
  (draw-background *canvas-width* *canvas-height* 0 0 :tile :bg-dirt)
  (draw-level-walls level) 
  (draw-top-banner level)
  (draw-items level items targets)
  (let ((rotation (case *last-direction*
		    (:up 0)
		    (:down 3.1415)
		    (:left 1.5758)
		    (:right 4.7173))))
    (draw-player rotation (get-player-position *state-stack*))))

(defun draw-background (width height pos-x pos-y &key (tile nil))
  (gamekit:scale-canvas 8.0 8.0)
  (if tile
      (gamekit:draw-image (gamekit:vec2 pos-x pos-y) tile)
      (gamekit:draw-rect (gamekit:vec2 pos-x pos-y) *canvas-width* *canvas-height*
			 :fill-paint (gamekit:vec4 0.1 0.1 0.1 0.1)))
  (gamekit:scale-canvas 0.125 0.125))

(defun push-new-state (player items)
  (push (cons player items) *state-stack*))

(defun revert-one-state-stop ()
  (when (> (length *state-stack*) 1)
      (pop *state-stack*)))

(defun get-items (game-stack)
  (cdar game-stack))

(defun get-player-position (game-stack)
  (caar game-stack))

(setf *main-menu-state* (list :main-menu #'draw-main-menu #'handle-main-menu))
(setf *level-state* (list :level #'draw-gamefield #'handle-player-move))
(setf *paused-state* (list :paused #'draw-ingame-menu #'handle-paused-menu))
(setf *result-state* (list :next-level #'draw-result-menu #'handle-result-menu))

(setf *game-state* *main-menu-state*) ;; :level, :paused
(setf *selected-option* :start-level)

(defun start-level ()
  ;(setf *current-items-fun* (caar *current-level*))
  (funcall (caar *current-level*))
  (setf *current-targets* (funcall (cadar *current-level*)))
  (setf *state-stack* nil)
  (reset-positions)
  (setf *game-state* *level-state*))

(defun continue-level ()
  (setf *game-state* *level-state*))

(defun show-level-completed ()
  (setf *game-state* *result-state*))

(defun set-next-level ()
  (let ((next-level (cdr *current-level*)))
    (if next-level
	(progn
	  (setf *current-level* (cdr *current-level*))
	  (start-level))
	(exit-to-menu))))

(defun start-game ()
  (gamekit:start 'sokob-ant))

(defun exit-to-menu ()
  (setf *current-level* (get-level-list))
  (setf *game-state* *main-menu-state*))

(defun exit-game ()
  (gamekit:stop))

(defmethod gamekit:draw ((app sokob-ant))
  (funcall (cadr *game-state*) (funcall (caddar *current-level*)) (get-items *state-stack*) *current-targets*))

(defmethod gamekit:act ((app sokob-ant))
  (funcall (caddr *game-state*) (funcall (caddar *current-level*)) (get-items *state-stack*) *current-targets*))

(defun reset-positions ()
  (push-new-state *player-position* *items*))
;  (funcall *current-items-fun*))
