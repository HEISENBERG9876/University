#lang racket

;; processing data sequences with lists --------------------

(define (second-prime-in-interval a b)
  (car (cdr (filter prime?
                    (enumerate-interval a b)))))

; (second-prime-in-interval 10000 5000000)

(define (enumerate-interval a b)
  (if (> a b)
      '()
      (cons a (enumerate-interval (+ a 1) b))))

(define (square x)
  (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

;; streams aka lazy lists ---------------------------------

;; delay and force

(define-syntax-rule
  (stream-cons v s)
  (cons v (delay s)))

(define stream-car car)

(define (stream-cdr s)
  (force (cdr s)))

(define stream-null null)
(define stream-null? null?)

;; operations on streams

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(define (stream-filter p s)
  (if (stream-null? s)
      stream-null
      (if (p (stream-car s))
          (stream-cons (stream-car s)
                       (stream-filter p (stream-cdr s)))
          (stream-filter p (stream-cdr s)))))

(define (stream-enumerate-interval a b)
  (if (> a b)
      stream-null
      (stream-cons a (stream-enumerate-interval (+ a 1) b))))

(define (stream-second-prime-in-interval a b)
  (stream-car
   (stream-cdr
    (stream-filter prime?
                   (stream-enumerate-interval a b)))))

;; infinite streams

(define ones (stream-cons 1 ones))

(define (integers-from n)
  (stream-cons n (integers-from (+ n 1))))

(define nats (integers-from 0))

(define (sieve s)
  (stream-cons
   (stream-car s)
   (sieve
    (stream-filter
     (λ (x) (not (divides? (stream-car s) x)))
     (stream-cdr s)))))

(define primes (sieve (integers-from 2)))

 ;; combining (infinite) streams 

(define (map2 f xs ys)
  (stream-cons
   (f (stream-car xs)
      (stream-car ys))
   (map2 f (stream-cdr xs) (stream-cdr ys))))

(define nats2 (stream-cons 0 (map2 + nats2 ones)))

#|
nats2    0 1 2 ...
ones     1 1 1 ...
---------------------------------------
nats2  0 1 2 3 ...
|#

(define fibs
  (stream-cons 0 (stream-cons 1 (map2 + fibs (stream-cdr fibs)))))

#|
fib            0 1 1 2 3 ...  
(cdr fib)      1 1 2 3 ...
-----------------------------------------
fib        0 1 1 2 3 5 ...

|#


(define (iterate stream counter)
  (if (= counter 10)
      (displayln (stream-ref stream counter))
      (begin (displayln (stream-ref stream counter))
             (iterate stream (+ counter 1)))))



(define (check-prime n prime-stream)
  (let ([x (stream-car prime-stream)])
  (if (= x n)
      #t
      (if (= 0 (modulo n x))
          #f
          (check-prime n (stream-cdr prime-stream))))))


(define (next-prime-generator n)
  (define stream (integers-from 2))
  (if (check-prime n stream)
      (stream-cons n (next-prime-generator (+ n 1)))
      (next-prime-generator (+ n 1))))

(define prime-stream2
  (stream-cons 2 (next-prime-generator 3))
  )

;Dziala dla stream niebedacego naszym strumieniem liczb pierwszych. Jak zrobic zeby to od siebie zalezalo?



(define x prime-stream2)


(iterate x 0)



