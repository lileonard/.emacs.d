;; initiall the key board
;; CentOS see Win Key as super and pass-modifier as M-x

;; on apple key board
;;(setq mac-option-modifier 'hyper) ; sets the Option key as Hyper
(setq mac-option-modifier 'super) ; sets the Option key as Super
(setq mac-command-modifier 'meta) ; sets the Command key as Meta
;;(setq mac-control-modifier 'meta) ; sets the Control key as Meta


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (global-set-key (kbd "<C-c m>") 'execute-extended-command)
;; (global-set-key [(control a)] 'mark-whole-buffer)
;; (global-set-key [(meta f7)] 'compare-windows)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "<f3>") 'goto-line)

;;increacs and decrease text 
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)

(global-set-key (kbd "<S-f3>") 'upcase-region)
(global-set-key (kbd "<s-f3>") 'downcase-region)

(global-set-key (kbd "<C-SPC>") nil)

(global-set-key (kbd "<C-f6>")  'auto-insert)

(global-set-key (kbd "<C-f6>")  'auto-insert)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(define-key global-map (kbd "s-f") 'grep-find)
;; my mouse
;; "<drag-mouse-8>"
;; <drag-mouse-8>

(provide 'my-keybinding)
