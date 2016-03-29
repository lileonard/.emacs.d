(require 'flycheck)
(defun my-flycheck-setup ()
  ;; only auto-check when save
  (setq flycheck-check-syntax-automatically '(save))
  ;; when mouse on the error show error information
  (setq flycheck-pos-tip t))
(add-hook 'flycheck-mode-hook 'my-flycheck-setup)
;; c/c++
(defun my-flycheck-c-setup ()
  (flycheck-mode 1)
  (setq flycheck-gcc-language-standard "c++11")
  (setq flycheck-gcc-include-path 'my-sys-c-include)
  (setq flycheck-gcc-openmp t))
(add-hook 'c-mode-hook   'my-flycheck-c-setup)
(add-hook 'c++-mode-hook 'my-flycheck-c-setup)

;; ######## elisp
(defun my-flycheck-elisp-setup ()
  (flycheck-mode 1)
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (setq-default flycheck-emacs-lisp-load-path 'inherit))
(add-hook 'emacs-lisp-mode-hook 'my-flycheck-elisp-setup)

(provide 'init-flycheck)
