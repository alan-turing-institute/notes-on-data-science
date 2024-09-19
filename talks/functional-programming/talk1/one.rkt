#lang lazy

(define (true a b) a)
(define (false a b) b)
(define (ifthen q a b) (q a b))

(define (z? n) (if (zero? n) true false))

(define (fact n)
  (ifthen (z? n) 1 (* n (fact (- n 1)))))

