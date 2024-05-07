#lang racket

(define lista (list 1 2 3 4))


(define (elem liczba lista)
  (if (null? lista)
      #f
      (if (equal? (car lista) liczba)
          #t
      (elem liczba (cdr lista)))))


(elem 5 lista)