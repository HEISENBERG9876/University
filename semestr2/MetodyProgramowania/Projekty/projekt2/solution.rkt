#lang racket
(require data/heap)

(provide sim? wire?
   (contract-out
    [make-sim (-> sim?)]
    [sim-wait!       (-> sim? positive? void?)]
    [sim-time        (-> sim? real?)]
    [sim-add-action! (-> sim? positive? (-> any/c) void?)]

    [make-wire       (-> sim? wire?)]
    [wire-on-change! (-> wire? (-> any/c) void?)]
    [wire-value      (-> wire? boolean?)]
    [wire-set!       (-> wire? boolean? void?)]

    [gate-not  (-> wire? wire? void?)]
    [gate-and  (-> wire? wire? wire? void?)]
    [gate-nand (-> wire? wire? wire? void?)]
    [gate-or   (-> wire? wire? wire? void?)]
    [gate-nor  (-> wire? wire? wire? void?)]
    [gate-xor  (-> wire? wire? wire? void?)]

    [wire-not  (-> wire? wire?)]
    [wire-and  (-> wire? wire? wire?)]
    [wire-nand (-> wire? wire? wire?)]
    [wire-or   (-> wire? wire? wire?)]
    [wire-nor  (-> wire? wire? wire?)]
    [wire-xor  (-> wire? wire? wire?)]

    [bus-value (-> (listof wire?) natural?)]
    [bus-set!  (-> (listof wire?) natural? void?)]

    [flip-flop (-> wire? wire? wire? void?)]
    ))


