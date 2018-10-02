;;; export
(define number-of-nodes 30)
(define number-of-edges 45)

(define (make-n-rand-edges n)
  (make-rand-pairs n '()))

(define (make-rand-pairs n pairs)
  (if (> n 0)
      (let ((pair (make-rand-pair)))
	(if (not (null? pair))
	    (make-rand-pairs (- n 1) (append pair pairs))
	    (make-rand-pairs n pairs)))
      pairs))

(define (make-rand-pair)
  (edge-pair (rand-node) (rand-node)))


(define (edge-pair a b)
  (if (not (= a b))
      (list (cons a b) (cons b a))
      (make-rand-pair)))

(define (rand-node)
  (+ 1 (random number-of-nodes)))

(define (get-nodes n pairs)
  (filter (lambda (x)
	    (= n (car x)))
	  pairs))

(define (push x a-list)
  (a-list (cons x a-list)))


(define (get-connected node pairs)
  (let ((visited '()))
    (letrec ((traverse (lambda (node)
			 (cond ((not (member node visited))
				(set! visited (cons node visited))
				(map (lambda (edge)
				       (traverse (cdr edge)))
				     (get-nodes node pairs)))))))
      (traverse node))
    visited))

(define (get-islands nodes edge-list)                                     
  (let ((islands '()))
    (letrec ((get-island
	      (lambda (nodes)
		(let* ((connected (get-connected (car nodes) edge-list))
		       (unconnected
			(filter (lambda (x) (not (member x connected)))
				nodes)))
		  (set! islands (cons connected islands))
		  (if (not (null? unconnected))
		      (get-island unconnected))))))
      (get-island nodes))
    islands))

(define (nodes-list)
  (letrec ((make-nodes (lambda (n results)
			 (if (> n 0)
			     (make-nodes (- n 1) (cons n results))
			     results))))
    (make-nodes number-of-nodes '())))

(define test-val (make-n-rand-edges number-of-edges))

(define (test-get-nodes)
  (get-nodes 39 test-val))
  
