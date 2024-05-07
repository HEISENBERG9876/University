#lang racket

(define (elem x xs)
  (define wypisano #f)
  
  (for ([i xs])
    (if (equal? i x) (set! wypisano #t) #f))
  wypisano)