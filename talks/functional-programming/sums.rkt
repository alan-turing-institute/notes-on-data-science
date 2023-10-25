#lang racket

(define (sum xs)
  (if (null? xs)
      0
      (+ (car xs)
         (sum (cdr xs)))))

(sum '(1 3 2 8))

(apply + '(1 3 2 8))

(define (sum xs)
  (apply + xs))
