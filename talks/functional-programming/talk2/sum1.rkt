#lang racket

(define (sum-up-to N acc)
  (if (= N 0)
      acc
      (sum-up-to (- N 1) (+ N acc))))
