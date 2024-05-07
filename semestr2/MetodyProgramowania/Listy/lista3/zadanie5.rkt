#lang racket
(require rackunit)

;negatives
(define (negatives n)
  (build-list n (lambda (x) (* -1 (+ x 1)))))



;reciprocals
(define (reciprocals n)
  (build-list n (lambda (x) (/ 1 (+ x 1)))))




;evens
(define (evens n)
  (build-list n(lambda (x)(* 2 (+ x 1)))))


;identity
(define (identityM n)
(build-list n(lambda (i)
               (build-list n
                           (lambda (j)
                             (if (= i j) 1 0))))))


(negatives 10)
(reciprocals 10)
(evens 10)
(identityM 10)


(check-equal? (negatives 3) (list -1 -2 -3))
(check-equal? (negatives 1) (list -1))

(check-equal? (reciprocals 2) (list 1 (/ 1 2)))
(check-equal? (reciprocals 1) (list 1))

(check-equal? (evens 3) (list 2 4 6))
(check-equal? (evens 1) (list 2))

(check-equal? (identityM 3) (list (list 1 0 0) (list 0 1 0) (list 0 0 1)))
(check-equal? (identityM 1) (list (list 1)))

















