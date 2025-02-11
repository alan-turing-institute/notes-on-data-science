#lang racket

(require pict
         pict/color
         pict/tree-layout
         file/convertible
         (only-in racket/draw the-color-database)
         plot)

(require "eval.rhm")

(define col-for-app (send the-color-database find-color "dark gray"))
(define col-for-lit (send the-color-database find-color "blue"))
(define col-for-proc (send the-color-database find-color "black"))
(define col-for-var (send the-color-database find-color "red"))


(define (text-node-pict txt col)
  (cc-superimpose
   (disk 30 #:draw-border? #t #:color "white" #:border-color "gray")
   (text txt (cons col 'modern))))

;; -> tree-layout?
(define (lit val)
  (tree-layout #:pict (text-node-pict (format "~a" val) col-for-lit)))

(define (var val)
  (tree-layout #:pict (text-node-pict (symbol->string val) col-for-var)))

#|
(define (app xs)
  (apply tree-layout
         (tree-edge (tree-layout #:pict (text-node-pict (format "~a" (car xs)) col-for-proc))
                    #:edge-color "gray")
         (map (λ (e) (tree-edge (expr e) #:edge-color "gray")) (cdr xs))
         #:pict (text-node-pict "App" col-for-app)))
|#

(define (app xs)
  (apply tree-layout
         (map (λ (e) (tree-edge (expr e) #:edge-color "gray")) (cdr xs))
         #:pict (text-node-pict (format "~a" (car xs)) col-for-proc)))


;; -> tree-layout?
(define (expr e)
  (cond
    [(pair? e)   (app e)]
    [(string? e) (var (string->symbol e))]
    [(symbol? e) (var e)]
    [else        (lit e)]))


(with-output-to-file "gaussian-tree.pdf"
  (thunk
   (write-bytes
    (convert 
     (naive-layered 
      (expr gaussian_expr)
      #:x-spacing 5)
    'pdf-bytes)))
   #:exists 'replace)

(with-output-to-file "dgaussian-tree.pdf"
  (thunk
   (write-bytes
    (convert 
     (naive-layered 
      (expr dgaussian_expr)
      #:x-spacing 5)
    'pdf-bytes)))
   #:exists 'replace)

(naive-layered 
      (expr dgaussian_expr)
      #:x-spacing 5)

(plot-file (list (axes)
                 (function dg -3 3
                           #:y-min -1 #:y-max 1
                           #:label "y = d gaussian / dx"))
                 "dgaussian-plot.pdf")

(plot-file (list (axes)
                 (function dg -3 3 #:y-min -1 #:y-max 1 #:label "y = d gaussian / dx"))
           "dgaussian-plot.pdf")


