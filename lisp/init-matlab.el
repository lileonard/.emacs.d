;;; init-matlab.el --- matlab mode
(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
(autoload 'matlab-shell "matlab" "Interactive Matlab mode." t)
(autoload 'matlab-mode "semantic-matlab" "interactive semantic for matlab." t)
;; Customieze
(setq matlab-indent-function t)
;; if you want function bodies indented
(setq matlab-verify-on-save-flag nil)
;; turn off auto-verify on save

(add-hook 'matlab-mode-hook
          '(lambda () 
             (define-key matlab-mode-map (kbd "C-c C-e")
               'matlab-insert-end-block)))


(provide 'init-matlab)
