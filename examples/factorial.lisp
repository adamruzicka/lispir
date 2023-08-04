(define sub (lambda (x) (+ x -1)))

(define mul
    (lambda (x y)
      (begin
       (define inner-mul
           (lambda (current step n)
             (if (eq n 1)
                 current
                 (inner-mul (+ current step) step (sub n)))))
       (inner-mul x x y))))

(define factorial
    (lambda (x)
      (if (eq x 0)
          1
          (mul x (factorial (sub x))))))

(print (factorial 5))
