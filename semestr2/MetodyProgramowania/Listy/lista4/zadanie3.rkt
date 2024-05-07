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


(define example-tree2
  (node (node (leaf) 10 (leaf))
        2
        (node (node (leaf) 3 (leaf))
              4
              (leaf))))



(define t
   (node
     (node (leaf) 2 (leaf))
     5
     (node (node (leaf) 6 (leaf))
            8
            (node (leaf) 9 (leaf)))))



(define t-sum
   (node
     (node (leaf) 7 (leaf))
     5
     (node (node (leaf) 19 (leaf ))
            13
            (node (leaf) 22 (leaf)))))




(define (bst? tree)
  (define (pom tree min max)
    (cond [(leaf? tree) #t]
        [(and (< min (node-elem tree) max)
             (pom (node-l tree) min (node-elem tree))
             (pom (node-r tree) (node-elem tree) max)) #t]
        [else #f]))
  (pom tree -inf.0 +inf.0))


(check-equal? (bst? example-tree) #t)
(check-equal? (bst? example-tree2) #f)
(check-equal? (bst? t) #t)
(check-equal? (bst? (leaf)) #t)




(define (sum-paths tree)
  (define (sum-paths2 tree counter)
    (cond [(leaf? tree) (leaf)]
        [(node? tree) (node (sum-paths2 (node-l tree) (+ counter (node-elem tree))) (+ counter (node-elem tree)) (sum-paths2 (node-r tree) (+ counter (node-elem tree))))]))

  (sum-paths2 tree 0)
  )


"sum-paths t"
(sum-paths t)

(check-equal? (sum-paths t) t-sum)
(check-equal? (sum-paths (leaf)) (leaf))


  







