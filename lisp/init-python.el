(setq interpreter-mode-alist
      (cons '("python" . python-mode) interpreter-mode-alist))

(eval-after-load 'python
  '(progn
     (require 'elpy)
     (elpy-enable)
(setq electric-indent-chars (delq ?: electric-indent-chars))))

(provide 'init-python)
