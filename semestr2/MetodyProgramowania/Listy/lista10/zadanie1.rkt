#lang plait

(module+ test
  (print-only-errors #t))

;; abstract syntax -------------------------------

(define-type Op
  (add)
  (sub)
  (mul)
  (div))

(define-type Exp
  (numE [n : Number])
  (opE [op : Op][expList : (Listof Exp)]))

;; parse ----------------------------------------


(define (parse [s : S-Exp]) : Exp
  (cond
    [(s-exp-match? `NUMBER s)
     (numE (s-exp->number s))]
    [(s-exp-match? `{SYMBOL ANY ...} s)
     (opE (parse-op (s-exp->symbol (first (s-exp->list s))))
          (map parse (rest (s-exp->list s))))]
    [else (error 'parse "invalid input")]))




(define (parse-op [op : Symbol]) : Op
  (cond
    [(eq? op '+) (add)]
    [(eq? op '-) (sub)]
    [(eq? op '*) (mul)]
    [(eq? op '/) (div)]
    [else (error 'parse "unknown operator")]))


(define e1 `(+ (* 2 1) (+ 5 2)))
(parse e1)

(define e2 `(+ 1 2 3))
(parse e2)
                 

;; eval --------------------------------------




(define-type-alias Value Number)

(define (op->proc [op : Op]) : (Value Value -> Value)
  (type-case Op op
    [(add) +]
    [(sub) -]
    [(mul) *]
    [(div) /]))

(define (eval [e : Exp]) : Value
  (type-case Exp e
   [(numE n) n]
    [(opE o args) (apply-proc (op->proc o) (map eval args))]))



;(define (run [e : S-Exp]) : Value
 ; (eval (parse e)))


;; printer ———————————————————————————————————-

;(define (print-value [v : Value]) : Void
;  (display v))
;
;(define (main [e : S-Exp]) : Void
;  (print-value (eval (parse e))))


;;testy

