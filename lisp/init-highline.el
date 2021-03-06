;; from a Chinese Emacser and I change a little to adjust it to modern color theme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'hl-line)
(global-hl-line-mode 1)

(defun adjust-hl-mode-face()
  "interactive"
  (let* ((color  (x-color-values (face-attribute 'default :background))))
    (if (null color)
        (error "not support.")
      (let ((my-color (mapcar
                       (lambda (x)
                         (let ((y (/ #XFFFF 4))
                                ;; delta is the color adjust parament
                               (delta #X0902))
                           (cond ((< x (* y 1))
                                  (+ x delta))
                                 ((< x (* y 2))
                                  (+ x delta))
                                 ((< x (* y 3))
                                  (- x delta))
                                 (t
                                  (- x delta))))) color)))
        (set-face-attribute
         'hl-line nil
         :background
         (concat "#"
                 (mapconcat
                  (lambda (c) (format "%04X" c))
                  my-color
                  "")))))))
(adjust-hl-mode-face)

(provide 'init-highline)
