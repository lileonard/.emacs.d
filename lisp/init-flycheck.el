
(require 'flycheck)
;; flycheck common settings
(defun my-flycheck-setup ()
  (flymake-mode 0)
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
  (setq flycheck-gcc-language-standard "c++11")
  (setq flycheck-gcc-include-path my-sys-c-include)
  (setq flycheck-gcc-openmp t)
  (my-flycheck-setup))
(add-hook 'c-mode-hook   'my-flycheck-c-setup)
(add-hook 'c++-mode-hook 'my-flycheck-c-setup)
;; ######## elisp
(defun my-flycheck-elisp-setup ()
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (setq-default flycheck-emacs-lisp-load-path 'inherit)
  (my-flycheck-setup))
(add-hook 'emacs-lisp-mode-hook 'my-flycheck-elisp-setup)

;; python
(defun my-flycheck-python-setup ()
  (setq elpy-modules(delq 'elpy-module-flymake elpy-modules))
  (my-flycheck-setup)
  )
(add-hook 'elpy-mode-hook 'flycheck-mode)


(provide 'init-flycheck)
