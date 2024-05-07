#lang racket

(define (fibRek n)
  (cond [(= n 0) 0]
        [(= n 1) 1]
        [else (+ (fibRek (- n 1))(fibRek (- n 2))
                 )
              ]
        )
  )


(fibRek 7)


(define (fibIter n)
  (cond [(= n 0) 0]
        [(= n 1) 1]
        [else (define (iter licznik liczba1 liczba2)
                (if (= n licznik)
                    (+ liczba1 liczba2)
                    (iter (+ licznik 1) liczba2 (+ liczba1 liczba2))))
              (iter 2 0 1)]))


(fibIter 7)