#lang racket

(define (gcd a b)
  (if (= a b)
      a
      (if (> a b)
          (gcd (- a b) b)
          (gcd a (- b a)))))

(gcd 32 24)

