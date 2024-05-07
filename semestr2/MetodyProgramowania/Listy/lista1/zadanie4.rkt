#lang racket
(require rackunit)


(define (suma_kw_wiekszych a b c) (cond [(or(<= a b c) (<= a c b)) (+ (* b b) (* c c))]
                                        [(or(<= b a c) (<= b c a)) (+ (* a a) (* c c))]
                                        [(or(<= c a b) (<= c b a)) (+ (* b b) (* a a))]
                                        ))


(check-equal? (suma_kw_wiekszych 3 2 1) 13)
(check-equal? (suma_kw_wiekszych 1 2 3) 13)
(check-equal? (suma_kw_wiekszych 2 1 3) 13)
(check-equal? (suma_kw_wiekszych 3 1 2) 13)

(check-equal? (suma_kw_wiekszych 3 3 1) 18)
(check-equal? (suma_kw_wiekszych 3 1 3) 18)
(check-equal? (suma_kw_wiekszych 1 3 3) 18)

(check-equal? (suma_kw_wiekszych 3 3 3) 18)

(check-true (number? (suma_kw_wiekszych 3 3 3)))