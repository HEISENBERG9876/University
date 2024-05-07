#lang racket


(define morse-map-rev
  (hash
    "._" #\a
    "_..." #\b
    "_._." #\c
    "_.." #\d
    "." #\e 
    ".._." #\f
    "__." #\g
    "...." #\h
    ".." #\i
    ".___" #\j
    "_._" #\k
    "._.." #\l
    "__" #\m
    "_." #\n
    "___" #\o
    ".__." #\p
    "__._" #\q
    "._." #\r
    "..." #\s
    "_" #\t
    ".._" #\u
    "..._" #\v
    ".__" #\w
    "_.._" #\x
    "_.__" #\y
    "__.." #\z
     "._" #\A
    "_..." #\B
    "_._." #\C
    "_.." #\D
    "." #\E
    ".._." #\F
    "__." #\G
    "...." #\H
    ".." #\I
    ".___" #\J
    "_._" #\K
    "._.." #\L
    "__" #\M
    "_." #\N
    "___" #\O
    ".__." #\P
    "__._" #\Q
    "._." #\R
    "..." #\S
    "_" #\T
    ".._" #\U
    "..._" #\V
    ".__" #\W
    "_.._" #\X
    "_.__" #\Y
    "__.." #\Z
    "." #\.
    "_" #\_
    "_____" #\0
    ".____" #\1
    "..___" #\2
    "...__" #\3
    "...._" #\4
    "....." #\5
    "_...." #\6
    "__..." #\7
    "___.." #\8
    "____." #\9
    ))

(define str "__ .__.        ..___ _____ ..___ ..___")


(define (morse-decode str)
  (define char_list (string->list str))

  (define (morse_char_list->morse_string_list char_list morse_bufor) ;morse_string_list to lista liter w alfabecie morsa, zawiera spacje reprezentowane jako "", także zbędne.
    (cond [(null? char_list) (cons (list->string (reverse morse_bufor)) null)]
          [(char-whitespace? (car char_list)) (cons (list->string (reverse morse_bufor)) (morse_char_list->morse_string_list (cdr char_list) '()))]
          [else (morse_char_list->morse_string_list (cdr char_list)(append (list (car char_list)) morse_bufor))]))

  (define (string_list->result_list xs prev_spaces) ;result_list to lista liter w alfabecie lacinskim + spacje sa zamienione na #\space
    (cond [(null? xs) null]
          [(and (equal? "" (car xs)) (= prev_spaces 0)) (cons #\space (string_list->result_list (cdr xs) (+ prev_spaces 1)))]
          [(and (equal? "" (car xs)) (> prev_spaces 0)) (string_list->result_list (cdr xs) (+ prev_spaces 1))] ;nie dodajemy spacji, gdy pojawia się parę obok siebie.
          [else (cons (hash-ref morse-map-rev (car xs)) (string_list->result_list (cdr xs) 0))]))
  
  (define morse_string_list (morse_char_list->morse_string_list char_list '()))
  (define result_list (string_list->result_list morse_string_list 0))
  (list->string result_list)
  
  )


( morse-decode str)




















































