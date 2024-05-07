#lang racket
(require rackunit)


(define lista-null
  (lambda (xs) xs))


(define (lista->list f)
  (f null))

(define (list->lista xs)
  (lambda (ys) (append xs ys)))

(define (lista-singleton x)
  (lambda (ys) (cons x ys)))


(define (lista-append f g)
  (lambda (xs) (f (g xs))))

(define (foldr-lista-reverse xs)
  (lista->list (foldr (lambda (x f) (lista-append f (lista-singleton x))) lista-null xs)))





(check-equal? (lista->list lista-null) '())
(check-equal? (lista->list (lista-singleton 5)) '(5))
(check-equal? (lista->list (list->lista '(1 2 3 4))) '(1 2 3 4))
(check-equal? (lista->list (lista-append (list->lista '(1 2 3 4)) (list->lista '(4 5 6 7)))) '(1 2 3 4 4 5 6 7))
(check-equal? (foldr-lista-reverse '(1 2 3 4)) '(4 3 2 1))

(lista-singleton 5)