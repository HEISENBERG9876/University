#lang racket


(define (maximum xs)
  (if (null?  xs)
      -inf.0
      (if (> (car xs) (maximum (cdr xs)))
          (car xs)
          (maximum (cdr xs)))))


(maximum (list))

