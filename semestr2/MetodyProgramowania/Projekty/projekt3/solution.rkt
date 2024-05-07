#lang plait

(module+ test
  (print-only-errors #t))

;TYPY WYRAZEN
(define-type Exp
  (defE [args : (Listof Exp)] [e : Exp])
  (funE [name : Symbol] [args : (Listof Exp)] [b : Exp])
  (numE [n : Number])
  (varE [x : Symbol])
  (ifzE [e0 : Exp] [e1 : Exp] [e2 : Exp])
  (letE [x : Symbol] [e1 : Exp] [e2 : Exp])
  (appE [f : Symbol] [args : (Listof Exp)])
  (opE  [op : Op] [l : Exp] [r : Exp]))

(define-type Op
  (add) (sub) (mul) (leq))

;FUNKCJE POMOCNICZE DO PARSERA
(define (fifth [xs : (Listof 'a)]) : 'a
  (list-ref xs 4))

(define (sixth [xs : (Listof 'a)]) : 'a
  (list-ref xs 5))

;PARSER
(define (parse [s : S-Exp]) : Exp
  (if (s-exp-match? `{define {ANY ...} for ANY} s)
      (defE (map parse (s-exp->list (second (s-exp->list s))))
            (parse-exp (fourth (s-exp->list s))))
      (parse-exp s)))

(define (parse-exp [s : S-Exp]) : Exp
  (cond
    [(s-exp-match? `NUMBER s)
     (numE (s-exp->number s))]
    [(s-exp-match? `{ANY SYMBOL ANY} s)
     (opE (parse-op (s-exp->symbol (second (s-exp->list s))))
          (parse-exp (first (s-exp->list s)))
          (parse-exp (third (s-exp->list s))))]
    [(s-exp-match? `{ifz ANY then ANY else ANY} s)
     (ifzE (parse-exp (second (s-exp->list s)))
           (parse-exp (fourth (s-exp->list s)))
           (parse-exp (sixth (s-exp->list s))))]
    [(s-exp-match? `SYMBOL s)
     (varE (s-exp->symbol s))]
    [(s-exp-match? `{let SYMBOL be ANY in ANY} s)
     (letE (s-exp->symbol (second (s-exp->list s)))
           (parse-exp (fourth (s-exp->list s)))
           (parse-exp (sixth (s-exp->list s))))]
    [(s-exp-match? `{fun SYMBOL {ANY ...} = ANY} s)
     (funE (s-exp->symbol (second (s-exp->list s)))
           (map parse (s-exp->list (third (s-exp->list s))))
           (parse-exp (fifth (s-exp->list s))))]
    [(s-exp-match? `{SYMBOL {ANY ...}} s)
     (appE (s-exp->symbol (first (s-exp->list s)))
           (map parse (s-exp->list (second (s-exp->list s)))))]
    [else (error 'parse "invalid input")]))

(define (<= [x : Number] [y : Number]) : Number
  (if (or (< x y) (= x y))
      0
      1))

(define (op->proc [op : Op]) : (Number Number -> Number)
  (type-case Op op
    [(add) +]
    [(sub) -]
    [(mul) *]
    [(leq) <=]))

(define (parse-op [op : Symbol]) : Op
  (cond
    [(eq? op '+) (add)]
    [(eq? op '-) (sub)]
    [(eq? op '*) (mul)]
    [(eq? op '<=) (leq)]
    [else (error 'parse "unknown operator")]))

;SRODOWISKA
(define-type-alias Value Number)

(define-type Storable
  (valS [v : 'a])) ;mozemy tu dac liczbe i funkcje

(define-type Binding
  (bind [name : Symbol]
        [val : Storable]))

(define-type-alias Env (Listof Binding))

(define mt-env empty)

(define (extend-env [env : Env] [x : Symbol] [v : 'a]) : Env
  (cons (bind x  (valS v)) env))

(define (extend-var-env [env : Env] [vars : (Listof Exp)] [args : (Listof Value)]) : Env
  (type-case (Listof Exp) vars
    [empty env]
    [(cons var vars)
     (type-case Exp var
       [(varE x)
        (if (find env x)
            (error 'eval "function argument is taken")
            (extend-var-env (extend-env env x (first args)) vars (rest args)))]
       [else (error 'eval "invalid function variable")])]
    ))

(define (extend-fun-env [env : Env] [funs : (Listof Exp)]) : Env
  (type-case (Listof Exp) funs
    [empty env]
    [(cons fun funs)
     (type-case Exp fun
       [(funE name args body)
           (if (find env name)
               (error 'define "function identifiers must be unique")
               (extend-fun-env (extend-env env name fun) funs))]
       [else (error 'define "expression contains a non-function")])]
    ))

(define (find-var [env : Env] [x : Symbol]) : Storable
  (type-case (Listof Binding) env
    [empty (error 'lookup "unbound expression")]
    [(cons b rst-env) (cond
                        [(eq? x (bind-name b))
                         (bind-val b)]
                        [else
                         (find-var rst-env x)])]
    ))

(define (find [env : Env] [f : Symbol]) : Boolean ;do znajdowania w środowisku
  (type-case (Listof Binding) env
    [empty #f]
    [(cons x xs)
     (if (equal? (bind-name x) f)
         #t
         (find xs f))]
    ))

(define (lookup-env [x : Symbol] [env : Env]) : 'a
  (type-case Storable (find-var env x)
    [(valS v) v]))

;EVAL

(define (eval [e : Exp] [var-env : Env] [fun-env : Env]) : Value
  (type-case Exp e
    [(defE args e)
     (eval e var-env (extend-fun-env fun-env args))]
    [(numE n) n]
    [(varE x)
     (lookup-env x var-env)]
    [(ifzE e0 e1 e2)
     (if (= (eval e0 var-env fun-env) 0)
         (eval e1 var-env fun-env)
         (eval e2 var-env fun-env))]
    [(letE x e1 e2)
     (let ([v1 (eval e1 var-env fun-env)])
       (eval e2 (extend-env var-env x v1) fun-env))]
    [(opE o l r)
     ((op->proc o) (eval l var-env fun-env) (eval r var-env fun-env))]
    [(appE f args)
       (apply f args var-env fun-env)]
    [(funE name args body)
     (error 'function "no arguments given")]))

(define (apply [f : Symbol] [args : (Listof Exp)] [env-var : Env] [env-fun : Env]) : Value
  (type-case Exp (lookup-env f env-fun)
    [(funE name vars body)
     (if (= (length vars) (length args))
         (eval body (extend-var-env mt-env vars (eval-list args env-var env-fun)) env-fun)
         (error 'apply "argument  mismatch"))]
    [else (error 'apply "not a function")]))

(define (eval-list [vars : (Listof Exp)] [env-var : Env] [env-fun : Env]) : (Listof Value)
  (type-case (Listof Exp) vars
    [(cons var vars)
     (cons (eval var env-var env-fun) (eval-list vars env-var env-fun))]
    [empty empty]))

(define (run [program : S-Exp]) : Value
  (eval (parse program) mt-env mt-env))

;PRINTER

(define (print-value [v : Value]) : Void
  (display v))

(define (main [e : S-Exp]) : Void
  (print-value (eval (parse e) mt-env mt-env)))

(module+ test
  (test (run `{define
                {[fun fact (n) = {ifz n then 1 else {n * {fact ({n - 1})}}}]}
                for {fact (5)}})
        120)
  (test (run `{define
                {[fun even (n) = {ifz n then 0 else {odd ({n - 1})}}]
                 [fun odd (n) = {ifz n then 42 else {even ({n - 1})}}]}
                for {even (1024)}})
        0)
  (test (run `{define
                {[fun gcd (m n) = {ifz n then m else
                                       {ifz {m <= n}
                                            then {gcd (m {n - m})}
                                            else {gcd ({m - n} n)}}}]}
                for {gcd (81 63)}})
        9))
