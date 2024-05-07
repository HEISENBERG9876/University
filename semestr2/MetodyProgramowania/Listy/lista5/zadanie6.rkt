#lang plait


(define-type (RoseTree 'a)
  (leaf)
  (node [elem : 'a] [children : (Listof (RoseTree 'a))]))


(define tree
  (node 5
        (list (node 4
                    (list (leaf)
                          (node 10
                                (list (leaf)
                                      (node 12 (list (node 13 (list (leaf)) )))))
                          (node 18
                                (list (leaf)
                                      (leaf)))
                          (node 16
                                (list (leaf)
                                      (leaf)))))
              (leaf)
              (node 3
                    (list (leaf)
                          (node 1 (list (leaf)))
                          (leaf)
                          (leaf))))))


tree




;(define (flatten2 tree)
 ; (define (flatten-pom tree xs)
  ;  (if (leaf? tree)
   ;     xs
    ;    (flatten-pom (node-l tree) 
     ;                (cons (node-elem tree)
      ;                     (flatten-pom (node-r tree) xs)))))
  ;(flatten-pom tree '()))



(define (flatten2 tree)
  (define (flatten-pom tree xs)
    (if (leaf? tree)
        xs
        (flatten-pom (node-l tree) 
                     (cons (node-elem tree)
                           (flatten-pom (node-r tree) xs)))))
  (flatten-pom tree '()))




























