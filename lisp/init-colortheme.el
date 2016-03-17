;; my deep blue theme
(add-to-list 'custom-theme-load-path
             (file-name-as-directory "~/.emacs.d/site-lisp/lisp-face/"))
(load-theme 'lyh-deep-blue t t)
(enable-theme 'lyh-deep-blue)

;; spacemace theme ready for use
(require 'spacemacs-common)

(provide 'init-colortheme)
