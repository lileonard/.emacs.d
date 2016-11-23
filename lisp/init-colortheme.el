;; my deep blue theme
;; (add-to-list 'custom-theme-load-path
;;              (file-name-as-directory
;;               "/home/lyh/.emacs.d/site-lisp/lisp-face/color-theme/moe-theme"))
;; (add-to-list 'custom-theme-load-path
;;              (file-name-as-directory
;;               "/home/lyh/.emacs.d/site-lisp/lisp-face/color-theme"))
;; (load-theme 'lyh-deep-blue t t)
;;  (enable-theme 'lyh-deep-blue)
;; (load-theme 'moe-light t t)
;; (enable-theme 'moe-light)
;; moe theme
(require 'moe-theme)
;; (require 'moe-theme-switcher)
;; original moe-switcher costs 0.5s to start up which seems unnecessray to me
;; so 2 core functions copied to zhe init-file
(defun moe-load-theme (switch-to)
  "Avoid unnecessary load-theme and screen flashing in GUI version Emacs"
  (cond ((equal switch-to 'light)
           (progn (moe-light)))
        ((equal switch-to 'dark)
           (progn (moe-dark)))))
(defun switch-at-fixed-time ()
  (let ((now (string-to-number (format-time-string "%H"))))
    (if (and (>= now 9) (<= now 18))
        (moe-load-theme 'light)
      (moe-load-theme 'dark))
    nil))
(switch-at-fixed-time)

(setq moe-light-pure-white-background-in-terminal t)
(setq moe-theme-resize-org-title '(2.2 1.8 1.6 1.4 1.2 1.0 1.0 1.0 1.0))
(setq moe-theme-mode-line-color 'orange)
(cond ((eq (frame-parameter nil 'background-mode) 'light)
       (set-face-attribute
        'font-lock-comment-face nil
        :foreground "#707070")
       (set-face-attribute
        'font-lock-preprocessor-face nil
        :foreground "#27408B")
       (set-face-attribute
        'font-lock-string-face nil
        :foreground "#556B2F")
       (set-face-attribute
        'font-lock-variable-name-face nil
        :foreground "#9933AA")
       (set-face-attribute
        'font-lock-function-name-face nil
        :bold t
        :foreground "#D2691E")
       (set-face-attribute
        'font-lock-keyword-face nil
        :bold t
        :foreground "#008B8B")
       (set-foreground-color "#232323")
       
       )
      ((eq (frame-parameter nil 'background-mode) 'dark)
       (set-face-attribute
        'font-lock-comment-face nil
        :foreground "#548B54")
       (set-face-attribute
        'font-lock-preprocessor-face nil
        :foreground "#DAA520")
       (set-face-attribute
        'font-lock-string-face nil
        :foreground "light blue")
       (set-face-attribute
        'font-lock-keyword-face nil
        :bold t
        :foreground "DeepSkyBlue1")
       (set-foreground-color "#E0E0E0")
       (set-background-color "#073642")))
(provide 'init-colortheme)
