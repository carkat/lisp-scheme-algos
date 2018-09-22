(define nil '())
(define symbol-list '((open "({[") (closed ")}]")))
(define (code char) (char->integer char))
(define (chars string)
  (map char-downcase (string->list string)))


(define (balanced-loop parens open closed stack)
  (cond ((and (null? parens) (null? stack)) #t)
	((and (null? parens) (not (null? stack))) #f)
	((and (not (null? parens)) (not (null? stack)))
	 (let ((first (car parens)))
	    (if (member first open)
		(balanced-loop (cdr parens)
			    open
			    closed
			    (list first stack))
		(if (or (= (- (code first) 1)
			    (code (car stack)))
			(= (- (code first) 2)
			    (code (car stack))))
		    (balanced-loop (cdr parens) 
				open
				closed
				(cdr stack))
		    #f))))))
  
(define (balanced? parens)
  (let ((open #t))
    (balanced-loop
	(chars parens)
	(chars (cadr (assq 'open symbol-list)))
	(chars (cadr (assq 'closed symbol-list)))
	'())))

(define (test-parens-balanced)
  (let ((test-value "{}"))
    (eq? (balanced? test-value) #t)))

(define (test-parens-not-balanced)
  (let ((test-value "{}{"))
    (eq? (balanced? test-value) #t)))
