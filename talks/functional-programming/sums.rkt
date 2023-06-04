#lang racket

(define (sum xs)
  (if (null? xs)
      0
      (+ (car xs)
         (sum (cdr xs)))))

(sum '(1 3 2 8))
