
(defun my-flycheck-setup ()
  (require 'flycheck)
  (flycheck-mode 1)
  (setq flycheck-gcc-language-standard "c++11")
  (setq flycheck-pos-tip t)
  (setq flycheck-gcc-include-path 'my-sys-c-include)
  (setq flycheck-gcc-openmp t))

(add-hook 'c-mode-hook 'my-flycheck-setup)
(add-hook 'c++-mode-hook 'my-flycheck-setup)

(provide 'init-flycheck)
