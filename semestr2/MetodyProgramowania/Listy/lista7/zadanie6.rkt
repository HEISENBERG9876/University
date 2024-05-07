#lang racket



(define/contract (my-foldr f x xs)
  ( parametric->/c [ a b ] (-> (-> a b b ) b ( listof a ) b ) )
  (if (null? xs)
      x
      (f (car xs) (my-foldr f x (cdr xs)))))



(define/contract (my-foldr2 f x xs)
  ( parametric->/c [a] (-> (-> a a a ) a ( listof a ) a ) )
  (if (null? xs)
      x
      (f (car xs) (my-foldr f x (cdr xs)))))



(define/contract (my-foldr3 f x xs)
  ( parametric->/c [a] (-> (-> a a a ) a ( listof a ) a ) )
  (if (null? xs)
      x
      (f (car xs) (my-foldr f x (cdr xs)))))












(define swap-ctc (parametric->/c [A] (-> A A (values A A))))

(define/contract (good-swap a b)
    swap-ctc
    (values a b))

(good-swap 1 "a")