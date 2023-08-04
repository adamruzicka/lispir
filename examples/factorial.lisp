(define (sub x) (+ x -1))

(define (mul x y)
  (define (inner-mul current n)
    (if (eq n 1)
        current
        (inner-mul (+ current x) (sub n))))
  (inner-mul x y))

(define (factorial x)
  (if (eq x 0)
      1
      (mul x (factorial (sub x)))))

(print (factorial 5))
