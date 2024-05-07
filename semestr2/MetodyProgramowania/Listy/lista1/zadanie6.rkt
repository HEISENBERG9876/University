#lang racket

(define (cond) (< 3 2))

(define (ifTrue) "spelniono")
(define (ifFalse) "niespelniono")

(or (and (cond) (ifTrue)) (ifFalse))