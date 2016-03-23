(autoload 'projectile-mode "projectile.el" nil t)
;; 默认全局使用
(add-hook 'c-mode-common-hook    'projectile-mode)
(add-hook 'emacs-lisp-mode-hook  'projectile-mode)
(add-hook 'python-mode-hook      'projectile-mode)
;;(projectile-global-mode)
;; 默认打开缓存
(setq projectile-enable-caching t)
(setq projectile-completion-system 'helm)
(setq projectile-indexing-method 'alien)
(setq projectile-switch-project-action 'helm-projectile-find-file)
(setq projectile-file-exists-remote-cache-expire (* 10 60))
(setq projectile-file-exists-local-cache-expire (* 5 60))
(add-to-list 'projectile-globally-ignored-directories "backup")

;; 仅仅在特定文件中搜索
(defun projectile-erlgrep ()
  "Perform rgrep in the project."
  (interactive)
  (let ((search-regexp
         (if (and transient-mark-mode mark-active)
             (buffer-substring (region-beginning) (region-end))
           (read-string (projectile-prepend-project-name "ErlGrep for: ")
                        (thing-at-point 'symbol))))
        (root-dir (expand-file-name (projectile-project-root))))
    (require 'grep)
    ;; paths for find-grep should relative and without trailing /
    (let ((grep-find-ignored-directories nil)
          (grep-find-ignored-files nil))
      (grep-compute-defaults)
      (rgrep search-regexp " *.cpp *.c *.cu *.python *.py *.h *.el" root-dir))))

(provide 'init-projectile)
