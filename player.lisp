(in-package :sokob-ant)

;; (defclass player-ant ())

(defvar *player-position* (gamekit:vec2 0 0))
(defvar *pressed-directions* (list nil nil nil nil))


(defun init-controls ()
  (gamekit:bind-button :up :pressed (lambda () (setf (car *pressed-directions*) t)))
  (gamekit:bind-button :up :released (lambda () (setf (car *pressed-directions*) nil)))
  (gamekit:bind-button :down :pressed (lambda () (setf (cadr *pressed-directions*) t)))
  (gamekit:bind-button :down :released (lambda () (setf (cadr *pressed-directions*) nil)))
  (gamekit:bind-button :right :pressed (lambda () (setf (caddr *pressed-directions*) t)))
  (gamekit:bind-button :right :released (lambda () (setf (caddr *pressed-directions*) nil)))
  (gamekit:bind-button :left :pressed (lambda () (setf (cadddr *pressed-directions*) t)))
  (gamekit:bind-button :left :released (lambda () (setf (cadddr *pressed-directions*) nil))))

(defun handle-player-move ()
    (if (car *pressed-directions*)
      (player-move 0 *stepsize*)
      (if (cadr *pressed-directions*)
	  (player-move 0 (- *stepsize*))
	  (if (caddr *pressed-directions*)
	      (player-move *stepsize* 0)
	      (if (cadddr *pressed-directions*)
		  (player-move (- *stepsize*) 0)
		  (gamekit:stop-sound :step-sound))))))

(defun player-move (delta-x delta-y)
  (setf (gamekit:x *player-position*) (+ (gamekit:x *player-position*) delta-x))
  (setf (gamekit:y *player-position*) (+ (gamekit:y *player-position*) delta-y))
  (gamekit:play-sound :step-sound :looped-p t))

