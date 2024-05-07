#lang racket
(require rackunit)

(define (reverse lista) (foldl cons '() lista))


;(define empty-queue2 (list '() '()))

;(define (empty2? q) (null? (car q)))

;(define (push-back2 x q)
 ; (if (empty2? q)
  ;    (list (list x) '())
   ;   (list (car q)(cons x (car (cdr q))))))

;(define (front2 q)
  ;(if (empty2? q)
 ;    '()
  ;    (car (car q))))

;(define (pop2 q)
 ; (if (null? (cdr (car q)))
  ;    (list  (reverse (car (cdr q))) '())
   ;   (list (cons cdr (car q)) (cdr q))))


;(define kolejka empty-queue2)

;(define kolejkatest (push-back2 3(push-back2 2 (push-back2 1 kolejka))))



;kolejkatest
;(pop2 kolejkatest)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(define empty-queue (cons '() '()))

(define (empty? q) (null? (car q)))

(define (push-back x q)
  (if (empty? q)
      (cons (list x) '())
      (cons (car q)(cons x (cdr q)))))

(define (front q)
  (if (empty? q)
     '()
      (car (car q))))

(define (pop q)
  (if (null? (cdr (car q)))
      (cons  (reverse (cdr q)) '())
      (cons (cdr (car q)) (cdr q))))







(define kolejka empty-queue)
(define kolejkatest (push-back 3(push-back 2 (push-back 1 kolejka))))
kolejkatest
(pop kolejkatest)
(pop (pop kolejkatest))
(pop (pop (pop kolejkatest)))

(check-equal? kolejka (cons '() '()))
(check-equal? (push-back 1 kolejka) (cons '(1) '()))
(check-equal? kolejkatest (cons '(1) '(3 2)))
(check-equal? (pop kolejkatest) (cons '(2 3) '()))
(check-equal? (pop (pop kolejkatest)) (cons '(3) '()))
(check-equal? (pop (pop (pop kolejkatest))) (cons '() '()))
(check-equal? (pop (pop (pop kolejkatest))) empty-queue)

(check-equal? (push-back 1 kolejka) (cons '(1) '()))
(check-equal? (push-back 2(push-back 1 kolejka)) (cons '(1) '(2)))
(check-equal? (push-back 3 (push-back 2(push-back 1 kolejka))) (cons '(1) '(3 2)))
(check-equal? (push-back 4 (pop (pop kolejkatest))) (cons '(3) '(4)))





























































