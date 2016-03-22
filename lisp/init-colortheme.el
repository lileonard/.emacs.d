;; my deep blue theme
;; (add-to-list 'custom-theme-load-path
;;              (file-name-as-directory "/home/lyh/.emacs.d/site-lisp/lisp-face/color-theme/"))
;; (load-theme 'lyh-deep-blue t t)
;;  (enable-theme 'lyh-deep-blue)

;;moe theme
(require 'moe-theme)
(require 'moe-theme-switcher)
(setq moe-light-pure-white-background-in-terminal t)
(setq calendar-latitude +36.36)
(setq calendar-longitude +120.20)
(setq moe-theme-resize-org-title '(2.2 1.8 1.6 1.4 1.2 1.0 1.0 1.0 1.0))
(setq moe-theme-mode-line-color 'orange)
(set-face-attribute
 'font-lock-comment-face nil
 :foreground "#777777"
 )
(set-face-attribute
 'font-lock-preprocessor-face nil
 :foreground "purple"
 )
(set-face-attribute
 'font-lock-string-face nil
 :foreground "blue"
 )

;; font-lock-comment-face
;; font-lock-preprocessor-face
;; font-lock-string-face

(provide 'init-colortheme)
