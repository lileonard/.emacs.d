(require 'helm)
(require 'helm-flx)
(helm-flx-mode 1)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t)

(require 'helm-projectile)  
(helm-projectile-on)

(require 'helm-gtags)
(add-hook 'c-mode-common-hook  'helm-gtags-mode)
(add-hook 'python-mode-hook    'helm-gtags-mode)
;; key bindings

(custom-set-variables
 '(helm-gtags-path-style 'relative)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-auto-update t))


(provide 'init-helm)
