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

(define-type RacketExp
  (Racket-exp-number [value : Number])  ;liczba
  (Racket-exp-variable [var-name : Symbol])  ;zmienna
  (Racket-exp-lambda [var-names : (Listof Symbol)] [body : RacketExp])   ;lambda
  (Racket-exp-appl [function : RacketExp] [arguments : (Listof RacketExp)])   ;aplikacja
  (Racket-exp-if [condition : RacketExp] [ifTrue : RacketExp] [ifFalse : RacketExp])   ;if
  (Racket-exp-cond [conditions : (Listof RacketExp)] [ifTrue : (Listof RacketExp)] [else-statement : RacketExp]) ;cond 
  (Racket-exp-let [var-names : (Listof Symbol)] [var-definitions : (Listof RacketExp)] [body : RacketExp]) ;let
)

























  