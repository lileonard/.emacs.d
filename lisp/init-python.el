

(eval-after-load 'python
  '(progn
     (require 'elpy)
     (defconst python3-path "~/Soft/anaconda3/bin/python3")
     (setq elpy-rpc-python-command python3-path
           pyvenv-virtualenvwrapper-python python3-path
           python-shell-interpreter python3-path)
     (elpy-enable)
     (require 'anaconda-mode)
     (add-hook 'python-mode-hook 'anaconda-mode)
     (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
     (setq python-shell-interpreter python3-path)
     ))

(provide 'init-python)
