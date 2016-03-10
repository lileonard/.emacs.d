(require 'sr-speedbar)
(setq dframe-update-speed t)
(setq speedbar-frame-parameters
      '((minibuffer)
        (width . 36)
        (border-width . 0)
        (menu-bar-lines . 0)
        (tool-bar-lines . 0)
        (unsplittable . t)
        (right-fringe . 0)))
(setq sr-speedbar-auto-refresh nil)
(setq sr-speedbar-left-side nil)
(setq sr-speedbar-skip-other-window-p t)

(make-face 'speedbar-face)
(set-face-font 'speedbar-face "Monospace-13")
(setq speedbar-mode-hook '(lambda () (buffer-face-set 'speedbar-face)))

;; ;; regular speedbar configq
(setq speedbar-show-unknown-files t)
(setq speedbar-verbosity-level 1)
(setq speedbar-use-images nil)

(global-set-key (kbd "<f5>")       'sr-speedbar-toggle)
(global-set-key (kbd "<s-f5>")     'sr-speedbar-refresh-toggle)

(define-key speedbar-mode-map (kbd "s")
  #'(lambda ()
      (interactive)
      (beginning-of-buffer)
      (isearch-forward)))
(define-key speedbar-mode-map (kbd "u")
  #'(lambda ()
      (interactive)
      (speedbar-up-directory)))

(provide 'init-sr-speedbar)
