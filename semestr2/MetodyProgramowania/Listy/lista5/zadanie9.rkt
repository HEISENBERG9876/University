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


(define ht (make-hash (list (pair "x" #f) (pair "y" #t))))

;(some-v (hash-ref ht "x"))



;wartosciowanie
(define (iter2 f)
   (cond [(neg? f)   (not (iter2 (neg-f f)))]
          [(disj? f)  (or (iter2 (disj-r f)) (iter2 (disj-l f)))]
          [(conj? f)  (and (iter2 (conj-r f)) (iter2 (conj-l f)))]
          [else (some-v (hash-ref ht (var-v f)))]))



;(iter2 (conj prop5 prop1))




;usuwanie duplikatow
(define (rm-dupl lst)
  (cond [(equal? '() lst) '()]
    [(member (first lst) (rest lst))
     (rm-dupl (rest lst))]
    [else (cons (first lst)
           (rm-dupl (rest lst)))]))



; iteracja
(define (iter x xs)
   (cond [(neg? x)   (iter (neg-f x) xs)]
          [(disj? x)  (iter (disj-r x) (iter (disj-l x) xs))]
          [(conj? x)  (iter (conj-r x) (iter (conj-l x) xs))]
          [(var? x) (append xs (list (var-v x)))]))



;wynik
(define (free-vars x)
     (rm-dupl (iter x (list))))

(free-vars prop4)



;zadanie 9

;(hash-set! ht "x" #t)
ht

;(some-v (hash-ref ht "x")) zwraca wartosc bool


(define (all-propositions lst)
  (foldr
   (lambda (x xs)
     (append (map (lambda (eval) (cons (pair x #t) eval)) xs)
             (map (lambda (eval) (cons (pair x #f) eval)) xs)))
   '(()) lst))


(all-propositions (list "x" "y" "z"))




