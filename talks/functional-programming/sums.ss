(define (sum xs)
  (cond
    [(null? xs) 0]
    [else        (+ (car xs)
                    (sum (cdr xs)))]))

(sum '(1 3 2 8))
