#lang racket

(define (mreverse! xs)
  (define (pom prev curr)
    (cond
      [(null? curr)  prev]
      [else
       (let ((next (mcdr curr)))
         (set-mcdr! curr prev)
         (pom curr next))]))
  (pom '() xs))

(define x (mcons 1 (mcons 2 (mcons 3 '()))))


(mreverse! x)


(define (mreverse2! xs)
  (define (pom prev curr)
    (let ([next (mcdr curr)])
      (if (null? next)
          (mcons (mcar curr) prev)
          (begin
            (set-mcdr! curr prev)
            (pom curr next)))))
  (pom '() xs))


(define xs (mcons 1 (mcons 2 (mcons 3 '()))))
(mreverse2! xs)