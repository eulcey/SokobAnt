(cl:in-package :sokob-ant)

(defvar *first-level*
  (list
   (list :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall) 
   (list :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall) 
   (list :inner-wall :inner-wall :inner-corner :straight-wall :straight-wall :straight-wall :straight-wall :straight-wall :straight-wall :straight-wall :straight-wall :straight-wall :straight-wall :inner-corner :inner-wall :inner-wall) 
   (list :inner-wall :inner-wall :straight-wall :free :straight-wall :straight-wall :free :free :free :free :free :free :free :straight-wall :inner-wall :inner-wall) 
   (list :inner-wall :inner-wall :straight-wall :free :straight-wall :straight-wall :free :free :free :free :free :free :free :straight-wall :inner-wall :inner-wall) 
   (list :inner-wall :inner-wall :straight-wall :free :free :free :free :free :free :free :free :free :free :straight-wall :inner-wall :inner-wall) 
   (list :inner-wall :inner-wall :straight-wall :free :free :free :free :free :free :free :free :free :free :straight-wall :inner-wall :inner-wall) 
   (list :inner-wall :inner-wall :straight-wall :free :free :free :free :free :free :free :free :free :free :straight-wall :inner-wall :inner-wall) 
   (list :inner-wall :inner-wall :straight-wall :free :free :free :free :free :free :free :free :free :free :straight-wall :inner-wall :inner-wall) 
   (list :inner-wall :inner-wall :straight-wall :free :free :free :free :free :free :free :free :free :free :straight-wall :inner-wall :inner-wall) 
   (list :inner-wall :inner-wall :straight-wall :free :free :free :free :free :free :free :free :free :free :straight-wall :inner-wall :inner-wall) 
   (list :inner-wall :inner-wall :straight-wall :free :free :free :free :free :free :free :free :free :free :straight-wall :inner-wall :inner-wall) 
   (list :inner-wall :inner-wall :inner-corner :straight-wall :straight-wall :straight-wall :straight-wall :straight-wall :straight-wall :straight-wall :straight-wall :inner-corner :inner-wall :inner-wall :inner-wall :inner-wall) 
   (list :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall) 
   (list :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall :inner-wall)))

(defun draw-tile (tile position rotation)
  (gamekit:scale-canvas 2.0 2.0)
  (gamekit:rotate-canvas rotation)
  (gamekit:draw-image position tile)
  (gamekit:rotate-canvas (- rotation))
  (gamekit:scale-canvas 0.5 0.5))

(defun get-tile (level position)
  (nth (round (gamekit:x position))
       (nth (round (gamekit:y position)) level)))

(defun test-object-position (item position)
  (case (car item)
    (:rock
     (and (eql (gamekit:x position) (gamekit:x (cdr item)))
	  (eql (gamekit:y position) (gamekit:y (cdr item)))))
    (:default-leaf
     (or
      (and (eql (gamekit:x position) (gamekit:x (cdr item)))
	   (eql (gamekit:y position) (gamekit:y (cdr item))))
      (and (eql (gamekit:x position) (1+ (gamekit:x (cdr item))))
	   (eql (gamekit:y position) (gamekit:y (cdr item))))
      (and (eql (gamekit:x position) (gamekit:x (cdr item)))
	   (eql (gamekit:y position) (1+ (gamekit:y (cdr item)))))
      (and (eql (gamekit:x position) (1+ (gamekit:x (cdr item))))
	   (eql (gamekit:y position) (1+ (gamekit:y (cdr item)))))))))

(defun pos-is-free (level position)
  (and (eq (get-tile level position) :free)
       (not (some (lambda (item)
		    (test-object-position item position))
		  *items*))))

(defun object-front-pushable (x y)
  (let ((obj (mapcan (lambda (item)
		       (and (test-object-position item (gamekit:vec2 x y))
			    (list item)))
		     *items*)))
    (car obj)))

(defun draw-all-tiles (tiles actual-position max-size)
  (if (< (gamekit:x actual-position) (gamekit:x max-size))
      (let ((new-pos (gamekit:vec2 (1+ (gamekit:x actual-position)) (gamekit:y actual-position)))
	    (screen-pos (gamekit:vec2 (* (gamekit:x actual-position) 32)
				      (* (gamekit:y actual-position) 32)))
	    (tile-to-draw (get-tile tiles actual-position)))
	(when (and tile-to-draw (not (eql tile-to-draw :free)))
	  (draw-tile tile-to-draw screen-pos 0))
	(draw-all-tiles tiles new-pos max-size))
      (if (< (gamekit:y actual-position) (gamekit:y max-size))
	  (let ((new-pos (gamekit:vec2 0
				       (1+ (gamekit:y actual-position)))))
	    (draw-all-tiles tiles new-pos max-size)))))

(defun draw-level-walls (level)
  (let ((level-height (length level))
	(level-width (length (car level))))
    (draw-all-tiles level (gamekit:vec2 0 0) (gamekit:vec2 level-width level-height))))

