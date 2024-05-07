#lang racket


(define lista (list 1 2 3))

;wersja1
;(define insert_perm
 ; (lambda(x ls)
  ;  (if(null? ls) (list (list x))
   ;    (cons (cons x ls)
    ;         (map (lambda(l) (cons (car ls) l))
     ;             (insert_perm x (cdr ls)))))))


;(define permut
 ; ;(lambda(ls)
    ;(if(null? ls) '(())
  ;     (apply append
     ;         (map (lambda(l) (insert_perm (car ls) l))
      ;             (permut (cdr ls)))))))


;(permut lista)



;wersja3
;(define (permutations2 items)
  ;(if (null? items) '(())
     ; (apply append
     ;        (map (lambda (element)
   ;         (map (lambda (permutation)
    ;           (cons element permutation))
  ;           (permutations2 (remove element items))))
 ;         items))))


;(permutations2 lista)


;test
;perm ()        = '()
;perm (1)       = '((1))
;perm (1 2)     = '((1 2) (2 1))
;perm ((1 2 3)) = '((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 2 1) (3 1 2))






;finalna


















