(cl:in-package :sokob-ant)

(defun set-first-level-items ()
  (setf *items* (list
		 (list 1 :aphid (list (gamekit:vec2 6 6)))
		 (list 2 :rock (list (gamekit:vec2 4 7)))))
  (setf *player-position* (gamekit:vec2 3 3))
  (setf *last-direction* :up))

(defun get-first-level-targets ()
  (list (list 1 :ant-hole (list (gamekit:vec2 3 3)))))

(defun get-first-level ()
  (list (list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-CORNER  0) (CONS :STRAIGHT-WALL  *rotate-90-left*)
	       (CONS :inner-corner *rotate-180*) (CONS :inner-corner *rotate-90-left*) (CONS :STRAIGHT-WALL  *rotate-90-left*)
	      (CONS :STRAIGHT-WALL  *rotate-90-left*) (CONS :STRAIGHT-WALL  *rotate-90-left*) (CONS :STRAIGHT-WALL  *rotate-90-left*)
	      (CONS :STRAIGHT-WALL  *rotate-90-left*) (CONS :STRAIGHT-WALL  *rotate-90-left*) (CONS :STRAIGHT-WALL  *rotate-90-left*)
	      (CONS :INNER-CORNER  *rotate-180*) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :outer-corner *rotate-180*) (CONS :outer-corner *rotate-90-left*) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-CORNER  0) (CONS :STRAIGHT-WALL  *rotate-90-right*)
	      (CONS :STRAIGHT-WALL  *rotate-90-right*) (CONS :STRAIGHT-WALL  *rotate-90-right*) (CONS :STRAIGHT-WALL  *rotate-90-right*)
	      (CONS :STRAIGHT-WALL  *rotate-90-right*) (CONS :STRAIGHT-WALL  *rotate-90-right*) (CONS :STRAIGHT-WALL  *rotate-90-right*)
	      (CONS :STRAIGHT-WALL  *rotate-90-right*) (CONS :STRAIGHT-WALL  *rotate-90-right*) (CONS :STRAIGHT-WALL  *rotate-90-right*) (CONS :INNER-CORNER  *rotate-90-right*)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))))

(defun set-second-level-items ()
  (setf *items* (list
		 (list 1 :default-leaf (list (gamekit:vec2 5 5) (gamekit:vec2 5 6)
					     (gamekit:vec2 6 5) (gamekit:vec2 6 6)))
		 (list 2 :rock (list (gamekit:vec2 4 7)))))
  (setf *player-position* (gamekit:vec2 7 7))
  (setf *last-direction* :up))

(defun get-second-level-targets ()
  (list (list 1 :ant-hole (list (gamekit:vec2 3 3)))
	(list 2 :ant-hole (list (gamekit:vec2 5 7)))))

(defun get-second-level ()
  (list (list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-CORNER  0) (CONS :STRAIGHT-WALL  *rotate-90-left*)
	       (CONS :inner-corner *rotate-180*) (CONS :inner-corner *rotate-90-left*) (CONS :STRAIGHT-WALL  *rotate-90-left*)
	      (CONS :STRAIGHT-WALL  *rotate-90-left*) (CONS :STRAIGHT-WALL  *rotate-90-left*) (CONS :STRAIGHT-WALL  *rotate-90-left*)
	      (CONS :STRAIGHT-WALL  *rotate-90-left*) (CONS :STRAIGHT-WALL  *rotate-90-left*) (CONS :STRAIGHT-WALL  *rotate-90-left*)
	      (CONS :INNER-CORNER  *rotate-180*) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :outer-corner *rotate-180*) (CONS :outer-corner *rotate-90-left*) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :STRAIGHT-WALL  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0)
	      (CONS :FREE  0) (CONS :FREE  0) (CONS :FREE  0) (CONS :STRAIGHT-WALL  *rotate-180*) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-CORNER  0) (CONS :STRAIGHT-WALL  *rotate-90-right*)
	      (CONS :STRAIGHT-WALL  *rotate-90-right*) (CONS :STRAIGHT-WALL  *rotate-90-right*) (CONS :STRAIGHT-WALL  *rotate-90-right*)
	      (CONS :STRAIGHT-WALL  *rotate-90-right*) (CONS :STRAIGHT-WALL  *rotate-90-right*) (CONS :STRAIGHT-WALL  *rotate-90-right*)
	      (CONS :STRAIGHT-WALL  *rotate-90-right*) (CONS :STRAIGHT-WALL  *rotate-90-right*) (CONS :STRAIGHT-WALL  *rotate-90-right*) (CONS :INNER-CORNER  *rotate-90-right*)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))
	(list (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0)
	      (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0) (CONS :INNER-WALL  0))))

