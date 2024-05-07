#lang racket
(require rackunit)


(define xs (list 1 2 3))
(define xs2 (list 3 2 1))
(define xs3 (list 4 4 4))
(define xs4 (list))


(define (product xs)
  (foldl * 1 xs))


(product xs)
(check-eq? (product xs) 6)
(check-eq? (product xs2) 6)
(check-eq? (product xs3) 64)
(check-eq? (product xs4) 1)