(define-module automaton
  (export
    <DFA> <state>
    register! accept? step! run!
    make-dfa make-state
    clear!)
  )
(select-module automaton)

#|           AUTOMATON           |#
(define-class <DFA> ()
  ((init :init-keyword :init
         :accessor init-of
         :init-value #f)
   (current :accessor current-of
            :init-value #f)
   #| '((a . (<state>)) (b . (<state>)) ...) |#
   (S :init-keyword :S
      :accessor s-of
      :init-value '())
   #| '(a d s ...) |#
   (A :init-keyword :A
      :accessor a-of
      :init-value '())
   ))


#|           STATE              |#
(define-class <state> ()
  ((state :init-keyword :state
          :accessor state-of
          :init-value #f)
   #| '((SYMBOL . NEXT-SYMBOL) ...) |#
   (T :init-keyword :T
      :accessor t-of
      :init-value '())
    ))


(define-method initialize ((am <DFA>) initargs)
  (next-method)
  (set! (current-of am) (init-of am))
  )

(define-method register! ((am <DFA>) (s <state>))
  (set! (s-of am) (cons `(,(state-of s) . ,s) (s-of am))))

(define-method register! ((am <DFA>) (s <list>))
  (for-each (cut register! am <>) s))

(define-method accept? ((am <DFA>))
  (if (member (current-of am) (a-of am))
    #t
    #f))

(define-method step! ((am <DFA>) s)
  (let1 state (assq (current-of am) (s-of am))
    (if state
      (set! (current-of am) (step (cdr state) s))
      #f)))

(define-method run! ((am <DFA>) (l <list>))
  (for-each (cut step! am <>) l))

(define (make-dfa init A)
  (make <DFA> :init init :A A))


(define-method step ((s <state>) sym)
  (let1 next (assq sym (t-of s))
    (if next
      (cdr next)
      #f)))

(define (make-state st T)
  (make <state> :state st :T T))

(define-method clear! ((am <DFA>))
  (set! (current-of am) (init-of am)))



(provide "automaton")
