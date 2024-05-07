#lang racket
(define lista1 (list 10 30 40 70 90 91 92 93))
(define lista2 (list 20 25 35 100 500))

(define (split xs)
  (define (length xs wynik)
    (if (null? xs)
        wynik
        (length (cdr xs) (+ wynik 1))))
  (define dl_listy1 (quotient (length xs 0) 2))
  
  
  (define (zwroc_listy xs licznik lista1)
    (if (< licznik dl_listy1)
        (zwroc_listy (cdr xs) (+ licznik 1) (append lista1 (list(car xs))))
        (cons lista1 (list xs))))

  (zwroc_listy xs 0 (list)))



(split (list 2 3 4 5 6 7 8 9 0 10))



(define (merge xs ys)
  (cond
    [(null? xs) ys]
    [(null? ys) xs]
    [(< (car xs) (car ys))
     (cons (car xs) (merge (cdr xs) ys))]
    [else (cons (car ys) (merge xs (cdr ys)))]))


(define (merge xs ys)
  (cond [(null? xs) ys]))



(merge lista1 lista2)