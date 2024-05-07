#lang racket

(define (append_pom xs oryg_xs)
  (if (null? (mcdr xs))
      (set-mcdr! xs oryg_xs)
      (append_pom (mcdr xs) oryg_xs)))


(define (cycle! xs)
  (if (null? xs)
      '()
      (append_pom xs xs)))



(define lista1 (mcons 1 (mcons 2 (mcons 3 '()))))

;(cycle! lista1)

;lista1
;(mcdr lista1)
;(mcdr (mcdr lista1))
;(mcdr (mcdr (mcdr lista1)))
;(mcdr (mcdr (mcdr (mcdr lista1))))



(define (cycle-pom xs oryg-xs)
  (if (null? (mcdr xs))
      (set-mcdr! xs oryg-xs)
      (cycle-pom (mcdr xs) oryg-xs)))

(define (cycle2! xs)
  (if (null? xs)
      '()
      (cycle-pom xs xs)))


(define lista2 (mcons 1 (mcons 2 '())))

(cycle2! lista2)


(mcdr lista2)
(mcdr (mcdr lista2))
(mcdr (mcdr (mcdr lista2)))