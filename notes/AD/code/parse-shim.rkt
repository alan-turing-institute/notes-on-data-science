#lang racket/base

(require racket/port
         racket/treelist)

(provide parse)

(define (parse s)
  (list->treelist (call-with-input-string s read)))
