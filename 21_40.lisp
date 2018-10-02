(defun insert-at (el lst n)
  (labels ((insloop (el lst n index collect)
	     (if (= n index)
		 (append (reverse collect)
			 (cons el lst))
		 (insloop el (cdr lst) n (+ 1 index)
			  (cons (car lst) collect)))))
    (insloop el lst n 1 '())))

		 


(defun test-equal (name result expected)
  (format t "~a: ~a" name (if (equal result expected)
			        (format nil "PASS~%")
				(format nil "FAIL ~%~a not equal~%~a~%"
					result expected))))

(defun test-nequal (name result expected)
  (format t "~a: ~a" name (if (not (equal result expected))
			        (format nil "PASS~%")
				(format nil "FAIL ~%~a does equal~%~a~%"
					result expected))))

;;;; test defs
(defun run-tests ()
  (let ((test-val '(a b c d))
	(expected '(A ALFA B C D)))
    (test-equal "Insert alfa at 2nd index" 
		(insert-at 'alfa test-val 2) expected)))
