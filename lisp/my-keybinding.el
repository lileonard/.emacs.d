;; some key settings
;; many hotkeys are in init-files
;; CentOS see Win Key as super and pass-modifier as M-x
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "<f3>") 'goto-line)

;;increacs and decrease text
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)
(global-set-key (kbd "<S-f3>") 'upcase-region)
(global-set-key (kbd "<s-f3>") 'downcase-region)
(global-set-key (kbd "<C-SPC>") nil)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "s-f") 'grep-find)

(provide 'my-keybinding)
