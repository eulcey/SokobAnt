(cl:in-package :sokob-ant)

(defun set-level-6-items ()
  (setf *items* (list
		 (list 0 :default-leaf (list (gamekit:vec2 3 6) (gamekit:vec2 4 6)
					     (gamekit:vec2 3 7) (gamekit:vec2 4 7)))
		 (list 1 :aphid (list (gamekit:vec2 11 7)))
		 (list 2 :rock (list (gamekit:vec2 10 7)))
		 (list 3 :twig (list (gamekit:vec2 5 8) (gamekit:vec2 5 9)))
		 (list 4 :twig (list (gamekit:vec2 7 7) (gamekit:vec2 7 8)))
		 (list 5 :twig (list (gamekit:vec2 8 6) (gamekit:vec2 8 7)))))
  (setf *player-position* (gamekit:vec2 3 3))
  (setf *last-direction* :up))

(defun get-level-6-targets ()
  (list (list 1 :ant-hole (list (gamekit:vec2 3 3)))
	(list 2 :big-ant-hole (list (gamekit:vec2 11 3) (gamekit:vec2 11 4)
				    (gamekit:vec2 12 3) (gamekit:vec2 12 4)))))

(defun get-level-6 ()
  (list (list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-CORNER  *rotate-90-left*) (CONS :STRAIGHT-WALL  *rotate-90-left*)
	      (CONS :inner-corner *rotate-180*)  (cons :inner-wall 0)(CONS :inner-corner *rotate-90-left*) 
	      (CONS :STRAIGHT-WALL  *rotate-90-left*) (CONS :STRAIGHT-WALL  *rotate-90-left*) (CONS :STRAIGHT-WALL  *rotate-90-left*)
	      (CONS :STRAIGHT-WALL  *rotate-90-left*) (CONS :STRAIGHT-WALL  *rotate-90-left*) (CONS :STRAIGHT-WALL  *rotate-90-left*)
	      (CONS :INNER-CORNER  *rotate-180*) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :STRAIGHT-WALL  *rotate-180*) (cons :inner-wall 0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :STRAIGHT-WALL  *rotate-180*) (cons :inner-wall 0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :outer-corner *rotate-180*) (cons :straight-wall *rotate-90-left*) (CONS :outer-corner *rotate-90-left*) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	
	
	(list (CONS :INNER-WALL  0) (CONS :INNER-corner *rotate-90-left*) (CONS :outer-corner *rotate-90-left*) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :straight-wall 0) (CONS :free 0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0) (cons :free 0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))

	
	(list (CONS :INNER-WALL  0) (CONS :INNER-corner 0) (CONS :outer-corner 0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :outer-corner *rotate-90-right*) (CONS :straight-wall *rotate-90-right*) (CONS :straight-wall *rotate-90-right*)
	      (CONS :straight-wall *rotate-90-right*) (CONS :straight-wall *rotate-90-right*) (CONS :straight-wall *rotate-90-right*) (CONS :inner-corner *rotate-90-right*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))

	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :straight-wall *rotate-180*) (CONS :inner-wall 0) (CONS :inner-wall 0)
	      (CONS :inner-wall 0) (CONS :inner-wall 0) (CONS :inner-wall 0) (CONS :inner-wall 0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :straight-wall *rotate-180*)  (CONS :inner-wall 0) (CONS :inner-wall 0)
	       (CONS :inner-wall 0) (CONS :inner-wall 0)  (CONS :inner-wall 0) (CONS :inner-wall 0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-CORNER  0) (CONS :STRAIGHT-WALL  *rotate-90-right*)
	      (CONS :STRAIGHT-WALL  *rotate-90-right*) (CONS :STRAIGHT-WALL  *rotate-90-right*) (CONS :STRAIGHT-WALL  *rotate-90-right*)
	      (CONS :inner-corner *rotate-90-right*) 	(CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)    (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))))

