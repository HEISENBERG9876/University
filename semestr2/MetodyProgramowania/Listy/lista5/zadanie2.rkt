#lang plait


; a) 
(define ( apply f x ) ( f x ))
; przyjmuje funkcje f i zmienna x, zwraca f(x).
; (('a -> 'b) -> 'a -> 'b)

; b)
( define ( compose f g ) ( lambda ( x ) ( f ( g x ) ) ) )
; Zlozenie funkcji fg
; (('a -> 'b) ('c -> 'a) -> ('c -> 'b))

; c)
(define (flip f) (lambda (x y) (f y x)))
; zamiana funckcji (f x y) na (f y x)
; ((('a 'b) -> 'c) -> (('b 'a) -> 'c))

; d)
(define (curry f) (lambda (x) (lambda (y) (f x y))))
; zamiana funkcji dwuargumentowej f 
; na jednoargumentową, 
; która zwraca inną funkcję jednoargumentową.
; (('a 'b -> 'c) -> ('a -> ('b -> 'c)))













(define (multiply x y)
  (* x y))

((curry multiply) 5)
(((curry multiply) 5) 10)
