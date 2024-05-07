#lang racket

(define-struct matrix (a b c d) #:transparent)
(define m1 (matrix 1 -2 5 12))
(define m2 (matrix 0 3 5 -1))


(define (matrix-mult mat1 mat2)
  (define (pomnoz L1 L2 L3 L4) (+(* L1 L2) (* L3 L4)))
  (define a1 (matrix-a mat1))
  (define b1 (matrix-b mat1))
  (define c1 (matrix-c mat1))
  (define d1 (matrix-d mat1))
  (define a2 (matrix-a mat2))
  (define b2 (matrix-b mat2))
  (define c2 (matrix-c mat2))
  (define d2 (matrix-d mat2))
  (define a (pomnoz a1 a2 b1 c2))
  (define b (pomnoz a1 b2 b1 d2))
  (define c (pomnoz c1 a2 d1 c2))
  (define d (pomnoz c1 b2 d1 d2))
  (matrix a b c d))



(define (matrix-exp m k)
  (define m_oryg m)
  (define (poteguj m k)(if (= k 1) m
          (poteguj (matrix-mult m_oryg m) (- k 1))))
  (poteguj m k))


(define (fib-matrix k)
  (define m (matrix 1 1 1 0))
  (define (wylicz matryca k)
    (define a (matrix-a matryca))
    (define b (matrix-b matryca))
    (define c (matrix-c matryca))
    (define d (matrix-d matryca))
    (cond [(= k 0) 0]
          [(= k 1) 1]
          [else (if (= k 2) (matrix-a matryca)
      (wylicz (matrix (+ b a) a a c) (- k 1)))]
    ))
  (wylicz m k))


(define (matrix-exp-fast m k)
  (define m_oryg m)
  (define (poteguj m k)(if (= k 1) m
          (if (= (modulo k 2) 1)
              (matrix-mult m_oryg (poteguj m (- k 1)))
              (matrix-mult (poteguj m (/ k 2)) (poteguj m (/ k 2)))
              )))
  (poteguj m k))


(define (fib-matrix-fast k)
  (define m (matrix 1 1 1 0))
  (define (wylicz matryca k)
    (define a (matrix-a matryca))
    (define b (matrix-b matryca))
    (define c (matrix-c matryca))
    (define d (matrix-d matryca))
    (cond [(= k 0) 0]
          [(= k 1) 1]
          [else (if (= k 2)
                    (matrix-a matryca)
                    (if (= (modulo k 2) 1)(wylicz (matrix (+ b a) a a c) (- k 1))))]))
  (wylicz m k))


(fib-matrix-fast 6)


















(define (exp-fast m k)
  (define m_oryg m)
  (define (poteguj m k)(if (= k 1) m
          (if (= (modulo k 2) 1)
              (* m_oryg (poteguj m (- k 1)))
              (* (poteguj m (/ k 2)) (poteguj m (/ k 2)))
              )))
  (poteguj m k))


