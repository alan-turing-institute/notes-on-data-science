#lang racket

(define (f x)
  (- (- (* x (log x)))
     (* (- 1.0 x) (log (- 1.0 x)))
     x))

(define (narrow-range f rng)
  (match-let ([(cons a b) rng])
    (let ([guess (/ (+ a b) 2.0)])
      (if (> (f guess) 0)
          (cons guess b)
          (cons a guess)))))

(define (narrow-enough? ϵ rng)
  (< (abs (- (cdr rng) (car rng))) ϵ))

(define (find-root ϵ a b f)
  (define (find-root-helper rng)
    (if (narrow-enough? ϵ rng)
        rng
        (find-root-helper (narrow-range f rng))))
    
  (find-root-helper (cons a b)))


(find-root 0.001 0.5 0.99 f)
