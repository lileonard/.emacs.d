;;包 ido.el 用于方便高效的切换buffer和寻找并打开文件。 
(require 'ido)
(ido-mode t)  ; use 'buffer rather than t to use only buffer switching
(ido-everywhere t)

;; many basic settings 
(setq ido-ignore-extensions t
      ido-enable-prefix t
      ido-enable-flex-matching t
      ido-use-faces nil
      ido-use-filename-at-point 'guess
      ido-create-new-buffer 'always
      ido-auto-merge-work-directories-length 0
      ido-use-virtual-buffers t)
;; @see https://github.com/lewang/flx
(setq flx-ido-threshold 10000)
;; Allow the same buffer to be open in different frames
(setq ido-default-buffer-method 'selected-window)

(defun ido-imenu ()
  "Update the imenu index and then use ido to select a symbol to navigate to.
Symbols matching the text at point are put first in the completion list."
  (interactive)
  (unless (featurep 'imenu)
    (require 'imenu nil t))
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (cl-flet ((addsymbols (symbol-list)
                          (when (listp symbol-list)
                            (dolist (symbol symbol-list)
                              (let ((name nil) (position nil))
                                (cond
                                 ((and (listp symbol) (imenu--subalist-p symbol))
                                  (addsymbols symbol))

                                 ((listp symbol)
                                  (setq name (car symbol))
                                  (setq position (cdr symbol)))

                                 ((stringp symbol)
                                  (setq name symbol)
                                  (setq position (get-text-property 1 'org-imenu-marker symbol))))

                                (unless (or (null position) (null name))
                                  (add-to-list 'symbol-names name)
                                  (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    ;; If there are matching symbols at point, put them at the beginning of `symbol-names'.
    (let ((symbol-at-point (thing-at-point 'symbol)))
      (when symbol-at-point
        (let* ((regexp (concat (regexp-quote symbol-at-point) "$"))
               (matching-symbols (delq nil (mapcar (lambda (symbol)
                                                     (if (string-match regexp symbol) symbol))
                                                   symbol-names))))
          (when matching-symbols
            (sort matching-symbols (lambda (a b) (> (length a) (length b))))
            (mapc (lambda (symbol) (setq symbol-names (cons symbol (delete symbol symbol-names))))
                  matching-symbols)))))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (push-mark (point))
      (goto-char position))))
(global-set-key (kbd "s-k") 'ido-kill-buffer)
(provide 'init-ido)
