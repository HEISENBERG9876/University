#lang racket

(define (maximum lista)
  (define maks -inf.0)
  (for ([i lista]) (if (> i maks) (set! maks i) #f ))
  maks)



( maximum ( list) )