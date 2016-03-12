;;debug settings


(setq gdb-many-windows t
      gdb-show-main t
      gud-chdir-before-run nil
      gud-tooltip-mode t)

(defvar gud-overlay
  (let* ((ov (make-overlay (point-min) (point-min))))
    (overlay-put ov 'face 'secondary-selection)
    ov)
  "Overlay variable for GUD highlighting.")


(defun gud-kill-buffer ()
  (if (derived-mode-p 'gud-mode)
      (delete-overlay gud-overlay)))
(add-hook 'kill-buffer-hook 'gud-kill-buffer)

;; {{ hack buffer
;; move the cursor to the end of last line if it's gud-mode
(defun hack-gud-mode ()
  (when (string= major-mode "gud-mode")
    (goto-char (point-max))))

(defadvice switch-to-buffer
    (after switch-to-buffer-after activate)
  (hack-gud-mode))

(defadvice select-window-by-number
    (after select-window-by-number-after activate)
  (hack-gud-mode))

;; windmove-do-window-select is from windmove.el
(defadvice windmove-do-window-select
    (after windmove-do-window-select-after activate)
  (hack-gud-mode))
;; }}

(defun gud-cls (&optional num)
  "clear gud screen"
  (interactive "p")
  (let ((old-window (selected-window)))
    (save-excursion
      (cond
       ((buffer-live-p (get-buffer "*gud-main*"))
        (select-window (get-buffer-window "*gud-main*"))
        (end-of-buffer)
        (recenter-top-bottom)
        (if (> num 1) (recenter-top-bottom))
        (select-window old-window))
       (t (error "GUD buffer doesn't exist!"))
       ))))

(eval-after-load 'gud
  '(progn
     (gud-def gud-kill "kill" "\C-k" "Kill the debugee")))

(defun gud-kill-yes ()
  "gud-kill and confirm with y"
  (interactive)
  (let ((old-window (selected-window)))
    (save-excursion
      (cond
       ((buffer-live-p (get-buffer "*gud-main*"))
        (gud-kill nil)
        (select-window (get-buffer-window "*gud-main*"))
        (insert "y")
        (comint-send-input)
        (recenter-top-bottom)
        (select-window old-window))
       (t (error "GUD buffer doesn't exist!"))))))

(global-set-key (kbd "<f10>")    'gdb)
(global-set-key (kbd "<C-f10>")  'gud-run)
(global-set-key (kbd "<M-f10>")  'gud-next)
(global-set-key (kbd "<s-f10>")  'gud-step)
(provide 'init-gud)
