#lang racket


;( let ([ x 3]) wiaze x
;(+ x y ) ) x zwiazana, y wolna

;( let ([ x 1] wiaze x
;[ y (+ x 2) ]) wiaze y, x jest wolna
;(+ x y ) ) x i y zwiazane


;( let ([ x 1]) wiaze x
;( let ([ y (+ x 2) ]) wiaze y, x zwiazana
;(* x y ) ) ) x, y zwiazane


;( define ( f x y ) f, x, y wiazane przez define
;(* x y z ) ) x, y zwiazane, z wolna


( define (f x ) ;f, x wiazane przez define
  ( define ( g y z ) ;g, y, z wiazane przez define
      (* (x) y z ) ) ;x, y, z zwiazane
   ( f x x )) ;f, x zwiazane

(define x (* 1 2))

(f x)