;;;;;;;;;;;;;;;;;;;;;SYMULACJA
(struct sim ([current-time #:mutable] event-queue))
(struct action ([time #:mutable] function))

;make-sim
(define (make-sim) (sim 0 (make-heap (lambda (action1 action2) (<= (action-time action1) (action-time action2))))))

;sim-time
(define (sim-time sim)
  (sim-current-time sim))

;sim-add-action
(define (sim-add-action! sim1 delay action-f)
  (define event-queue (sim-event-queue sim1))
  (define exec-time (+ (sim-current-time sim1) delay))
  (heap-add! event-queue (action exec-time action-f)))

;sim-wait
(define (sim-wait! sim wait-time)
  (define sim-end-time (+ (sim-time sim) wait-time))
  (define action-heap (sim-event-queue sim))

  (define (call-each-action)
    (if (= (heap-count action-heap) 0)
        (void)
        (let*
            ([action (heap-min action-heap)]
             [action-exec-time (action-time action)]
             [function (action-function action)])
          (if (< action-exec-time sim-end-time)
              (begin
                (function)
                (heap-remove-min! action-heap)
                (call-each-action))
              (void)))))
  
  (begin (call-each-action)
         (set-sim-current-time! sim sim-end-time)))


;;;;;;;;;;;;;;;;;;;;;;;PRZEWODY
(struct wire (sim [val #:mutable] [actions #:mutable]))

;make-wire
(define (make-wire sim)
  (wire sim #f '()))

;wire-value
(define (wire-value wire)
  (wire-val wire))

;funkcja pomocnicza do wire-set!, dodaje wszystkie akcje z przewodu do symulacji
(define (add-all-actions-to-sim! wire)
  (define sim1 (wire-sim wire))
  (define action-list (wire-actions wire))
  
  (define (action-adder action-list)
    (if (null? action-list)
        (void)
        (let* ([current-action (car action-list)]
               [delay (action-time current-action)]
               [function (action-function current-action)])
          (begin
            (sim-add-action! sim1 delay function)
            (action-adder (cdr action-list))))))
  
  (action-adder action-list))

;wire-set!
(define (wire-set! wire new-val)
  (if (equal? (wire-val wire) new-val)
      (void)
      (begin (set-wire-val! wire new-val) (add-all-actions-to-sim! wire))))

;wire-on-change
(define (wire-on-change! wire action-to-add)
  (define new-actions (cons action-to-add (wire-actions wire)))
  (begin
    ((action-function action-to-add))
    (set-wire-actions! wire new-actions)
    ))


;;;;;;;;;;;;;;;;;;;;;;BRAMKI

(define not-delay 1)
(define and-delay 1)
(define or-delay 1)
(define xor-delay 2)
(define nor-delay 1)
(define nand-delay 1)


;bramka not
(define (gate-not input-wire output-wire)
  (define not-output-function
    (lambda ()
      (let ([val (wire-val input-wire)])
        (wire-set! output-wire (not val)))))
  (wire-on-change! input-wire (action not-delay not-output-function)))

;bramka and
(define (gate-and input-wire1 input-wire2 output-wire)
  (define and-output-function
    (lambda ()
      (let ([val1 (wire-val input-wire1)]
            [val2 (wire-val input-wire2)])
        (wire-set! output-wire (and val1 val2)))))
  (begin
    (wire-on-change! input-wire1 (action and-delay and-output-function))
    (wire-on-change! input-wire2 (action and-delay and-output-function))))

;bramka or
(define (gate-or input-wire1 input-wire2 output-wire)
  (define or-output-function
    (let ([val1 (wire-val input-wire1)]
            [val2 (wire-val input-wire2)])
    (lambda ()
      (wire-set! output-wire (or val1 val2)))))
  (begin
    (wire-on-change! input-wire1 (action or-delay or-output-function))
    (wire-on-change! input-wire2 (action or-delay or-output-function))))

;bramka xor
(define (gate-xor input-wire1 input-wire2 output-wire)
  (define xor-output-function
    (lambda ()
      (let ([val1 (wire-val input-wire1)]
            [val2 (wire-val input-wire2)])
        (wire-set! output-wire (xor val1 val2)))))
  (begin
    (wire-on-change! input-wire1 (action xor-delay xor-output-function))
    (wire-on-change! input-wire2 (action xor-delay xor-output-function))))

;bramka nand
(define (gate-nand input-wire1 input-wire2 output-wire)
  (define nand-output-function
    (lambda ()
      (let ([val1 (wire-val input-wire1)]
            [val2 (wire-val input-wire2)])
        (wire-set! output-wire (nand val1 val2)))))
  (begin
    (wire-on-change! input-wire1 (action nand-delay nand-output-function))
    (wire-on-change! input-wire2 (action nand-delay nand-output-function))))

;bramka nor
(define (gate-nor input-wire1 input-wire2 output-wire)
  (define nor-output-function
    (lambda ()
      (let ([val1 (wire-val input-wire1)]
            [val2 (wire-val input-wire2)])
        (wire-set! output-wire (nor val1 val2)))))
  (begin
    (wire-on-change! input-wire1 (action nor-delay nor-output-function))
    (wire-on-change! input-wire2 (action nor-delay nor-output-function))))


;MAGISTRALE
(define (bus-set! wires value)
  (match wires
    ['() (void)]
    [(cons w wires)
     (begin
       (wire-set! w (= (modulo value 2) 1))
       (bus-set! wires (quotient value 2)))]))

(define (bus-value ws)
  (foldr (lambda (w value) (+ (if (wire-value w) 1 0) (* 2 value)))
         0
         ws))


;PRZEWODY- funkcje łączące bramki z przewodami

;not wire
(define (wire-not input-wire)
  (define new-wire (make-wire (wire-sim input-wire)))
  (gate-not input-wire new-wire)
  new-wire)

;and wire
(define (wire-and input-wire1 input-wire2)
  (define new-wire (make-wire (wire-sim input-wire1)))
  (gate-and input-wire1 input-wire2 new-wire)
  new-wire)

;or wire
(define (wire-or input-wire1 input-wire2)
  (define new-wire (make-wire (wire-sim input-wire1)))
  (gate-or input-wire1 input-wire2 new-wire)
  new-wire)

;xor wire
(define (wire-xor input-wire1 input-wire2)
  (define new-wire (make-wire (wire-sim input-wire1)))
  (gate-xor input-wire1 input-wire2 new-wire)
  new-wire)

;nand wire
(define (wire-nand input-wire1 input-wire2)
  (define new-wire (make-wire (wire-sim input-wire1)))
  (gate-nand input-wire1 input-wire2 new-wire)
  new-wire)

;nor wire
(define (wire-nor input-wire1 input-wire2)
  (define new-wire (make-wire (wire-sim input-wire1)))
  (gate-nor input-wire1 input-wire2 new-wire)
  new-wire)


;PRZERZUTNIK
(define (flip-flop out clk data)
  (define sim (wire-sim data))
  (define w1  (make-wire sim))
  (define w2  (make-wire sim))
  (define w3  (wire-nand (wire-and w1 clk) w2))
  (gate-nand w1 clk (wire-nand w2 w1))
  (gate-nand w2 w3 data)
  (gate-nand out w1 (wire-nand out w3)))







