#lang racket

(define (sum-naturals n acc)
  (if (zero? n)
      acc
      (sum-naturals (- n 1) (+ acc n))))


