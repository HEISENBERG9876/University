#lang plait

(define (pow a b)
  (if (= 0 b)
      1
      (* a (pow a (- b 1)))))

(define (opposite a)
  (* -1 a))

(define (fact a)
  (if (= a 1)
      1
  (* a (fact (- a 1)))))

;;;;;;;;;;;;

(define-type Op2
  (op-add) (op-mul) (op-sub) (op-div) (op-pow))

(define-type Op1
  (op-fact)
  (op-opposite))

(define-type Exp
  (exp-number [n : Number])
  (exp-op2 [op : Op2] [e1 : Exp] [e2 : Exp])
  (exp-op1 [op : Op1] [e1 : Exp]))


(define (parse-Op2 s)
  (let ([sym (s-exp->symbol s)])
  (cond
    [(equal? sym '+) (op-add)]
    [(equal? sym '-) (op-sub)]
    [(equal? sym '*) (op-mul)]
    [(equal? sym '/) (op-div)]
    [(equal? sym '^) (op-pow)])))

(define (parse-Op1 s)
  (let ([sym (s-exp->symbol s)])
  (cond
    [(equal? sym '!) (op-fact)]
    [(equal? sym 'opposite) (op-opposite)])))

(define (parse-Exp s)
  (cond
    [(s-exp-number? s) (exp-number (s-exp->number s))]
    [(s-exp-list? s)
     (let ([xs (s-exp->list s)])

       (if (= (length xs) 3)
       
           (exp-op2 (parse-Op2  (first  xs))
                    (parse-Exp (second xs))
                    (parse-Exp (third  xs)))

           (exp-op1 (parse-Op1  (first  xs))
                    (parse-Exp (second xs))
                    )

       ))]))

; ==============================================


(define (eval-op2 op)
  (type-case Op2 op
    [(op-add) +]
    [(op-sub) -]
    [(op-mul) *]
    [(op-div) /]
    [(op-pow) pow]))


(define (eval-op1 op)
  (type-case Op1 op
    [(op-fact) fact]
    [(op-opposite) opposite]))


(define (eval e)
  (type-case Exp e
    [(exp-number n)    n]
    [(exp-op2 op e1 e2) ((eval-op2 op) (eval e1) (eval e2))]
    [(exp-op1 op e)     ((eval-op1 op) (eval e)) ]))



(define exp1 (parse-Exp `(! (+ 4 1))))

(eval exp1)






























