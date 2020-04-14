(cl:in-package :sokob-ant)

(defun draw-tile (tile position rotation)
  (let ((real-x (+ (* *tile-size* (gamekit:x position)) 16))
	(real-y (+ (* *tile-size* (gamekit:y position)) 16)))
    (gamekit:scale-canvas 2.0 2.0)
    (gamekit:translate-canvas real-x real-y )
    (gamekit:rotate-canvas rotation)
    (gamekit:draw-image (gamekit:vec2 -16 -16) tile)
    (gamekit:rotate-canvas (- rotation))
    (gamekit:translate-canvas (- real-x) (- real-y))
    (gamekit:scale-canvas 0.5 0.5)))


  ;; (gamekit:scale-canvas 2.0 2.0)
  ;; (gamekit:translate-canvas (gamekit:x position) (gamekit:y position))
  ;; (gamekit:rotate-canvas rotation)
  ;; (gamekit:draw-image (gamekit:vec2 0 0) tile)
  ;; (gamekit:rotate-canvas (- rotation))
  ;; (gamekit:translate-canvas (- (gamekit:x position)) (- (gamekit:y position)))
  ;; (gamekit:scale-canvas 0.5 0.5))

(defun get-tile (level position)
  (car (nth (round (gamekit:x position))
	    (nth (round (gamekit:y position)) level))))

(defun get-tile-rotation (level position)
  (cdr  (nth (round (gamekit:x position))
	    (nth (round (gamekit:y position)) level))))

(defun all-tiles-free (level positions)
  (every (lambda (pos)
	   (eql :free (get-tile level pos)))
	 positions))

(defun get-object-position (object)
  (caddr object))

(defun get-object-type (object)
  (cadr object))

(defun get-object-id (object)
  (car object))

(defun object-on-position (item position)
  (labels ((test-recur (obj-positions position)
	     (if (not obj-positions)
		 nil
		 (let ((obj-x (gamekit:x (car obj-positions)))
		       (obj-y (gamekit:y (car obj-positions))))
		   (if (and (= obj-x (gamekit:x position))
			    (= obj-y (gamekit:y position)))
		       t
		       (test-recur (cdr obj-positions) position))))))
    (test-recur (get-object-position item) position)))

(defun another-object-on-same-tile (object items)
  (some (lambda (item)
	  (and (not (= (get-object-id object) (get-object-id item)))
	       (some (lambda (obj-position)
		       (object-on-position item obj-position))
		     (get-object-position object))))
	items))

(defun get-object (items position)
  (if (not items)
      nil
      (if (object-on-position (car items) position)
	  (car items)
	  (get-object (cdr items) position))))

(defun calc-new-obj-pos (object push-vector)
  (mapcar (lambda (pos) (gamekit:add push-vector pos)) (get-object-position object)))

(defun draw-all-tiles (tiles actual-position max-size)
  (if (< (gamekit:x actual-position) (gamekit:x max-size))
      (let ((new-pos (gamekit:vec2 (1+ (gamekit:x actual-position)) (gamekit:y actual-position)))
	    ;; (screen-pos (gamekit:vec2 (* (gamekit:x actual-position) 32)
	    ;; 			      (* (gamekit:y actual-position) 32)))
	    (tile-to-draw (get-tile tiles actual-position))
	    (tile-rotation (get-tile-rotation tiles actual-position)))
	(when (and tile-to-draw (not (eql tile-to-draw :free)))
	  ;; (draw-tile tile-to-draw screen-pos tile-rotation))
	  (draw-tile tile-to-draw actual-position tile-rotation))
	(draw-all-tiles tiles new-pos max-size))
      (if (< (gamekit:y actual-position) (gamekit:y max-size))
	  (let ((new-pos (gamekit:vec2 0
				       (1+ (gamekit:y actual-position)))))
	    (draw-all-tiles tiles new-pos max-size)))))

(defun draw-level-walls (level)
  (let ((level-height (length level))
	(level-width (length (car level))))
    (draw-all-tiles level (gamekit:vec2 0 0) (gamekit:vec2 level-width level-height))))

