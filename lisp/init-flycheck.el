(require 'flycheck)
;; flycheck common settings
(defun my-flycheck-setup ()
  (flycheck-mode 1)
  (autoload 'helm-flycheck "helm-flycheck" "show flycheck in helm-mode" t)
  (require 'flycheck-tip)
  (flycheck-tip-use-timer 'verbose)
  ;; only auto-check when save
  (setq flycheck-check-syntax-automatically '(mode-enabled save))
  ;; when mouse on the error show error information
  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)
  (setq flycheck-display-error-at-point-timer nil))

;; c/c++
(defun my-flycheck-c-setup ()
  (my-flycheck-setup)
  (setq flycheck-gcc-language-standard "c++11")
  (setq flycheck-gcc-include-path my-sys-c-include)
  (setq flycheck-gcc-openmp t))
(add-hook 'c-mode-hook   'my-flycheck-c-setup)
(add-hook 'c++-mode-hook 'my-flycheck-c-setup)
;; ######## elisp
(defun my-flycheck-elisp-setup ()
  (my-flycheck-setup)
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (setq-default flycheck-emacs-lisp-load-path 'inherit))
(add-hook 'emacs-lisp-mode-hook 'my-flycheck-elisp-setup)

(provide 'init-flycheck)
