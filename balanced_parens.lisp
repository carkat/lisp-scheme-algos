(defvar *open* (coerce  "({[" 'list))

(defun match? (close open)
  (or (= (- (char-code close) 1) (char-code open))
      (= (- (char-code close) 2) (char-code open))))

(defun loop-if-match (brackets open stack)
  (cond ((member (car brackets) open)
	 (b-loop (cdr brackets) open (cons (car brackets) stack)))
	((and stack (match? (car brackets) (car stack)))
	 (b-loop (cdr brackets) open (cdr stack)))
	(t '())))	 

(defun b-loop (brackets open stack)
  (if brackets (loop-if-match brackets open stack)
      (if stack NIL t)))

(defun balanced? (brackets)
  (b-loop (coerce brackets 'list) *open* '()))


;;; tests
(defun test-balanced (name val expect)
  (format t "~a ~a"
	  name
	  (if (equal expect (balanced? val))
	  "PASS"
	  "FAIL"))

  (format t "~%"))

(defun run-tests ()
  (let ((test-value "{}{{}}{{{}}}"))
    (test-balanced "Braces balanced: " test-value t))

  (let ((test-value "}{{}}{{{}}}"))
    (test-balanced "Braces balanced: " test-value NIL))

  (let ((test-value "()()(())((()))"))
    (test-balanced "Parens balanced: " test-value t))

  (let ((test-value ")(())()(()()("))
    (test-balanced "Parens not balanced: " test-value NIL))

  (let ((test-value "[][][[[]]][][][]"))
    (test-balanced "Brackets balanced: "  test-value t))

  (let ((test-value "[][]][][][]"))
    (test-balanced "Brackets not balanced: " test-value NIL))

  (let ((test-value "{}[]()[{}]({[]})"))
    (test-balanced "Mix balanced: " test-value t))

  (let ((test-value "{}[]()[{]({[]})"))
    (test-balanced "Mix not balanced: " test-value NIL)))
