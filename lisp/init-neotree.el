(require 'neotree)
(setq neo-window-fixed-size nil
      neo-autorefresh t
      neo-smart-open t
      neo-show-hidden-files nil
      neo-window-width 33)
(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (projectile-project-root))
        (file-name (buffer-file-name)))
    (neotree-toggle)
    (if project-dir
        (if (neo-global--window-exists-p)
            (progn
              (neotree-dir project-dir)
              (neotree-find file-name)))
      (message "Could not find git project root."))))
(global-set-key [f5] 'neotree-project-dir)

;;(setq neo-window-width 50)


;;(global-set-key [f5] 'neotree-toggle)

(provide 'init-neotree)
