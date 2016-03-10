(require 'powerline)
;; (powerline-default-theme)
;; (powerline-center-theme)
;; (powerline-center-evil-theme)
;; (powerline-vim-theme)
;; (powerline-nano-theme)



(defun powerline-center-theme-lyh ()
  "Setup a mode-line with major and minor modes centered."
  (interactive)
  (setq-default
   mode-line-format
   '("%e"
     (:eval
      (let*
          ((active (powerline-selected-window-active))
           (mode-line (if active 'mode-line 'mode-line-inactive))
           (face1 (if active 'powerline-active1 'powerline-inactive1))
           (face2 (if active 'powerline-active2 'powerline-inactive2))
           (separator-left (intern (format "powerline-%s-%s"
                                           (powerline-current-separator)
                                           (car powerline-default-separator-dir))))
           (separator-right (intern (format "powerline-%s-%s"
                                            (powerline-current-separator)
                                            (cdr powerline-default-separator-dir))))
           (lhs (list
                 ;; (powerline-buffer-id nil 'l)
                 (funcall separator-left mode-line face1)
                 (powerline-narrow face1 'l)
                 (powerline-vc face1)))
           (rhs (list
                 (powerline-raw global-mode-string face1 'r)
                 ;; (powerline-raw "%4l" face1 'r) ;;显示号
                 ;; (powerline-raw ":" face1)
                 (powerline-raw "%3c" face1 'r)
                 (funcall separator-right face1 mode-line)
                 (powerline-raw "%6p" nil 'r)
                 ;; (powerline-hud face2 face1)
                 ))
           (center (list
                    (powerline-raw " " face1)
                    (funcall separator-left face1 face2)
                    (when (and (boundp 'erc-track-minor-mode) erc-track-minor-mode)
                      (powerline-raw erc-modified-channels-object face2 'l))
                    (powerline-major-mode face2 'l)
                    (powerline-process face2)
                    (powerline-raw ":" face2)
                    (powerline-minor-modes face2 'l)
                    (funcall separator-right face2 face1))))
        (concat (powerline-render lhs)
                (powerline-fill-center face1 (/ (powerline-width center) 2.0))
                (powerline-render center)
                (powerline-fill face1 (powerline-width rhs))
                (powerline-render rhs))))))
  (set-face-attribute 'powerline-active1 nil
                      :foreground "black"
                      :background "#555555")
  (set-face-attribute 'powerline-active2 nil
                      :foreground "black"
                      :background "#888888")
  (set-face-attribute 'powerline-inactive1 nil
                      :foreground "black"
                      :background "#222222")
  (set-face-attribute 'powerline-inactive2 nil
                      :foreground "black"
                      :background "#333333"))

(powerline-center-theme-lyh)

(provide 'init-powerline)
