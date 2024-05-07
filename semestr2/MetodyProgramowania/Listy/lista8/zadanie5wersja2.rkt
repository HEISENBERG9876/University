#lang plait

(define (pow a b)
  (if (= 0 b)
      1
      (* a (pow a (- b 1)))))

(define (opposite a)
  (* -1 a))

(define (fact [a : Number])
  (if (= a 1)
      1
  (* a (fact (- a 1)))))

;;;;;;;;;;;;

(define-type Op2
  (op-add) (op-mul) (op-sub) (op-div) (op-pow) (op-fact) (op-opposite))


(define-type Exp
  (exp-number [n : Number])
  (exp-op2 [op : Op2] [args : (Listof Exp)])) ;e1 e2 -> atgs


(define (parse-Op2 s)
  (let ([sym (s-exp->symbol s)])
  (cond
    [(equal? sym '+) (op-add)]
    [(equal? sym '-) (op-sub)]
    [(equal? sym '*) (op-mul)]
    [(equal? sym '/) (op-div)]
    [(equal? sym '^) (op-pow)]
    [(equal? sym '!) (op-fact)]
    [(equal? sym 'opposite) (op-opposite)])))


(define (parse-Exp s)
  (cond
    [(s-exp-number? s) (exp-number (s-exp->number s))]
    [(s-exp-list? s)
     (let ([xs (s-exp->list s)])
           (exp-op2 (parse-Op2  (first  xs))
                    (map parse-Exp xs)
       ))]))

; ==============================================


(define (eval-op2 op)
  (type-case Op2 op
    [(op-add) +]
    [(op-sub) -]
    [(op-mul) *]
    [(op-div) /]
    [(op-pow) pow]
    [(op-fact) fact]
    [(op-opposite) opposite]))


(define (eval e)
  (type-case Exp e
    [(exp-number n)    n]
    [(exp-op2 op args) ((eval-op2 op) (map eval args))]))



;(define exp1 (parse-Exp `(! (+ 2 1))))

;(eval exp1)






























