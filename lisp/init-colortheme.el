;; my deep blue theme
(add-to-list 'custom-theme-load-path
             (file-name-as-directory
              "/home/lyh/.emacs.d/site-lisp/lisp-face/color-theme/moe-theme"))
;; (add-to-list 'custom-theme-load-path
;;              (file-name-as-directory
;;               "/home/lyh/.emacs.d/site-lisp/lisp-face/color-theme"))
;; (load-theme 'lyh-deep-blue t t)
;;  (enable-theme 'lyh-deep-blue)
;; (load-theme 'moe-light t t)
;; (enable-theme 'moe-light)
;;moe theme
(require 'moe-theme)
(require 'moe-theme-switcher)
(setq moe-light-pure-white-background-in-terminal t)
(setq calendar-latitude +36.36)
(setq calendar-longitude +120.20)
(setq moe-theme-resize-org-title '(2.2 1.8 1.6 1.4 1.2 1.0 1.0 1.0 1.0))
(setq moe-theme-mode-line-color 'orange)
(cond ((eq (frame-parameter nil 'background-mode) 'light)
       (set-face-attribute
        'font-lock-comment-face nil
        :foreground "#606060")
       (set-face-attribute
        'font-lock-preprocessor-face nil
        :foreground "#27408B")
       (set-face-attribute
        'font-lock-string-face nil
        :foreground "#556B2F")
       (set-foreground-color "#363636"))
      ((eq (frame-parameter nil 'background-mode) 'dark)
       (set-face-attribute
        'font-lock-comment-face nil
        :foreground "#B2B2B2")
       (set-face-attribute
        'font-lock-preprocessor-face nil
        :foreground "#DAA520")
       (set-face-attribute
        'font-lock-string-face nil
        :foreground "light blue")
       (set-foreground-color "#E0E0E0")))


(provide 'init-colortheme)
