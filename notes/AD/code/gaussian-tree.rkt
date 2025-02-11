#lang racket

(require pict
         pict/tree-layout
         file/convertible)

(require "eval.rhm") ; g, dg, gaussian_expr, and dgaussian_expr

(require "expression-tree.rkt") ; expr->tree

(with-output-to-file "../images/gaussian-tree.pdf"
  (thunk
   (write-bytes
    (convert 
     (naive-layered 
      (expr->tree gaussian_expr)
      #:x-spacing 5)
    'pdf-bytes)))
   #:exists 'replace)

(with-output-to-file "../images/dgaussian-tree.pdf"
  (thunk
   (write-bytes
    (convert 
     (naive-layered 
      (expr->tree dgaussian_expr)
      #:x-spacing 5)
    'pdf-bytes)))
   #:exists 'replace)



