#lang racket

(define-struct matrix (a b c d) #:transparent)
(define m1 (matrix 1 -2 5 12))
(define m2 (matrix 0 3 5 -1))


(define (matrix-mult mat1 mat2)
  (define (pomnoz num1 num2 num3 num4) (+ (* num1 num2) (* num3 num4)))

  (define a1 (matrix-a mat1))
  (define b1 (matrix-b mat1))
  (define c1 (matrix-c mat1))
  (define d1 (matrix-d mat1))
  (define a2 (matrix-a mat2))
  (define b2 (matrix-b mat2))
  (define c2 (matrix-c mat2))
  (define d2 (matrix-d mat2))
  
  (define new_a (pomnoz a1 a2 b1 c2))
  (define new_b (pomnoz a1 b2 b1 d2))
  (define new_c (pomnoz c1 a2 d1 c2))
  (define new_d (pomnoz c1 b2 d1 d2))
  (matrix new_a new_b new_c new_d))


(define (matrix-id m)
  (define a (matrix-a m))
  (define b (matrix-b m))
  (define c (matrix-c m))
  (define d (matrix-d m))
  (matrix a b c d))


;(define (matrix-exp m k)
 ; (define m_oryg m)
  ;(define (poteguj m licznik)(if (= k licznik) m
   ;       (poteguj (matrix-mult m_oryg m) (+ 1 licznik))))
  ;(poteguj m 1))


(define (matrix-exp m k)
  (define m_oryg m)
  (define (poteguj m k)(if (= k 1) m
          (poteguj (matrix-mult m_oryg m) (- k 1))))
  (poteguj m k))


;(define (fib-matrix k)
;  (define m (matrix 1 1 1 0))
;  (define (wylicz matryca licznik)
;    (define a (matrix-a matryca))
;    (define b (matrix-b matryca))
;    (define c (matrix-c matryca))
;    (define d (matrix-d matryca))
;    
;    (if (= k licznik) (matrix-a matryca)
;      (wylicz (matrix (+ b a) a a c) (+ 1 licznik))))
;  (wylicz m 2))


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


