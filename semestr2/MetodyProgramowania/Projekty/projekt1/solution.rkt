#lang racket

(provide (struct-out column-info)
         (struct-out table)
         (struct-out and-f)
         (struct-out or-f)
         (struct-out not-f)
         (struct-out eq-f)
         (struct-out eq2-f)
         (struct-out lt-f)
         table-insert
         table-project
         table-sort
         table-select
         table-rename
         table-cross-join
         table-natural-join
         )

(define-struct column-info (name type) #:transparent)
(define-struct table (schema rows) #:transparent)
(define-struct and-f (l r)) ; koniunkcja formuł
(define-struct or-f (l r)) ; dysjunkcja formuł
(define-struct not-f (e)) ; negacja formuły
(define-struct eq-f (name val)) ; wartość kolumny name równa val
(define-struct eq2-f (name name2)) ; wartości kolumn name i name2 równe
(define-struct lt-f (name val)) ; wartość kolumny name mniejsza niż val


(define cities
  (table
   (list (column-info 'city    'string)
         (column-info 'country 'string)
         (column-info 'area    'number)
         (column-info 'capital 'boolean))
   (list (list "Wrocław" "Poland"  293 #f)
         (list "Warsaw"  "Poland"  517 #t)
         (list "Poznań"  "Poland"  262 #f)
         (list "Berlin"  "Germany" 892 #t)
         (list "Munich"  "Germany" 310 #f)
         (list "Paris"   "France"  105 #t)
         (list "Rennes"  "France"   50 #f))))

(define countries
  (table
   (list (column-info 'country 'string)
         (column-info 'population 'number))
   (list (list "Poland" 38)
         (list "Germany" 83)
         (list "France" 67)
         (list "Spain" 47))))

(define (empty-table columns) (table columns '()))


;;;;;;;;;;;;;;;

;Funkcja zwracająca typ wartości
(define (type-of value)
  (cond ((number? value) 'number)
        ((string? value) 'string)
        ((symbol? value) 'symbol)
        ((boolean? value) 'boolean)
        (else (error "Unsupported type" value))))


;;;;;;;;;;;;;;

; Wstawianie

(define (table-insert row tab)
  (unless (= (length row) (length (table-schema tab)))
    (error "Number of columns doesn't match the schema"))
  (let loop ((cols (table-schema tab))
             (vals row))
    (cond
      ((and (null? cols) (null? vals))
       (table (table-schema tab) (cons row (table-rows tab))))
      ((null? cols)
       (error "Row has too many columns"))
      ((null? vals)
       (error "Row has too few columns"))
      ((not (equal? (column-info-type (car cols))
                    (type-of (car vals))))
       (error "Column types don't match"))
      (else
       (loop (cdr cols) (cdr vals))))))

;;;;;;;;;;;;;;;;;;;;

; Znajdowanie indexu

(define (index-of element lst)
  (let loop ((lst lst) (index 0))
    (cond ((null? lst) #f)
          ((equal? element (car lst)) index)
          (else (loop (cdr lst) (+ 1 index))))))


(define (filter-index index-list lst)
  (let loop ((lst lst) (index 0) (result '()))
    (cond ((null? lst) (reverse result))
          ((member index index-list)
           (loop (cdr lst) (+ 1 index)
                 (cons (car lst) result)))
          (else (loop (cdr lst) (+ 1 index) result)))))

;;;;;;;;;;;;;;;;;;;;

; Projekcja

(define (table-project cols tab)
  (let* ((index-list (map (lambda (col-info) (column-info-name col-info))
                          (table-schema tab)))
         (index-mapping (map (lambda (col) (index-of col index-list))
                             cols))
         (filtered-schema (filter-index index-mapping (table-schema tab)))
         (filtered-rows (map (lambda (row) (filter-index index-mapping row))
                              (table-rows tab))))
    (table filtered-schema filtered-rows)))

;;;;;;;;;;;;;;;;;;;;




(define (select-cols indices row)
  (map (lambda (i) (list-ref row i)) indices)
  )

(define (lexicographic<=? lst1 lst2)
  (cond ((and (null? lst1) (null? lst2)) #t)
        ((null? lst1) #t)
        ((null? lst2) #f)
        ((and (string? (car lst1)) (string? (car lst2)))
         (cond ((string=? (car lst1) (car lst2)) (lexicographic<=? (cdr lst1) (cdr lst2)))
               ((string<? (car lst1) (car lst2)) #t)
               (else #f)))
        ((and (number? (car lst1)) (number? (car lst2)))
         (cond ((= (car lst1) (car lst2)) (lexicographic<=? (cdr lst1) (cdr lst2)))
               ((< (car lst1) (car lst2)) #t)
               (else #f)))
        ((and (boolean? (car lst1)) (boolean? (car lst2)))
         (cond ((= (if (car lst1) 1 0) (if (car lst2) 1 0)) (lexicographic<=? (cdr lst1) (cdr lst2)))
               ((< (if (car lst1) 1 0) (if (car lst2) 1 0)) #t)
               (else #f)))
        (else (error "Invalid arguments to lexicographic<=?")))
  )

(lexicographic<=? '(1 2 3 3) '(1 2 3 4))


; Sortowanie

(define (table-sort cols tab)
  (let* ((col-indices (map (lambda (col)
                             (find-column-index col (table-schema tab)))
                           cols))
         (sorted-rows (sort (table-rows tab)
                                   (lambda (row1 row2)
                                     (lexicographic<=? (select-cols col-indices row1)
                                                      (select-cols col-indices row2))))))
    (make-table (table-schema tab) sorted-rows)))

;;;;;;;;;;;;;;;;;;;;

(define (eval-form form row schema)
  (cond
    ((and-f? form)
     (and (eval-form (and-f-l form) row schema)
          (eval-form (and-f-r form) row schema)))
    ((or-f? form)
     (or (eval-form (or-f-l form) row schema)
         (eval-form (or-f-r form) row schema)))
    ((not-f? form)
     (not (eval-form (not-f-e form) row schema)))
    ((eq-f? form)
     (let ((name (eq-f-name form))
           (val (eq-f-val form)))
       (equal? (row-get name row schema) val)))
    ((eq2-f? form)
     (let ((name (eq2-f-name form))
           (name2 (eq2-f-name2 form)))
       (equal? (row-get name row schema)
               (row-get name2 row schema))))
    ((lt-f? form)
     (let ((name (lt-f-name form))
           (val (lt-f-val form)))
       (< (row-get name row schema) val)))
    (else (error "Invalid form."))))


(define (row-get name row schema)
  (let ((idx (find-column-index name schema)))
    (list-ref row idx)))

(define (find-column-index name schema)
  (let loop ((schema schema)
             (idx 0))
    (cond
      ((null? schema) (error "Column not found."))
      ((eq? name (column-info-name (car schema))) idx)
      (else (loop (cdr schema) (+ idx 1))))))


;;;;;;;;;;;;;;;;;;

; Selekcja

(define (table-select form tab)
  (let ((rows (table-rows tab))
        (schema (table-schema tab)))
    (make-table schema
                (filter (lambda (row)
                          (eval-form form row schema))
                        rows))))


;;;;;;;;;;;;;;;;;;;;;;;

(define (replace-column-name col ncol schema)
  (map (lambda (c)
         (if (eq? col (column-info-name c))
             (column-info ncol (column-info-type c))
             c))
       schema))

(define (replace-nth n new lst)
  (if (zero? n)
      (cons new (cdr lst))
      (cons (car lst) (replace-nth (- n 1) new (cdr lst))))) 


; Zmiana nazwy

(define (table-rename col ncol tab)
  (let* ((old-schema (table-schema tab))
         (col-index (find-column-index col old-schema))
         (new-schema (replace-column-name col ncol old-schema)))
    (table new-schema (table-rows tab))))

;;;;;;;;;;;;;;;;;;;;;;;

; Złączenie kartezjańskie

(define (table-cross-join tab1 tab2)
  (let* ((cols1 (table-schema tab1))
         (cols2 (table-schema tab2))
         (all-cols (append cols1 cols2))
         (rows1 (table-rows tab1))
         (rows2 (table-rows tab2))
         (all-rows (map (lambda (r1) 
                          (map (lambda (r2) 
                                 (append r1 r2)) 
                               rows2)) 
                        rows1))
         (all-rows-flat (apply append all-rows)))
    (make-table all-cols all-rows-flat)))

;;;;;;;;;;;;;;;;;;;;;;;

; Złączenie

(define (table-natural-join tab1 tab2) display 1)