#lang racket

(require pict)
(require pict/color)
(require pict/tree-layout)

(define (text-node-pict txt col)
  (cc-superimpose
   (circle 30)
   (col (text txt))))

;; -> tree-layout?
(define (lit val)
  (tree-layout #:pict (text-node-pict (format "~a" val) blue)))

(define (app xs)
  (apply tree-layout
         (tree-layout #:pict (text-node-pict (format "~a" (car xs)) blue))
         (map expr (cdr xs))
         #:pict (text-node-pict "App" black)))

;; -> tree-layout?
(define (expr e)
  (cond
    [(pair? e) (app e)]
    [else      (lit e)]))

(naive-layered 
 (expr '(exp (- (/ (expt x 2) 2))))
 #:x-spacing 5)

