#lang racket


(define (sorted xs)
  (if (null? (cdr xs))
             #t
             (if (> (car xs) (car (cdr xs)))
                 #f
                 (sorted (cdr xs)))))