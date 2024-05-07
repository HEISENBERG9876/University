#lang plait


; a) 
(define ( apply f x ) ( f x ))
; przyjmuje funkcje f i zmienna x, zwraca f(x).
; (('a -> 'b) 'a -> 'b)

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


(define f1 (curry compose))



(define f2 ((curry compose) (curry compose)))

(define f3 ((curry apply) (curry compose)))


(define f4 (compose curry flip))








;apply
; (('a -> 'b) -> 'a -> 'b)

;compose
; (('a -> 'b) ('c -> 'a) -> ('c -> 'b))

;flip
;((('a 'b) -> 'c) -> (('b 'a) -> 'c))

;curry
; (('a 'b -> 'c) -> ('a -> ('b -> 'c)))




;a.
;(curry compose)

; podstawiamy a = (x -> y)  , b = (z -> x)  ,   c = (z -> y)

;(((x -> y) (z -> x) -> (z -> y)) -> ((x -> y) -> ((z -> x) -> (z -> y))))

;czyli typ zwracany to (('_a -> '_b) -> (('_c -> '_a) -> ('_c -> '_b)))





;b.
;((curry compose) (curry compose))
;wiemy jaki typ ma (curry compose:
;(('a -> 'b) -> (('c -> 'a) -> ('c -> 'b)))

;wezmy drugie curry compose innymi nazwami typow:
;(('x -> 'y) -> (('z -> 'x) -> ('z -> 'y)))


; wezme a = (x -> y), b = ((z -> x) -> (z -> y))
;wtedy zwracamy ((c -> (x -> y)) -> (c -> ((z -> x) -> (z -> y)))).

;, czyli (('_a -> ('_b -> '_c)) -> ('_a -> (('_d -> '_b) -> ('_d -> '_c))))




;c.
;(( curry apply ) ( curry compose ) )


;Wyliczmy najpierw typ (curry apply)


;typ curry:
; (('a 'b -> 'c) -> ('a -> ('b -> 'c)))


;typ apply:
; (('x -> 'y) 'x -> 'y)


;curry przyjmuje jako argument funkcje dwuargumentowa i zamienia ja na jednoparametrowa.
;podstawmy a = (x -> y), b = x, c = y


;(curry apply) = (((x -> y) x -> y) -> ((x -> y) -> (x -> y)))

;czyli zwracany typ (curry apply) to (('_a -> '_b) -> ('_a -> '_b))


;Zrobmy teraz ((curry apply) (curry compose))

;typ curry apply:
;((x -> y) -> (x -> y))
; czyli funkcja identycznosciowa. Zatem ((curry apply) (curry compose)) ma taki sam tym jak (curry compose),
; czyli (('_a -> '_b) -> (('_c -> '_a) -> ('_c -> '_b)))
;







;d
;(compose curry flip)


;typ compose:
;(('a -> 'b) ('c -> 'a) -> ('c -> 'b))


;typ curry:
;(('a 'b -> 'c) -> ('a -> ('b -> 'c)))
;pozmieniajmy zmienne
;(('x 'y -> 'z) -> ('x -> ('y -> 'z)))

;Podstawmy do compose. a = ('x 'y -> 'z),    b = ('x -> ('y -> 'z)

;(compose curry flip)
;((('x 'y -> 'z) -> ('x -> ('y -> 'z))) ('c -> ('x 'y -> 'z)) -> ('c -> ('x -> ('y -> 'z)))


;typ flip:
;(('x 'y -> 'z) -> ('y 'x -> 'z))

;Podstawmy (y x -> z) za c i mamy


;podstawmy flip i zwracamy (('y 'x -> 'z) -> ('x -> ('y -> 'z)), czyli typem jest (('_a '_b -> '_c) -> ('_b -> ('_a -> '_c)))
















































































































