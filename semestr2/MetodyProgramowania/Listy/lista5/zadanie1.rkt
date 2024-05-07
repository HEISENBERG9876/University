#lang plait

;('a 'b - > 'a )
(define (f1 x y) x)



;(('a 'b - > 'c ) ('a - > 'b ) 'a - > 'c )
(define (f2 [f : ('a 'b -> 'c) ] [g : ('a -> 'b)] [h : 'a])
        (f h (g h)))


;((( 'a - > 'a ) - > 'a ) - > 'a )
(define (f3 [f : (('a -> 'a) -> 'a) ])
  (f (lambda (x) x))
  )


;(('a - > 'b ) ('a - > 'c ) - > ('a - > ('b * 'c ) ) )
(define (f4 [f : ('a -> 'b)] [g : ('a -> 'c)])
  (lambda (x) (pair (f x) (g x)))
  )


;(('a - > ( Optionof ('a * 'b ) ) ) 'a - > ( Listof 'b ) )
(define (f5 [f : ('a -> (Optionof ('a * 'b ))) ] [x : 'a] ) (list (snd (some-v (f x) ))))


(define (test [a : (Number -> Number)] [b : (Number Number -> Number)])
  (if (= 1 2)
      a
      b))
