#lang racket

(require pict
         pict/tree-layout
         file/convertible)

(require "expression-tree.rkt") ; expr->tree

(with-output-to-file "../images/fgh-tree.pdf"
  (thunk
   (write-bytes
    (convert 
     (naive-layered 
      (expr->tree
       '("f" ("g" ("h" x))))
      #:x-spacing 5)
    'pdf-bytes)))
   #:exists 'replace)


(with-output-to-file "../images/dfgh-tree.pdf"
  (thunk
   (write-bytes
    (convert 
     (naive-layered 
      (expr->tree
       '("*" ("f'" ("g" ("h" x)))
             ("*" ("g'" ("h" x))
                  ("*" ("h'" x)
                       1))))
      #:x-spacing 5)
     'pdf-bytes)))
  #:exists 'replace)
