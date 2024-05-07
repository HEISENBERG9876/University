#lang racket
(require rackunit)

(define-struct leaf () #:transparent)
(define-struct node (l elem r) #:transparent)


(define (tree? x)
  (cond [(leaf? x) #t]
        [(node? x) (and (tree? (node-l x))
                        (tree? (node-r x)))]
        [else #f]))


(define (tree-node l elem r)
  (if (and (tree? l) (tree? r) (number? elem))
      (node l elem r)
      (error "nieprawidłowe pola węzła")))

(define (tree-alt? x)
  (or (leaf? x)
      (and (node? x)
           (tree-alt? (node-l x))
           (tree-alt? (node-r x)))))



(define (find-bst x t)
  (cond [(leaf? t) #f]
        [(node? t)
         (cond [(= x (node-elem t)) #t]
               [(< x (node-elem t))
                (find-bst x (node-l t))]
               [else
                (find-bst x (node-r t))])]))

(define (insert-bst x t)
  (cond [(leaf? t) (node (leaf) x (leaf))]
        [(node? t)
         (cond [(= x (node-elem t)) t]
                [(< x (node-elem t))
                 (node (insert-bst x (node-l t))
                       (node-elem t)
                       (node-r t))]
                [else
                 (node (node-l t)
                       (node-elem t)
                       (insert-bst x (node-r t)))])]))



;;;;;;;;;;;;;;;;;;;;;;;;;;

(define example-tree
  (node (node (leaf) 1 (leaf))
        2
        (node (node (leaf) 3 (leaf))
              4
              (leaf))))

"example-tree"
example-tree

(define example-tree2
  (node (leaf) 3 (node (leaf) 4 (node (leaf) 5 (node (leaf) 6 (leaf))))))



(define (tree-foldr f x tree)
  (cond [(leaf? tree) x]
      [(node? tree) (f (tree-foldr f x (node-l tree)) (node-elem tree) (tree-foldr f x (node-r tree)))]))




(define (tree-sum tree)
  (tree-foldr + 0 tree))

(check-equal? (tree-sum example-tree) 10)
(check-equal? (tree-sum example-tree2) 18)
(check-equal? (tree-sum (leaf)) 0)



(define (tree-flip tree)
  (tree-foldr (lambda(lewy elem prawy) (node prawy elem lewy)) (leaf) tree))

(define flipped (tree-flip example-tree))
(define flipped2 (tree-flip example-tree2))
"flipped example-tree"
flipped
(check-equal? (tree-flip flipped) example-tree)
(check-equal? (tree-flip flipped2) example-tree2)
(check-equal? (tree-flip (leaf)) (leaf))




(define (tree-height tree)
  (tree-foldr (lambda (x y z) (+ 1 (max x z))) 1 tree))

(check-equal? (tree-height example-tree) 4)
(check-equal? (tree-height example-tree2) 5)
(check-equal? (tree-height (leaf)) 1)




(define (tree-span tree)
  (cons (tree-foldr min +inf.0 tree) (tree-foldr max -inf.0 tree)))

(check-equal? (tree-span example-tree) (cons 1.0 4.0))
(check-equal? (tree-span example-tree2) (cons 3.0 6.0))




(define (flatten tree)
  (tree-foldr (lambda (left elem right)(append left (list elem) right))
              '()
              tree))

(check-equal? (flatten example-tree) '(1 2 3 4))
(check-equal? (flatten example-tree2) '(3 4 5 6))
(check-equal? (flatten (leaf)) '())





(define (flatten2 tree)
  (define (flatten-pom tree xs)
    (if (leaf? tree)
        xs
        (flatten-pom (node-l tree) 
                     (cons (node-elem tree)
                           (flatten-pom (node-r tree) xs)))))
  (flatten-pom tree '()))




(flatten2 example-tree)







