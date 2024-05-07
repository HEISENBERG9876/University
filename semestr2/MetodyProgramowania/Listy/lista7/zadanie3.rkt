#lang racket
(define xs (range 30))


(define (suffixes xs)
  (if (null? xs)
      (cons '() '())
      (cons xs (suffixes (cdr xs)))))




(define/contract (suffixes2 xs)
  (parametric->/c [a] (-> (listof a) (listof (listof a))))
   (if (null? xs)
      (cons '() '())
      (cons xs (suffixes2 (cdr xs)))))




(define (suffixes3 xs)
  (if (null? xs)
      (cons '() '())
      (cons xs (suffixes3 (cdr xs)))))




(define/contract (suffixes4 xs)
  (parametric->/c [a] (-> (listof a) (listof (listof a))))
  (if (null? xs)
      (cons '() '())
      (cons xs (suffixes4 (cdr xs)))))


(suffixes4 xs)