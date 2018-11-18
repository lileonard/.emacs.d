(setq interpreter-mode-alist
      (cons '("python" . python-mode) interpreter-mode-alist))

(eval-after-load 'python
  '(progn
     (require 'elpy)
     (setq python-shell-completion-native-enable nil)
     (setq elpy-rpc-python-command "python3")
     (setq python-shell-interpreter "python3")
     (elpy-enable)
(setq electric-indent-chars (delq ?: electric-indent-chars))))

(provide 'init-python)
