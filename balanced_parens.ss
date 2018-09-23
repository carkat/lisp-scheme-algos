(define nil '())
(define symbol-list '((open "({[") (closed ")}]")))
(define (code char) (char->integer char))
(define (chars string)
  (map char-downcase (string->list string)))


(define (types-match? parens first open closed stack)
  (let ((correct-match (and (not (null? stack))
	   (or (= (- (code first) 1)
		  (code (car stack)))
	       (= (- (code first) 2)
		  (code (car stack)))))))
    (if correct-match 
	(balanced-loop (cdr parens) 
		       open
		       closed
		       (cdr stack))
	#f)))

(define (balance-check parens open closed stack)
  (let ((first (car parens)))
    (if (memq first open)
	(balanced-loop (cdr parens)
		       open
		       closed
		       (cons first stack))
	(types-match? parens first open closed stack))))

(define (balanced-loop parens open closed stack)
  (cond ((not (null? parens))
	 (balance-check parens open closed stack))
	((and (null? parens) (null? stack)) #t)
	((and (null? parens) (not (null? stack))) #f)
	(#t (list parens stack))))
  
(define (balanced? parens)
  (let ((open #t))
    (balanced-loop
	(chars parens)
	(chars (cadr (assq 'open symbol-list)))
	(chars (cadr (assq 'closed symbol-list)))
	'())))

(define (test-balanced name val expect)
  (display name)
  (display (eq? expect (balanced? val)))
  (display #\newline))


(define (run-tests)
  (let ((test-value "{}{{}}{{{}}}"))
    (test-balanced "Braces balanced: " test-value #t))

  (let ((test-value "{}{}{}}{{}"))
    (test-balanced "Braces not balanced: " test-value #f))

  (let ((test-value "()()(())((()))"))
    (test-balanced "Parens balanced: " test-value #t))

  (let ((test-value ")(())()(()()("))
    (test-balanced "Parens not balanced: " test-value #f))

  (let ((test-value "[][][[[]]][][][]"))
    (test-balanced "Brackets balanced: "  test-value #t))

  (let ((test-value "[][]][][][]"))
    (test-balanced "Brackets not balanced: " test-value #f))

  (let ((test-value "{}[]()[{}]({[]})"))
    (test-balanced "Mix balanced: " test-value #t))

  (let ((test-value "{}[]()[{]({[]})"))
    (test-balanced "Mix not balanced: " test-value #f)))
