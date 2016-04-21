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

;;####=更改GDB多窗口布局=#################################################################################
(defadvice gdb-setup-windows (after setup-gdb-windows activate)
  ;;  (gdb-get-buffer-create 'gdb-locals-buffer)
  (gdb-get-buffer-create 'gdb-stack-buffer)
  ;;  (gdb-get-buffer-create 'gdb-breakpoints-buffer)
  (set-window-dedicated-p (selected-window) nil)
  (switch-to-buffer gud-comint-buffer)
  (delete-other-windows)
  (let ((win0 (selected-window))
        (win1 (split-window nil nil 'left))
        (win2 (split-window nil ( / ( * (window-height) 3) 4)))
        (win3 (split-window nil ( / ( * (window-height) 1) 2))))
    (select-window win2)
    (gdb-set-window-buffer (gdb-stack-buffer-name))
    (select-window win3)
    (gdb-set-window-buffer (gdb-get-buffer-create 'gdb-inferior-io))
    ;; (let ((win4 (split-window-right)))
    ;;   (gdb-set-window-buffer (gdb-locals-buffer-name) nil win4))
    (select-window win1)
    (set-window-buffer
     win1
     (if gud-last-last-frame
         (gud-find-file (car gud-last-last-frame))
       (if gdb-main-file
           (gud-find-file gdb-main-file)
         (list-buffers-noselect))
       )
     )
    (setq gdb-source-window (selected-window))
    ;; (let ((win5 (split-window nil ( / (* (window-height) 3) 4))))
    ;; (gdb-set-window-buffer (gdb-stack-buffer-name) nil win5))
    (select-window win0)))

(global-set-key (kbd "<f10>")    'gdb)
(global-set-key (kbd "<C-f10>")  'gud-run)
(global-set-key (kbd "<M-f10>")  'gud-next)
(global-set-key (kbd "<s-f10>")  'gud-step)
(provide 'init-gud)
