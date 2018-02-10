 
(require 'highlight-indentation)
(add-hook 'c++-mode-hook           #'highlight-indentation-mode)
(add-hook 'c-mode-hook             #'highlight-indentation-mode)
(add-hook 'lisp-mode-hook          #'highlight-indentation-mode)
(add-hook 'emacs-lisp-mode-hook    #'highlight-indentation-mode)
(add-hook 'python-mode-hook        #'highlight-indentation-mode)
(add-hook 'matlab-mode-hook        #'highlight-indentation-mode)
(add-hook 'c++-mode-hook           #'highlight-indentation-current-column-mode)
(add-hook 'c-mode-hook             #'highlight-indentation-current-column-mode)
(add-hook 'lisp-mode-hook          #'highlight-indentation-current-column-mode)
(add-hook 'emacs-lisp-mode-hook    #'highlight-indentation-current-column-mode)
(add-hook 'python-mode-hook        #'highlight-indentation-current-column-mode)
(add-hook 'matlab-mode-hook        #'highlight-indentation-current-column-mode)

(defun adjust-highlight-indentation-mode-face()
  "interactive"
  (let* ((color  (x-color-values (face-attribute 'default :background))))
    (if (null color)
        (error "not support.")
      (let ((my-color (mapcar
                       (lambda (x)
                         (let ((y (/ #XFFFF 4))
                               ;; delta is the color adjust parament
                               (delta #X0999))
                           (cond ((< x (* y 1))
                                  (+ x delta))
                                 ((< x (* y 2))
                                  (+ x delta))
                                 ((< x (* y 3))
                                  (- x delta))
                                 (t
                                  (- x delta))))) color)))
        (set-face-attribute
         'highlight-indentation-face nil
         :background
         (concat "#"
                 (mapconcat
                  (lambda (c) (format "%04X" c))
                  my-color
                  ""))))
      (let ((my-color2 (mapcar
                        (lambda (x)
                          (let ((y (/ #XFFFF 4))
                                ;; delta is the color adjust parament
                                (delta #X2789))
                            (cond ((< x (* y 1))
                                   (+ x delta))
                                  ((< x (* y 2))
                                   (+ x delta))
                                  ((< x (* y 3))
                                   (- x delta))
                                  (t
                                   (- x delta))))) color)))
        (set-face-attribute
         'highlight-indentation-current-column-face nil
         :background
         (concat "#"
                 (mapconcat
                  (lambda (c) (format "%04X" c))
                  my-color2
                  "")))))))
(adjust-highlight-indentation-mode-face)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; end provide
(provide 'init-highlight-indentation)
