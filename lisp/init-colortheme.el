;; my deep blue theme
;; (add-to-list 'custom-theme-load-path
;;              (file-name-as-directory "~/.emacs.d/site-lisp/lisp-face/"))
;; (add-to-list 'custom-theme-load-path
;;              (file-name-as-directory "~/.emacs.d/site-lisp/lisp-face/moe-theme"))
;; (load-theme 'moe-light t t)
;; (load-theme 'lyh-deep-blue t t)
;; (enable-theme 'lyh-deep-blue)
(require 'moe-theme)
(require 'moe-theme-switcher)
(setq moe-theme-resize-org-title '(2.2 1.8 1.6 1.4 1.2 1.0 1.0 1.0 1.0))
(provide 'init-colortheme)
