#lang racket

(require plot)

;; Imports g, dg, gaussian_expr and dgaussian_expr
(require "eval.rhm") 


(plot-file
 (list (axes)
       (function g -3 3
                 #:y-min 0
                 #:label "y = g(x)"))
 "../images/gaussian-plot.pdf")

(plot-file
 (list (axes)
       (function dg -3 3
                 #:y-min -1 #:y-max 1
                 #:label "y = dg(x)")
       (function ddg -3 3
                 #:y-min -1 #:y-max 1
                 #:style 'long-dash
                 #:color 'blue
                 #:label "y = ddg(x)"))
 "../images/dgaussian-plot.pdf")


