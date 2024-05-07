#lang racket

(define morse-map
  (hash
    #\a "._"
    #\b "_..."
    #\c "_._."
    #\d "_.."
    #\e "."
    #\f ".._."
    #\g "__."
    #\h "...."
    #\i ".."
    #\j ".___"
    #\k "_._"
    #\l "._.."
    #\m "__"
    #\n "_."
    #\o "___"
    #\p ".__."
    #\q "__._"
    #\r "._."
    #\s "..."
    #\t "_"
    #\u ".._"
    #\v "..._"
    #\w ".__"
    #\x "_.._"
    #\y "_.__"
    #\z "__.."
    #\A "._"
    #\B "_..."
    #\C "_._."
    #\D "_.."
    #\E "."
    #\F ".._."
    #\G "__."
    #\H "...."
    #\I ".."
    #\J ".___"
    #\K "_._"
    #\L "._.."
    #\M "__"
    #\N "_."
    #\O "___"
    #\P ".__."
    #\Q "__._"
    #\R "._."
    #\S "..."
    #\T "_"
    #\U ".._"
    #\V "..._"
    #\W ".__"
    #\X "_.._"
    #\Y "_.__"
    #\Z "__.."
    #\0 "_____"
    #\1 ".____"
    #\2 "..___"
    #\3 "...__"
    #\4 "...._"
    #\5 "....." 
    #\6 "_...."
    #\7 "__..."
    #\8 "___.."
    #\9 "____."
    #\. "."
    #\_ "_"
    ))


(define (morse-code input_str)
  (define char_list (string->list input_str))
  (define (char_list->morse_str_list xs prev_spaces)
    (cond [(null? xs) null]
          [(and (char-whitespace? (car xs))(= prev_spaces 0)) (cons " " (char_list->morse_str_list (cdr xs) (+ prev_spaces 1)))] ;spacje dodajemy tylko, gdy pojawia sie po raz pierwszy
          [(and (char-whitespace? (car xs))(> prev_spaces 0)) (cons "" (char_list->morse_str_list (cdr xs) (+ prev_spaces 1)))]
          [else (cons (hash-ref morse-map (car xs)) (cons " " (char_list->morse_str_list (cdr xs) 0)))]))
  (define result (string-join (char_list->morse_str_list char_list 0) "")) ;wynik: laczymy liste string'ow w kodzie morse'a w jeden string
  (substring result 0 (- (string-length result) 1)) ;zmianka kosmetyczna, usuniecie spacji na koncu
)



(define str1 "Metodyprogramowania")
(define str2 "Metody        programowania")
(morse-code str1)
(morse-code str2)




























































