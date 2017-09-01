(require 'neotree)
(setq neo-smart-open t)
(setq neo-show-hidden-files nil)
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

;;(global-set-key [f5] 'neotree-toggle)

(provide 'init-neotree)
