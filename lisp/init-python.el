

(eval-after-load 'python
  '(progn
     (require 'elpy)
     (setq elpy-rpc-python-command "/mnt/Soft/LinuxSoft/anaconda3/bin/python3"
           pyvenv-virtualenvwrapper-python "/mnt/Soft/LinuxSoft/anaconda3/bin/python3"
           python-shell-interpreter "/mnt/Soft/LinuxSoft/anaconda3/bin/python3")
     (elpy-enable)
     (require 'anaconda-mode)
     (add-hook 'python-mode-hook 'anaconda-mode)
     (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
     (setq python-shell-interpreter "/mnt/Soft/LinuxSoft/anaconda3/bin/python3")
     ))

(provide 'init-python)
