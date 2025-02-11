#lang racket

(require pict
         pict/tree-layout
         file/convertible
         (only-in racket/draw the-color-database))

(provide (rename-out [expr expr->tree]))

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

(define (app xs)
  (apply tree-layout
         (tree-edge (tree-layout #:pict (text-node-pict (format "~a" (car xs)) col-for-proc))
                    #:edge-color "gray")
         (map (λ (e) (tree-edge (expr e) #:edge-color "gray")) (cdr xs))
         #:pict (text-node-pict "App" col-for-app)))

#|
;; Old version, which did not use App nodes
(define (app xs)
(apply tree-layout
(map (λ (e) (tree-edge (expr e) #:edge-color "gray")) (cdr xs))
#:pict (text-node-pict (format "~a" (car xs)) col-for-proc)))
|#

;; -> tree-layout?
(define (expr e)
  (cond
    [(pair? e)   (app e)]
    [(string? e) (var (string->symbol e))]
    [(symbol? e) (var e)]
    [else        (lit e)]))


