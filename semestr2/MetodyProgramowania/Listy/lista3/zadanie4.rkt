#lang racket

(require rackunit)

(define (inc x) (+ x 1))

(define (square x) (* x x))

(define (my-compose f g x)
  (f (g x)))


(my-compose square inc 5)



(check-eq? (inc 5) 6)
(check-eq? (inc -2) -1)
(check-eq? (inc 0) 1)

(check-eq? (square 5) 25)
(check-eq? (square 0) 0)
(check-eq? (square -3) 9)