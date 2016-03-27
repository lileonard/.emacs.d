;; ;; ;; org-mode
(require 'org)
(setq
 ;; follow links by pressing ENTER on them
 org-return-follows-link t
 ;; allow changing between todo stats directly by hotkey
 org-use-fast-todo-selection t
 ;; syntax highlight code in source blocks
 org-src-fontify-natively t
 ;; for the leuven theme, fontify the whole heading line
 org-fontify-whole-heading-line t
 ;; force UTF-8
 org-export-coding-system 'utf-8
 ;; use ido completion when I can
 org-completion-use-ido t
 ;; don't indent source code
 org-edit-src-content-indentation 0
 ;; don't adapt indentation
 org-adapt-indentation nil
 ;; preserve the indentation inside of source blocks
 org-src-preserve-indentation t
 ;; Imenu should use 3 depth instead of 2
 org-imenu-depth 3
 ;; always start the agenda on today
 org-agenda-start-on-weekday nil
 ;; Use sticky agenda's so they persist
 org-agenda-sticky t
 ;; show 4 agenda days
 org-agenda-span 4
 ;; special begin/end of line to skip tags and stars
 org-special-ctrl-a/e t
 ;; special keys for killing a headline
 org-special-ctrl-k t
 ;; don't adjust subtrees that I copy
 org-yank-adjusted-subtrees nil
 ;; try to be smart when editing hidden things
 org-catch-invisible-edits 'smart
 ;; blank lines are removed when exiting the code edit buffer
 org-src-strip-leading-and-trailing-blank-lines t
 ;; how org-src windows are set up when hitting C-c '
 org-src-window-setup 'current-window
 ;;org-src-window-setup 'other-window
 ;; Overwrite the current window with the agenda
 org-agenda-window-setup 'current-window
 ;; Use full outline paths for refile targets - we file directly with IDO
 org-refile-use-outline-path t
 ;; Targets complete directly with IDO
 org-outline-path-complete-in-steps nil
 ;; Allow refile to create parent tasks with confirmation
 org-refile-allow-creating-parent-nodes (quote confirm)
 ;; never leave empty lines in collapsed view
 org-cycle-separator-lines 0
 ;; Use cider as the clojure backend
 org-babel-clojure-backend 'cider
 ;; don't run stuff automatically on export
 org-export-babel-evaluate nil
 ;; export tables as CSV instead of tab-delineated
 org-table-export-default-format "orgtbl-to-csv"
 ;; always enable noweb, results as code and exporting both
 org-babel-default-header-args
 (cons '(:noweb . "yes")
       (assq-delete-all :noweb org-babel-default-header-args))
 org-babel-default-header-args
 (cons '(:exports . "both")
       (assq-delete-all :exports org-babel-default-header-args))
 ;; I don't want to be prompted on every code block evaluation
 org-confirm-babel-evaluate nil
 ;; Do not dim blocked tasks
 org-agenda-dim-blocked-tasks nil
 ;; Compact the block agenda view
 org-agenda-compact-blocks t
 ;; Mark entries as done when archiving
 org-archive-mark-done nil
 ;; Where to put headlines when archiving them
 org-archive-location "%s_archive::* Archived Tasks"
 ;; Sorting order for tasks on the agenda
 org-agenda-sorting-strategy
 (quote ((agenda habit-down
                 time-up
                 priority-down
                 user-defined-up
                 effort-up
                 category-keep)
         (todo priority-down category-up effort-up)
         (tags priority-down category-up effort-up)
         (search priority-down category-up)))

 ;; Enable display of the time grid so we can see the marker for the current time
 org-agenda-time-grid (quote ((daily today remove-match)
                              #("----------------" 0 16 (org-heading t))
                              (0900 1100 1300 1500 1700)))
 ;; Include the diary file in the agenda
 org-agenda-include-diary t
 org-agenda-diary-file "~/diary"
 org-agenda-insert-diary-extract-time t
 ;; keep the agenda filter until manually removed
 org-agenda-persistent-filter t
 org-agenda-repeating-timestamp-show-all t
 ;; Show all agenda dates - even if they are empty
 org-agenda-show-all-dates t
 org-edit-timestamp-down-means-later t
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
