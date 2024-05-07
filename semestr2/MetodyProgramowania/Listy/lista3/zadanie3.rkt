#lang racket
(require rackunit)


;1
(( lambda ( x y ) (+ x (* x y ) ) ) 1 2)

; =>(+ 1 (* 1 2)) => (+ 1 2) => 3

(check-equal? (( lambda ( x y ) (+ x (* x y ) ) ) 1 2)
              3)



;2
(( lambda ( x ) x ) ( lambda ( x ) x ) )
;=> ((lambda (x) (lambda (x) x)) => (lambda (x) x))

(define x (lambda (x) x))
(check-equal? x (x x))
              



;3
(( lambda ( x ) ( x x ) ) ( lambda ( x ) x ) )
;=> ((lambda (x) (( lambda ( x ) x ) ( lambda ( x ) x ))) => ((lambda (x) ((lambda (x) (lambda (x) x)) => (lambda (x) x)
(define y ( lambda ( x ) ( x x ) ))
(check-equal? (y x) x)

;4
(( lambda ( x ) ( x x ) ) ( lambda ( x ) ( x x ) ) )
;=> ((lambda (x) (( lambda ( x ) ( x x ) ) ( lambda ( x ) ( x x ) ))) => ((lambda (x) (( lambda ( x ) ( ( lambda ( x ) ( x x ) ) ( lambda ( x ) ( x x ) ) ) ))))..........
;(z z) => (z (z z)) -> (z (z (z z)) ...... 


