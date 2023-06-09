#lang racket

(define seq '(5 1 3 6 4))

(define tr '(#f . ((5 6) (1 3 4))))

(define (height t)
  (displayln t)
  (cond
    [(not (pair? t)) 1]
    [else (+ 1 (apply max (map height (cdr t))))]))

(define (add-to-tree t v)
  (if (not (pair? t))
      ;; at a leaf
      
      )
  )
