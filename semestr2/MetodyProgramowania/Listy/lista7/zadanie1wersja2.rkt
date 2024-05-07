#lang plait


(define-type (2-3Tree 'a)
  (leaf)
  (single-node [elem : 'a] [l : (2-3Tree 'a)] [r : (2-3Tree 'a)])
  (double-node [elem1 : 'a] [elem2 : 'a] [l : (2-3Tree 'a)] [m : (2-3Tree 'a)] [r : (2-3Tree 'a)])
  )

; sprawdza max dlugosc od korzenia do liscia

(define (height [tree : (2-3Tree 'a)])
  (type-case (2-3Tree 'a) tree
    [(leaf) 1]
    [(single-node elem left right) (+ (max (height left) (height right)) 1)]
    [(double-node elem1 elem2 left middle right) (+ (max (height left) (max (height middle) (height right))) 1)]
    ))


; sprawdza czy dlugosc od korzenia do kazdego liscia jest taka sama

(define (equal_length? [tree : (2-3Tree 'a)])
  (type-case (2-3Tree 'a) tree
    [(leaf) #t]
    [(single-node elem left right) (= (height left) (height right))]
    [(double-node elem1 elem2 left middle right) (and (= (height left) (height right))
                              (= (height left) (height middle)))]
     ))


;testy

(define tree1 (single-node 1 (leaf) (leaf)))
(define tree2 (single-node 1 (leaf) (single-node 1 (leaf) (leaf))))


(define (pom tree min max) ;min to minimalna dopuszczalna wartosc, max to maksymalna
    (type-case (2-3Tree 'a) tree
      [(leaf) #t]
      [(single-node elem left right)
         (and (and (< min elem) (< elem max))  ; sprawdzamy czy min < double-node-elem1 tree < max dla elem
             (pom left min elem)
             (pom right elem max))]
      [(double-node elem1 elem2 left middle right)
       (and (< elem1 elem2)
            (and (< min elem1) (< elem1 max))  ; sprawdzamy czy min < double-node-elem1 tree < max dla elem1
            (and (< min elem2) (< elem2 max))  ; sprawdzamy czy min < double-node-elem1 tree < max dla elem2
             (pom left min elem1)
             (pom right elem2 max)
             (pom middle elem1 elem2))]
        ))


(define (2-3tree? tree)
  (and (pom tree -inf.0 +inf.0) (equal_length? tree))
  )


(2-3tree? tree1)
(2-3tree? tree2)