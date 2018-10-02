(defun last-box (lst)
  "problem 01"
  (if (second lst)
      (last-box (cdr lst))
      lst))

(defun last-but-1 (lst)
  "problem 02"
  (if (third lst)
      (last-but-1 (cdr lst))
      lst))

(defun element-at (lst nth)
  "problem 03"
  (labels ((el-loop (lst nth index)
	     (cond ((and lst (equal nth index))
		    (car lst))
		   ((first lst)
		    (el-loop (cdr lst) nth (+ 1 index)))
		   (t '()))))
    (el-loop lst nth 1)))

(defun len (lst)
  "problem 04"
  (labels ((count-items (lst index)
	     (if lst
		 (count-items (cdr lst) (+ 1 index))
		 index)))
    (count-items lst 0)))
    
(defun reverse-lst (lst)
  "problem 05"
  (labels ((reverse-loop (lst result)
	     (if lst
		 (reverse-loop (cdr lst) (cons (first lst) result))
		 result)))
    (reverse-loop lst '())))

(defun palindrome? (lst)
  "problem 06"
  (equal (reverse-lst lst) lst))

(defun flatten (lst)
  "problem 07
  if there is another list in the appended list
  mapcar each item to a list so apply append is recursive
  "
  (let ((result (apply #'append lst)))
    (if (remove-if-not #'listp result)
	(flatten
	 (mapcar (lambda (x)
		   (if (listp x)
		       x
		       (list x)))
	 result))
	result)))

(defun eliminate-seq-dups (lst)
  "problem 08"
  (labels ((seq-dups-loop (lst result)
	     (if lst
		 (cond ((equal (first lst) (first result))
			(seq-dups-loop (cdr lst) result))
		       (t (seq-dups-loop (cdr lst)
					 (cons (car lst) result))))
		 (reverse result))))
    (seq-dups-loop lst '())))

(defun subseq-dups (lst)
  "problem 09"
  (labels ((seq-dups-loop (lst result)
	     (if lst
		 (cond ((equal (first lst) (caar result))
			(seq-dups-loop (cdr lst)
				       (cons (cons (first lst)
						   (car result))
					     (cdr result))))
		       (t (seq-dups-loop (cdr lst)
					 (cons (list (car lst)) result))))
		 (reverse result))))
    (seq-dups-loop lst '())))


(defun seq-dup-count (lst)
  "problem 10"
  (mapcar
   (lambda (x) (list (len x) (car x)))
   (subseq-dups lst)))
    
(defun modified-seq-dup-count (lst)
  "problem 11"
  (mapcar
   (lambda (x) (if (equal 1 (car x)) (cadr x) x))
   (seq-dup-count lst)))

(defun decode-seq-loop (n x result)
  "problem 12 helper"
  (if (> n 0) 
      (decode-seq-loop (- n 1) x (cons x result))
      result))

(defun decode-seq-dup-count (lst)
  "problem 12"
  (apply #'append (mapcar (lambda (x)
	    (if (listp x)
		(decode-seq-loop (car x) (cadr x) '())
		(list x)))
   (modified-seq-dup-count lst))))

(defun direct-subseq (lst)
  "problem 13
   recreate the modified seq dup count without
   creating sublists first
  "
  (labels ((add-pair (current result)
	     (cons (list (len current) (car current)) result))

	   (continue-loop (lst result current)
	     "cond 1: continue grouping if the next character is a match
              cond 2: a group exists, but the next character is not a match
              cond 3: the next in list has a sequential duplicates
              cond 4: the next in list has no sequential duplicates
             "
	     (cond ((and current (equal (car lst) (car current)))
		    (direct-loop (cdr lst) result (cons (car lst) current)))

		   (current (direct-loop lst (add-pair current result) '()))

		   ((equal (car lst) (cadr lst))
		    (direct-loop (cdr lst) result (cons (car lst) current)))

		   (t (direct-loop (cdr lst) (cons (car lst) result) '()))))

	   (direct-loop (lst result current)
	     (if lst
		 (continue-loop lst result current)
		 (reverse result))))

    (direct-loop lst '() '())))

(defun repeat (n val)
  (labels ((repeat-loop (n val result)
	     (if (> n 0)
		 (repeat-loop (- n 1) val (cons val result))
		 result)))
    (repeat-loop n val '())))

(defun duplicate (lst)
  "problem 14"
  (labels ((duploop (lst result)
	     (if lst
		 (let ((char (car lst)))
		   (duploop (cdr lst) (cons char (cons char result))))
		 (reverse result))))
    (duploop lst '())))

(defun replicate (lst n)
  "problem 15"
  (labels ((reploop (lst n result)
	     (if lst
		 (reploop (cdr lst) n
			  (append (repeat n (car lst)) result))
		 (reverse result))))
    (reploop lst n '())))

(defun drop-every (lst nth)
  "problem 16"
  (labels ((drop-loop (lst nth index result)
	     (cond ((and lst (equal (mod index nth) 0))
		    (drop-loop (cdr lst) nth (+ 1 index) result))
		   (lst (drop-loop (cdr lst) nth
				   (+ 1 index) (cons (car lst) result)))
		   (t (reverse result)))))
    (drop-loop lst nth 1 '())))
  

(defun split-n (lst n)
  "problem 17"
  (labels ((sploop (lst n result)
	     (if (> n 0)
		 (sploop (cdr lst) (- n 1) (cons (car lst) result))
		 (cons (reverse result) (list lst)))))
    (sploop lst n '())))

(defun slice (lst min max)
  "problem 18"
  (let ((fix-min (- min 1)))
    (car (split-n
	  (cadr (split-n lst fix-min))
	  (- max fix-min)))))

(defun rotate (lst n)
  "problem 19"
  (labels ((get-split (lst n)
	     (let ((result (split-n lst n)))
	       (append (second result) (first result)))))
    (if (> n 0)
	(get-split lst n)
	(reverse (get-split (reverse lst) (* -1 n))))))

(defun remove-nth (lst n)
  "problem 20"
  (labels ((remoop (lst n index collect)
	     (if (equal n index)
		 (append (reverse collect) (cdr lst))
		 (remoop (cdr lst) n (+ 1 index)
			 (cons (car lst) collect)))))
    (remoop lst n 1 '())))



;;; test asserts
;;; do test stuff
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
  (let ((test-val '(a b c d)))
    (test-equal "Last box is (D)" (last-box test-val) '(d))
    (test-equal "Last 2 box is (C D)" (last-but-1 test-val) '(c d))
    (test-equal "1st element is a" (element-at test-val 1) 'a)
    (test-nequal "1st element is not b" (element-at test-val 1) 'b)
    (test-equal "3rd element is c" (element-at test-val 3) 'c)
    (test-equal "4th element is d" (element-at test-val 4) 'd)
    (test-equal "Reverse list" (reverse-lst test-val) '(d c b a))
    (test-equal "Length equal" (len '()) 0)
    (test-equal "Length equal" (len test-val) 4))

  (let ((palindrome-str '(x a m a x)))
    (test-equal "Palindrome" (palindrome? palindrome-str) t)
    (test-equal "Palindrome" (palindrome? '(a)) t)
    (test-equal "Not Palindrome" (palindrome? '(a b c)) NIL))

  (let ((test-val1 '((a b c) (d e f) (g h i)))
	(test-val2 '((a (b c)) (d e f) (g h i)))
	(flat-val '(a b c d e f g h i)))
    (test-equal "List is flat" (flatten test-val1) flat-val)
    (test-equal "List is flat" (flatten test-val2) flat-val))

  (let ((test-val '(a a a b b c d d d d d e f f g)))
    (test-equal "No sequential duplicates"
		(eliminate-seq-dups test-val) '(a b c d e f g))
    (test-equal "Subsequence of sequential duplicates"
		(subseq-dups test-val)
		'((a a a) (b b) (c) (d d d d d) (e) (f f) (g)))

    (let ((seq-result (seq-dup-count test-val))
	  (modified-expected '((3 a) (2 b) c (5 d) e (2 f) g))
	  (seq-expected '((3 a) (2 b) (1 c) (5 d) (1 e) (2 f) (1 g))))
      (test-equal "First count is 3" (caar seq-result) 3)

      (test-equal "Modified subsequence dup count"
		  (modified-seq-dup-count test-val)
		  modified-expected)
      (test-equal "Decode subsequence dup count"
		  (decode-seq-dup-count test-val) test-val)
      (test-equal "Direct subsequence dup count"
		  (direct-subseq test-val) modified-expected)
      (test-equal "Subsequnce dup count"
		  (seq-dup-count test-val) seq-expected)))

  (let ((test-val '(a b c c d))
	(duplicate-expected '(a a b b c c c c d d)))
    (test-equal "Duplicate each item"
		(duplicate test-val) duplicate-expected))

  (let ((test-val '(a b c))
	(expected '(a a a b b b c c c)))
    (test-equal "Replicate each 3 times"
		(replicate test-val 3) expected))

  (let ((test-val '(1 2 3 4 5 6 7 8 9))
	(expected '(1 2 4 5 7 8)))
    (test-equal "Drop every third in list"
		(drop-every test-val 3) expected))

  (let ((test-val '(a b c d e f g h i k))
	(expected '((A B C) (D E F G H I K))))
    (test-equal "Split on third character"
		(split-n test-val 3) expected))

  (let ((test-val '(a b c d e f g h i k))
	(expected '(C D E F G)))
    (test-equal "Slice list to indices 3-7"
		(slice test-val 3 7) expected))

  (let ((test-val '(a b c d e f g h i j k))
	(expected1 '(c d e f g h i j k a b))
	(expected2 '(j k a b c d e f g h i)))
    (test-equal "Rotate 2 positions"
		(rotate test-val 2) expected1)
    (test-equal "Rotate -2 positions"
		(rotate test-val -2) expected2))

  (let ((test-val '(a b c d))
	(expected1 '(b c d))
	(expected2 '(a c d))
	(expected3 '(a b d)))
    (test-equal "Delete second"
		(remove-nth test-val 1) expected1)
    (test-equal "Delete second"
		(remove-nth test-val 2) expected2)))
    (test-equal "Delete second"
		(remove-nth test-val 3) expected3)))
