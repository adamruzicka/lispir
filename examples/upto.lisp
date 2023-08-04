(define upto
    (lambda (current target)
      (print current)
      (if (eq current target)
          target
          (upto (+ 1 current) target))))

(upto 0 5)
