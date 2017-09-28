;; bracket pair  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-bracket-python-auto-pair ()
  (lambda ()
    (define-key python-mode-map "\"" 'skeleton-pair-insert-maybe)
    (define-key python-mode-map "\'" 'skeleton-pair-insert-maybe)
    (define-key python-mode-map "("  'skeleton-pair-insert-maybe)
    (define-key python-mode-map "["  'skeleton-pair-insert-maybe)
    (define-key python-mode-map "{"  'skeleton-pair-insert-maybe)))
(add-hook 'python-mode-hook 'my-bracket-python-auto-pair)
;;auto pair () [] '' {} ""
(defun my-brace-with-bracket-auto-pair ()
  (interactive)
  (setq skeleton-pair t)
  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\'") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\[") 'skeleton-pair-insert-maybe))
(add-hook 'cmake-mode-hook        'my-brace-with-bracket-auto-pair)
(add-hook 'latex-mode-hook        'my-brace-with-bracket-auto-pair)
(add-hook 'emacs-lisp-mode-hook   'my-brace-with-bracket-auto-pair)
(add-hook 'scheme-mode-hook       'my-brace-with-bracket-auto-pair)
(add-hook 'LaTeX-mode-hook        'my-brace-with-bracket-auto-pair)
(add-hook 'matlab-mode-hook       'my-brace-with-bracket-auto-pair)

;;auto pair () [] {} ""
(defun my-brace-with-bracket-auto-pair ()
  (interactive)
  (setq skeleton-pair t)
  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\[") 'skeleton-pair-insert-maybe))
(add-hook 'lisp-mode-hook 'my-brace-with-bracket-auto-pair)

;;WCY's brace style auto pair {} and do lots of my barce pair
(defun my-c-brace-hook ()
  (interactive)
  (setq skeleton-pair t)
  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\'") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\[") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\{") 'skeleton-c-mode-left-brace))
(defun skeleton-c-mode-left-brace (arg)
  (interactive "*P")
  (if  (c-in-literal (c-most-enclosing-brace (c-parse-state)))
      (self-insert-command 1)
    ;; auto insert complex things.
    (let* ((current-line (delete-and-extract-region (line-beginning-position) (line-end-position)))
           (lines (and arg (mark t) (delete-and-extract-region (mark t) (point))))
           (after-point (make-marker)))
       ;;; delete extra blank begin and after the LINES
      (setq lines (and lines
                       (with-temp-buffer
                         (insert lines)
                         (beginning-of-buffer)
                         (delete-blank-lines)
                         (delete-blank-lines)
                         (end-of-buffer)
                         (delete-blank-lines)
                         (delete-blank-lines)
                         (buffer-string))))
      (save-excursion
        (let* ((old-point (point)))
          (insert (if current-line current-line "")  "{\n")
          (and lines (insert lines))
          (move-marker after-point (point))
          (insert "\n}")
          (indent-region old-point (point) nil)))
      (goto-char after-point)
      (c-indent-line))))
(add-hook 'c-mode-hook    'my-c-brace-hook)
(add-hook 'c++-mode-hook  'my-c-brace-hook)

(provide 'my-bracket-pair)
