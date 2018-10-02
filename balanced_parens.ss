
(define open (string->list "({["))

;;; the main attraction
(define (balanced? parens)
  (balanced-loop (string->list parens) open '()))

(define (code char n) (- (char->integer char) n))

;;; matching braces are either 1 or 2 off in ascii
(define (match? s1 s2) 
  (or (= (code s1 1) (code s2 0))
      (= (code s1 2) (code s2 0))))

(define (balance-check parens open stack)
  (let ((first (car parens)))
    (cond ((member first open)
	   (balanced-loop (cdr parens) open (cons first stack)))
	  ((and (not (null? stack)) (match? first (car stack)))
	   (balanced-loop (cdr parens) open (cdr stack)))
	  (#t #f))))

(define (balanced-loop parens open stack)
  (cond ((not (null? parens))
	 (balance-check parens open stack))
	((and (null? parens) (null? stack)) #t)
	((and (null? parens) (not (null? stack))) #f)
	(#t (list parens stack))))
  


;;; Testing below only
(define (test-balanced name val expect)
  (display name)
  (display (if (eq? expect (balanced? val)) "PASS" "FAIL"))
  (display #\newline))


(define (run-tests)
  (let ((test-value "{}{{}}{{{}}}"))
    (test-balanced "Braces balanced: " test-value #t))

  (let ((test-value "{}{}{}}{{}"))
    (if true this that))

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
