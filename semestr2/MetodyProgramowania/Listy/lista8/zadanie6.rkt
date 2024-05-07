#lang plait

;SKLADNIA ABSTRAKCYJNA Z WYKLADU
(define-type Op
  (op-add) (op-mul) (op-sub) (op-div))

(define-type Exp
  (exp-number [n : Number])
  (exp-op [op : Op] [e1 : Exp] [e2 : Exp]))



;PARSER Z WYKLADU
(define (parse-Op s)
  (let ([sym (s-exp->symbol s)])
  (cond
    [(equal? sym '+) (op-add)]
    [(equal? sym '-) (op-sub)]
    [(equal? sym '*) (op-mul)]
    [(equal? sym '/) (op-div)])))

(define (parse-Exp s)
  (cond
    [(s-exp-number? s) (exp-number (s-exp->number s))]
    [(s-exp-list? s)
     (let ([xs (s-exp->list s)])
       (exp-op (parse-Op  (first  xs))
               (parse-Exp (second xs))
               (parse-Exp (third  xs))))]))

;MOJE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;wersja uproszczona
(define-type RacketExp
  (racket-exp-number [value : Number])  ;liczba
  (racket-exp-variable [var-name : Symbol])  ;zmienna
  (racket-exp-lambda [var-name : Symbol] (body : 'a))   ;lambda
  (racket-exp-appl function [arguments : (Listof RacketExp)])   ;aplikacja
  (racket-exp-if condition ifTrue ifFalse)   ;if
  (racket-exp-cond [conditions : (Listof RacketExp)] [ifTrue : (Listof RacketExp)] [else-statement : RacketExp]) ;cond 
  (racket-exp-let [var-names : (Listof Symbol)] [var-definitions : (Listof RacketExp)] [body : RacketExp]) ;let
  ))