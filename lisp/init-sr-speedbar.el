(require 'sr-speedbar)
(setq dframe-update-speed t)

(setq speedbar-hide-button-brackets-flag nil
      speedbar-show-unknown-files t
      speedbar-smart-directory-expand-flag t
      speedbar-directory-button-trim-method 'trim
      speedbar-use-images nil
      speedbar-indentation-width 2
      speedbar-use-imenu-flag t
      sr-speedbar-width 30
      sr-speedbar-width-x 30
      sr-speedbar-auto-refresh nil
      sr-speedbar-skip-other-window-p t
      sr-speedbar-right-side t
      speedbar-verbosity-level 1)

(make-face 'speedbar-face)
(set-face-font 'speedbar-face "Monospace-13")
(setq speedbar-mode-hook '(lambda () (buffer-face-set 'speedbar-face)))

;;(global-set-key (kbd "<f5>")       'sr-speedbar-toggle)
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (sr-speedbar-toggle)
                               (with-current-buffer sr-speedbar-buffer-name
                                 (setq window-size-fixed 'width))))
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
