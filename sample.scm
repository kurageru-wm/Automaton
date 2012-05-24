(use automaton)

(define am (make-automaton 's '(t)))
(define s1 (make-state 's '((a . q) (b . t))))
(define s2 (make-state 'q '((a . s) (b . r))))
(define s3 (make-state 'r '((a . t) (b . q))))
(define s4 (make-state 't '((a . r) (b . s))))
(register! am (list s1 s2 s3 s4))

(clear! am)
(run! am '(a a b))
(accept? am)
