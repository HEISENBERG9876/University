#lang racket

(define (suffixes xs)
  (if (null? xs)
      (list xs)
      (append (list xs) (suffixes (cdr xs)))))

 
(suffixes ( list 1 2 3 4) )