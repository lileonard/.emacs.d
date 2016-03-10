(autoload 'magit-status "magit" nil t )
(autoload 'magit-commit "magit" nil t )
(autoload 'magit-push   "magit" nil t )
(autoload 'magit-show   "magit" nil t )
(global-set-key (kbd "<f12>") 'magit-status)
(global-set-key (kbd "<C-f12>") 'magit-commit)
(global-set-key (kbd "<S-f12>") 'magit-push)
(global-set-key (kbd "<S-f12>") 'magit-show)

(setq magit-save-some-buffers nil
      magit-process-popup-time 10
      magit-completing-read-function 'magit-ido-completing-read)

;; Sometimes I want check other developer's commit
;; show file of specific version
;; show the commit

(eval-after-load 'magit
  '(progn
     ;; Don't let magit-status mess up window configurations
     ;; http://whattheemacsd.com/setup-magit.el-01.html
     (defadvice magit-status (around magit-fullscreen activate)
       (window-configuration-to-register :magit-fullscreen)
       ad-do-it
       (delete-other-windows))
     (defun magit-quit-session ()
       "Restores the previous window configuration and kills the magit buffer"
       (interactive)
       (kill-buffer)
       (jump-to-register :magit-fullscreen))

     (define-key magit-status-mode-map (kbd "q") 'magit-quit-session)))

;; {{ git-messenger
(require 'git-messenger)
;; show to details to play `git blame' game
(setq git-messenger:show-detail t)
(add-hook
 'git-messenger:after-popup-hook
 (lambda (msg)
   ;; extract commit id and put into the kill ring
   (when (string-match "\\(commit *: *\\)\\([0-9a-z]+\\)" msg)
     (kill-new (match-string 2 msg)))
   (kill-new msg)
   (with-temp-buffer
     (insert msg)
     (shell-command-on-region (point-min) (point-max)
                              (cond
                               ((eq system-type 'cygwin) "putclip")
                               ((eq system-type 'darwin) "pbcopy")
                               (t "xsel -ib")
                               )))
   (message "commit details > clipboard & kill-ring")))
;;Don’t really like the highlights on diff mode… Made it optional using:
(global-set-key (kbd "C-x v p") 'git-messenger:popup-message)
(defcustom magit-use-highlights nil
  "Use highlights in diff buffer."
  :group 'magit
  :type 'boolean)
;;And then changed magit-highlight-section as follows:
(defun magit-highlight-section ()
  (let ((section (magit-current-section)))
    -    (when (not (eq section magit-highlighted-section))
           +    (when (and (not (eq section magit-highlighted-section))
                           +                    magit-use-highlights)))))
(provide 'init-magit)
