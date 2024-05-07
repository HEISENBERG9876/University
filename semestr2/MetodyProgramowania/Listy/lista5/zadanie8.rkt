#lang plait


(define-type Prop
(var [v : String])
(conj [l : Prop] [r : Prop])
(disj [l : Prop] [r : Prop])
(neg [f : Prop]) )





(define prop1
  (var "x"))

(define prop2
  (var "y"))

(define prop3
  (conj prop1 prop2))

(define prop4 (disj prop3 prop1))

(define prop5
  (disj prop1 prop2))


(define ht1 (make-hash (list (pair "x" #f) (pair "y" #t))))

;(some-v (hash-ref ht "x"))




(define (eval x ht)
   (cond [(neg? x)   (not (eval (neg-f x) ht))]
          [(disj? x)  (or (eval (disj-r x) ht) (eval (disj-l x) ht))]
          [(conj? x)  (and (eval (conj-r x) ht) (eval (conj-l x) ht))]
          [else (some-v (hash-ref ht (var-v x)))]))



(eval (conj prop5 prop1) ht1)

