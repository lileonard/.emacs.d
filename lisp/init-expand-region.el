(setq alphabet-start "abc def")
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region) 
(provide 'init-expand-region)
