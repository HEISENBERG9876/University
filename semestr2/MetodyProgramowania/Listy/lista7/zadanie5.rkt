#lang racket



(define/contract (foldl-map f a xs)

   (parametric->/c [x acc y] (-> (-> x acc (cons/c y acc)) acc (listof x)
                              (cons/c (listof y) acc)))
   
   (define (it a xs ys)
      (if (null? xs)
          (cons (reverse ys) a)
          (let [(p (f (car xs) a))]
            (it (cdr p)
                 (cdr xs)
                 (cons (car p) ys)))))
   (it a xs null))



(foldl-map (lambda (x a) (cons a (+ a x))) 0 '(1 2 3))