#lang racket
(require rackunit)


(define-struct leaf () #:transparent)
(define-struct node (l elem r) #:transparent)


(define example-tree
  (node (node (leaf) 1 (leaf))
        2
        (node (node (leaf) 3 (leaf))
              4
              (leaf))))

example-tree

(define (insert-bst x t)
  (cond [(leaf? t) (node (leaf) x (leaf))]
        [(node? t)
         (cond [(< x (node-elem t))
                 (node (insert-bst x (node-l t))
                       (node-elem t)
                       (node-r t))]
                [else
                 (node (node-l t)
                       (node-elem t)
                       (insert-bst x (node-r t)))])]))






(define (make-bst lista)
  (define tree (leaf))

  (define (pom lista1 tree1)
  (if (equal? null lista1)
      tree1
      (pom (cdr lista1) (insert-bst (car lista1) tree1))))
  (pom lista tree))



(define lista->bst (make-bst '( 3 2 1 5 4 6)))



(define (tree-foldr f x tree)
  (cond [(leaf? tree) x]
      [(node? tree) (f (tree-foldr f x (node-l tree)) (node-elem tree) (tree-foldr f x (node-r tree)))]))


(define (flatten tree)
  (tree-foldr (lambda (left elem right)(append left (list elem) right))
              '()
              tree))




(define (treesort xs)
  (define (make-bst lista)
    (define tree (leaf))

    (define (pom lista1 tree1)
      (if (equal? null lista1)
          tree1
          (pom (cdr lista1) (insert-bst (car lista1) tree1))))
    (pom lista tree))

  (define (flatten tree)
  (tree-foldr (lambda (left elem right)(append left (list elem) right))
              '()
              tree))

  (flatten (make-bst xs))


  )


(check-equal? (treesort '(6 5 4 3 2 1)) '(1 2 3 4 5 6))
(check-equal? (treesort '(6 5 4 3 2 6)) '(2 3 4 5 6 6))
(check-equal? (treesort '()) '())
(check-equal? (treesort '(1 1 1)) '(1 1 1))



