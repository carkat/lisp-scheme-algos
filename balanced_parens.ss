(define nil '())
(define symbol-list "({[")

(define (code char) (char->integer char))

(define (types-match? parens first open stack)
  "This function matches type of braces by charcode.
   When (code first) - 1 = (code (car stack)), first = ()
   When (code first) - 2 = (code (car stack)), first = {} or []
   When correct-match is found, continue recursion."
  (let ((correct-match
	 (and (not (null? stack))
	   (or (= (- (code first) 1)
		  (code (car stack)))
	       (= (- (code first) 2)
		  (code (car stack)))))))
    (if correct-match 
	(balanced-loop (cdr parens) open (cdr stack))
	#f)))

(define (balance-check parens open stack)
  """ If first is an opening character continue looping.
  Otherwise, it is a closing character, so check the type.
  """
  (let ((first (car parens)))
    (if (memq first open)
	(balanced-loop (cdr parens) open (cons first stack))
	(types-match? parens first open stack))))

(define (balanced-loop parens open stack)
  (cond ((not (null? parens))
	 (balance-check parens open stack))
	((and (null? parens) (null? stack)) #t)
	((and (null? parens) (not (null? stack))) #f)
	(#t (list parens stack))))
  
;;; the main attraction
(define (balanced? parens)
  (let ((open #t))
    (balanced-loop
	(string->list parens)
	(string->list symbol-list)
	'())))


;;; Testing below only
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
