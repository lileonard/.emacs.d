(require 'tabbar)
(tabbar-mode)
(tabbar-mwheel-mode)
;;(setq tabbar-use-images nil)

(defun tabbar-buffer-groups ()
  "Return the list of group names the current buffer belongs to.
     Return a list of one element based on major mode."
  (list
   (cond
    ((or (get-buffer-process (current-buffer))
         ;; Check if the major mode derives from `comint-mode' or
         ;; `compilation-mode'.
         (tabbar-buffer-mode-derived-p
          major-mode '(comint-mode compilation-mode)))
     "Process"
     )
    ((member (buffer-name)
             '("*scratch*" "*Messages*" "*Help*"))
     "Common"
     )
    ((string-equal "*" (substring (buffer-name) 0 1))
     "Common"
     )
    ((member (buffer-name)
             '("xyz" "day" "m3" "abi" "for" "nws" "eng" "f_g" "tim" "tmp"))
     "Main"
     )
    ((eq major-mode 'dired-mode)
     "Dired"
     )
    ((memq major-mode
           '(help-mode apropos-mode Info-mode Man-mode))
     "Common"
     )
    ((memq major-mode
           '(rmail-mode
             rmail-edit-mode vm-summary-mode vm-mode mail-mode
             mh-letter-mode mh-show-mode mh-folder-mode
             gnus-summary-mode message-mode gnus-group-mode
             gnus-article-mode score-mode gnus-browse-killed-mode))
     "Mail"
     )
    (t
     ;; Return `mode-name' if not blank, `major-mode' otherwise.
     (if (and (stringp mode-name)
              ;; Take care of preserving the match-data because this
              ;; function is called when updating the header line.
              (save-match-data (string-match "[^ ]" mode-name)))
         mode-name
       (symbol-name major-mode))
     ))))

(defun tabbar-filter (condp lst)
  (delq nil
        (mapcar (lambda (x) (and (funcall condp x) x)) lst)))

(defun tabbar-filter-buffer-list ()
  (tabbar-filter
   (lambda (x)
     (let ((name (format "%s" x)))
       (and
        (not (string-prefix-p "*epc" name))
        (not (string-prefix-p "*helm" name))
        (not (string-prefix-p "*Messages*" name))
        (not (string-prefix-p "TAGS" name))
        (not (string-prefix-p "*Help*" name))
        (not (string-prefix-p "*SPEEDBAR*" name))
        (not (string-prefix-p "*scratch*" name))
        )))
   (delq nil
         (mapcar #'(lambda (b)
                     (cond
                      ;; Always include the current buffer.
                      ((eq (current-buffer) b) b)
                      ((buffer-file-name b) b)
                      ((char-equal ?\  (aref (buffer-name b) 0)) nil)
                      ((buffer-live-p b) b)))
                 (buffer-list)))))
(setq tabbar-buffer-list-function 'tabbar-filter-buffer-list)

(defadvice tabbar-buffer-tab-label (after fixup_tab_label_space_and_flag activate)
  (setq ad-return-value
        (if (and (buffer-modified-p (tabbar-tab-value tab))
                 (buffer-file-name (tabbar-tab-value tab)))
            (concat " + " (concat ad-return-value " "))
          (concat " " (concat ad-return-value " ")))))
(defun ztl-modification-state-change ()
  (tabbar-set-template tabbar-current-tabset nil)
  (tabbar-display-update))
(defun ztl-on-buffer-modification ()
  (set-buffer-modified-p t)
  (ztl-modification-state-change))
(add-hook 'after-save-hook 'ztl-modification-state-change)
(add-hook 'first-change-hook 'ztl-on-buffer-modification)

(defun tabbar-add-tab (tabset object &optional append_ignored)
  "Add to TABSET a tab with value OBJECT if there isn't one there yet.
 If the tab is added, it is added at the beginning of the tab list,
 unless the optional argument APPEND is non-nil, in which case it is
 added at the end."
  (let ((tabs (tabbar-tabs tabset)))
    (if (tabbar-get-tab object tabset)
        tabs
      (let ((tab (tabbar-make-tab object tabset)))
        (tabbar-set-template tabset nil)
        (set tabset (sort (cons tab tabs)
                          (lambda (a b) (string< (buffer-name (car a)) (buffer-name (car b))))))))))

;;;; 设置tabbar外观
;; 设置tabbar间隔 
;; (setq tabbar-separator-value "§")
;; (setq tabbar-separator (list 0.1))
;; 设置默认主题: 字体, 背景和前景颜色，大小
(set-face-attribute
 'tabbar-default nil
 :family "Comic Sans MS" ;"Vera Sans YuanTi Mono"
 :background "#888888"
 :foreground "#dcdccc"
 :height 0.8
 )

;; 设置左边按钮外观：外框框边大小和颜色
(set-face-attribute
 'tabbar-button nil
 :inherit 'tabbar-default
 :box '(:line-width 1 :color "gray30")
 )
(set-face-attribute
 'tabbar-separator nil
 :inherit 'tabbar-default
 :foreground "blue"
 :background "dark gray"
 :box '(:line-width 1 :color "gray11" :style 'released-button)
 )

;; 设置当前tab外观：颜色，字体，外框大小和颜色
(set-face-attribute
 'tabbar-selected nil
 :inherit 'tabbar-default
 :foreground "orange" 
 :background "#666666" 
 :box '(:line-width 1 :color "#111111" :style 'pressed-button)
 :weight 'bold
 )
;; 设置非当前tab外观：外框大小和颜色
(set-face-attribute
 'tabbar-unselected nil
 :inherit 'tabbar-default
 :box '(:line-width 1 :color "#BBBBBB" :style 'released-button))

(set-face-attribute
 'tabbar-modified nil
 :box '(:line-width 1 :color "white" :style released-button)
 :foreground "red")
;;my mouse setting
(defun tabbar-buffer-select-tab (event tab)
  "On mouse EVENT, select TAB."
  (let ((mouse-button (event-basic-type event))
        (buffer (tabbar-tab-value tab)))
    (cond
     ((eq mouse-button 'mouse-3)
      (pop-to-buffer buffer nil))
     ((eq mouse-button 'mouse-2)
      (kill-buffer buffer))
     (t
      (switch-to-buffer buffer)))
    ;; Don't show groups.
    (tabbar-buffer-show-groups nil)
    ))
(global-set-key (kbd "<C-tab>") 'tabbar-forward)
(global-set-key (kbd "<s-tab>") 'tabbar-backward)

(provide 'init-tabbar)
