#lang racket

(require pict
         pict/color
         pict/tree-layout
         file/convertible
         (only-in racket/draw the-color-database)
         plot)


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

;; -> tree-layout?

(define (expr e)
  (cond
    [(pair? e)   (app e)]
    [(symbol? e) (var e)]
    [else        (lit e)]))


(with-output-to-file "tree.pdf"
  (thunk
   (write-bytes
    (convert 
     (naive-layered 
      (expr '(exp (neg (div (pow x 2) 2))))
      #:x-spacing 5)
     'pdf-bytes))
   )
  #:exists 'replace)


(define (gaussian x)
  (exp (- (/ (expt x 2) 2))))

(plot-file (function gaussian -3 3 #:y-min 0 #:label "y = gaussian(x)")
           "gaussian-plot.pdf")
