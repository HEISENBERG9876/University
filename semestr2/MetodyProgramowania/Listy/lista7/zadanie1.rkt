#lang plait


(define-type (2-3Tree 'a)
  (leaf)
  (single-node [elem : 'a] [l : (2-3Tree 'a)] [r : (2-3Tree 'a)])
  (double-node [elem1 : 'a] [elem2 : 'a] [l : (2-3Tree 'a)] [m : (2-3Tree 'a)] [r : (2-3Tree 'a)])
  )

; sprawdza max dlugosc od korzenia do liscia

(define (height [tree : (2-3Tree 'a)])
  (cond
    [(leaf? tree) 1]
    [(single-node? tree) (+ (max (height (single-node-l tree)) (height (single-node-r tree))) 1)]
    [(double-node? tree) (+ (max (height (double-node-l tree)) (max (height (double-node-m tree)) (height (double-node-r tree)))) 1)]
    ))


; sprawdza czy dlugosc od korzenia do kazdego liscia jest taka sama

(define (equal_length? [tree : (2-3Tree 'a)])
  (cond [(leaf? tree) #t]
        [(single-node? tree) (= (height (single-node-l tree)) (height (single-node-r tree)))]
        [(double-node? tree) (and (= (height (double-node-l tree)) (height (double-node-r tree)))
                                  (= (height (double-node-l tree)) (height (double-node-m tree))))]
     ))


;testy

(define tree1 (single-node 1 (leaf) (leaf)))
(define tree2 (single-node 1 (leaf) (single-node 1 (leaf) (leaf))))

(equal_length? tree1)
(equal_length? tree2)


;kod z racket
;(define (bst? tree)
;  (define (pom tree min max)
;    (cond [(leaf? tree) #t]
;        [(and (< min (node-elem tree) max)
;             (pom (node-l tree) min (node-elem tree))
;            (pom (node-r tree) (node-elem tree) max)) #t]
;       [else #f]))
;  (pom tree -inf.0 +inf.0))



(define (pom tree min max) ;min to minimalna dopuszczalna wartosc, max to maksymalna
    (cond
      [(leaf? tree) #t]
      [(single-node? tree)
         (and (and (< min (single-node-elem tree)) (< (single-node-elem tree) max))  ; sprawdzamy czy min < double-node-elem1 tree < max dla elem
             (pom (single-node-l tree) min (single-node-elem tree))
             (pom (single-node-r tree) (single-node-elem tree) max))]
      [(double-node? tree)
       (and (< (double-node-elem1 tree) (double-node-elem2 tree))
            (and (< min (double-node-elem1 tree)) (< (double-node-elem1 tree) max))  ; sprawdzamy czy min < double-node-elem1 tree < max dla elem1
            (and (< min (double-node-elem2 tree)) (< (double-node-elem2 tree) max))  ; sprawdzamy czy min < double-node-elem1 tree < max dla elem2
             (pom (double-node-l tree) min (double-node-elem1 tree))
             (pom (double-node-r tree) (double-node-elem2 tree) max)
             (pom (double-node-m tree) (double-node-elem1 tree) (double-node-elem2 tree)))]

        [else #f]))


(define (23-tree? tree)
  (and (pom tree -inf.0 +inf.0) (equal_length? tree))
  )

(23-tree? tree2)














































































