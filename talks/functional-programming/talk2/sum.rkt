#lang racket

(define (sum-up-to N)
  (if (= N 0)
      0
      (+ N (sum-up-to (- N 1)))))


