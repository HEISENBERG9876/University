#lang racket

(define (min xs)
  (if (null? (cdr xs))
      (car xs)
      (if (< (car xs) (min (cdr xs)))
          (car xs)
          (min (cdr xs)))))



(define (select xs)
  (define (min xs)
    (if (null? (cdr xs))
        (car xs)
        (if (< (car xs) (min (cdr xs)))
            (car xs)
            (min (cdr xs)))))
  (define min_num (min xs))
  
  (define (select2 min_num xs prev)
    (if (null? min_num)
        null
        (if (= min_num (car xs))
            (append (cons min_num prev) (cdr xs))
            (select2 min_num (cdr xs) (append prev (list (car xs)))))))
  (select2 min_num xs null))


(define xs '(3 8 1 6 4 9 1))

(select xs)


;select zwraca liste z najmniejszym elementem na 1szym miejscu
(define (selection-sort xs)
  (define (sort xs result)
    (if (null? xs)
        result
        (sort (cdr (select xs)) (append result (list (car (select xs)))))))
    (sort xs '()))