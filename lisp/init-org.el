;; ;; ;; org-mode

(require 'org)  
(setq  org-completion-use-ido t
       org-edit-timestamp-down-means-later t
       org-archive-mark-done nil
       org-catch-invisible-edits 'show
       org-export-coding-system 'utf-8
       org-fast-tag-selection-single-key 'expert
       org-html-validation-link nil
       org-export-kill-product-buffer-when-displayed t
       org-tags-column 80)

;; 在一个任务完成后，写心得或者备注并加上时间戳
(setq org-todo-keywords
      '((sequence "TODO(t)" "DOING(i!)" "HANGUP(h!)" "|" "DONE(d!)" "CANCELLED(c!)")))
(setq org-log-done 'time)
;; org-mode colors
(setq org-todo-keyword-faces
      '(
        ("TODO"      . (:foreground "red"     :weight bold))
        ("DOING"     . (:foreground "green"   :weight bold))
        ("HANGUP"    . (:foreground "yellow"  :weight bold))
        ("DONE"      . (:foreground "orange"  :weight bold))
        ("CANCELLED" . (:foreground "gray"    :weight bold))))
;;Sort a column in an Org Table
;;Org-Mode provide org-table-sort-lines C-c ^ to sort all the table lines based on a column. 
;;But sometime one need to sort just one column :
(defun org-table-sort-column ()
  "Sort table column at point."
  (interactive)
  (let* ((thisline (org-current-line))
         (thiscol (org-table-current-column))
         (otc org-table-overlay-coordinates)
         beg end bcol ecol tend tbeg column lns pos)
    (when (equal thiscol 0)
      (if (org-called-interactively-p 'any)
          (setq thiscol
                (string-to-number
                 (read-string "Use column N for sorting: ")))
        (setq thiscol 1))
      (org-table-goto-column thiscol))
    (org-table-check-inside-data-field)
    (if (org-region-active-p)
        (progn
          (setq beg (region-beginning) end (region-end))
          (goto-char beg)
          (setq column (org-table-current-column)
                beg (point-at-bol))
          (goto-char end)
          (setq end (point-at-bol 2)))
      (setq column (org-table-current-column)
            pos (point)
            tbeg (org-table-begin)
            tend (org-table-end))
      (if (re-search-backward org-table-hline-regexp tbeg t)
          (setq beg (point-at-bol 2))
        (goto-char tbeg)
        (setq beg (point-at-bol 1)))
      (goto-char pos)
      (if (re-search-forward org-table-hline-regexp tend t)
          (setq end (point-at-bol 1))
        (goto-char tend)
        (setq end (point-at-bol))))
    (setq beg (move-marker (make-marker) beg)
          end (move-marker (make-marker) end))
    (untabify beg end)
    (goto-char beg)
    (org-table-goto-column column)
    (skip-chars-backward "^|")
    (setq bcol (point))
    (goto-char end)
    (previous-line)
    (org-table-goto-column column)
    (skip-chars-forward "^|")
    (setq ecol (point))
    (org-table-copy-region bcol ecol nil)
    (setq lns (mapcar (lambda (x) (cons 
                                   (org-sort-remove-invisible 
                                    (substring-no-properties x) )
                                   x))
                      ( mapcar 'car org-table-clip)))    
    (setq lns (org-do-sort lns "Column" ))

    (setq org-table-clip (mapcar 'list (mapcar 'cdr lns)))
    (goto-char beg)
    (org-table-goto-column column)
    (org-table-paste-rectangle)
    (org-goto-line thisline)
    (org-table-goto-column thiscol)
    (when otc (org-table-toggle-coordinate-overlays))
    (message "%d element sorted in column %d" (length lns) column)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org clock
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Change task state to STARTED when clocking in
(setq org-clock-in-switch-to-state "STARTED")
;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)

;; Show the clocked-in task - if any - in the header line
(defun sanityinc/show-org-clock-in-header-line ()
  (setq-default header-line-format '((" " org-mode-line-string " "))))

(defun sanityinc/hide-org-clock-from-header-line ()
  (setq-default header-line-format nil))

(add-hook 'org-clock-in-hook 'sanityinc/show-org-clock-in-header-line)
(add-hook 'org-clock-out-hook 'sanityinc/hide-org-clock-from-header-line)
(add-hook 'org-clock-cancel-hook 'sanityinc/hide-org-clock-from-header-line)

(eval-after-load 'org-clock
  '(progn
     (define-key org-clock-mode-line-map [header-line mouse-2] 'org-clock-goto)
     (define-key org-clock-mode-line-map [header-line mouse-1] 'org-clock-menu)))

(eval-after-load 'org
  '(progn
     (setq org-imenu-depth 4)
     (require 'org-clock)
     ;; @see http://irreal.org/blog/1
     (setq org-src-fontify-natively t)))

(defun org-mode-hook-setup ()
  (setq evil-auto-indent nil)
  ;; org-mode's own flycheck will be loaded
  ;; (flyspell-mode 1)
  ;; display wrapped lines instead of truncated lines
  (setq truncate-lines nil)
  (setq word-wrap t))
(add-hook 'org-mode-hook 'org-mode-hook-setup)

(defadvice org-open-at-point (around org-open-at-point-choose-browser activate)
  (let ((browse-url-browser-function
         (cond ((equal (ad-get-arg 0) '(4))
                'browse-url-generic)
               ((equal (ad-get-arg 0) '(16))
                'choose-browser)
               (t
                (lambda (url &optional new)
                  (w3m-browse-url url t))))))
    ad-do-it))
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda ()
                           (org-bullets-mode 1)))

(define-key org-mode-map (kbd "<C-tab>") nil)

(provide 'init-org)
