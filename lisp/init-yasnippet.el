(require 'yasnippet)
(setq my-snippets-dir (expand-file-name "~/.emacs.d/snippets"))
(yas-global-mode 1)
;;(yas-reload-all)
(defun yasnippet-settings ()
  "settings for `yasnippet'."
  (defun yasnippet-unbind-trigger-key ()
    "Unbind `yas/trigger-key'."
    (let ((key yas/trigger-key))
      (setq yas/trigger-key nil)
      (yas/trigger-key-reload key)))
  (yasnippet-unbind-trigger-key)
;;;###autoload
  (defun yasnippet-reload-after-save ()
    (let* ((bfn (expand-file-name (buffer-file-name)))
           (root (expand-file-name yas/root-directory)))
      (when (string-match (concat "^" root) bfn)
        (yas/load-snippet-buffer))))
  (add-hook 'after-save-hook 'yasnippet-reload-after-save))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'popup)
;; add some shotcuts in popup menu mode
(define-key popup-menu-keymap (kbd "TAB") 'popup-next)
(define-key popup-menu-keymap (kbd "<tab>") 'popup-next)
(define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
(define-key popup-menu-keymap "\r" nil)

(defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
  (when (featurep 'popup)
    (popup-menu*
     (mapcar
      (lambda (choice)
        (popup-make-item
         (or (and display-fn (funcall display-fn choice))
             choice)
         :value choice))
      choices)
     :prompt prompt
     ;; start isearch mode immediately
     :isearch t
     )))
(setq yas-prompt-functions '(yas-popup-isearch-prompt yas-ido-prompt yas-no-prompt))

;;;; With `skk-mode'
(defadvice skk-j-mode-on (after yasnippet activate)
  (yas-minor-mode -1))
(defadvice skk-mode-exit (after yasnippet activate)
  (yas-minor-mode 1))
(defadvice skk-latin-mode-on (after yasnippet activate)
  (yas-minor-mode 1))
(defun yas/disable-when-skk-is-enabled ()
  (when (and (boundp 'skk-mode) skk-mode)
    (yas-minor-mode -1)))
(add-hook 'after-change-major-mode-hook 'yas/disable-when-skk-is-enabled t)

;;;; auto-complete
(defun yas/set-ac-modes ()
  "Add modes in `yas-snippet-dirs' to `ac-modes'.

Call (yas/set-ac-modes) BEFORE (global-auto-complete-mode 1) or (ac-config-default)."
  (eval-after-load "auto-complete"
    '(setq ac-modes
           (append
            (apply 'append (mapcar (lambda (dir) (mapcar 'intern (directory-files dir nil "-mode$")))
                                   (yas-snippet-dirs)))
            ac-modes))))

;;;; parentheses hack in `emacs-lisp-mode'
(declare-function paredit-raise-sexp "ext:paredit")
(declare-function yas-reload-all "yasnippet")
(defun yas/before-expand-snippet-hook--emacs-lisp-remove-parenthsis (content)
  (when (and (boundp 'paredit-mode) paredit-mode
             (memq major-mode '(emacs-lisp-mode lisp-interaction-mode ielm-mode))
             (ignore-errors (fboundp (car (read content)))))
    (let ((m (point)) m2)
      (forward-sexp -1)
      (setq m2 (point))
      (when (eq (char-before) ?\()
        (paredit-raise-sexp)
        ;; Remove original abbrev 1- by `paredit-raise-sexp'
        (delete-region (1- m2) (1- m))))))
(defadvice yas-expand-snippet (before emacs-lisp-remove-parenthesis (content &optional start end expand-env))
  "Remove parentheses when yasnippet abbrev is expanded in function position."
  (setq start (and start (move-marker (make-marker) start)))
  (setq end (and start (move-marker (make-marker) end)))
  (and start end (yas/before-expand-snippet-hook--emacs-lisp-remove-parenthsis content)))

(defun yas/enable-emacs-lisp-paren-hack ()
  "Enable advice in `yas-expand-snippet' emacs-lisp-remove-parenthesis."
  (ad-enable-advice 'yas-expand-snippet 'before 'emacs-lisp-remove-parenthesis)
  (ad-update 'yas-expand-snippet))

;;;; Expand snippet synchronously
(defvar yas/recursive-edit-flag nil)
(defun yas-expand-sync ()
  "Execute `yas-expand'. This function exits after expanding snippet."
  (interactive)
  (let ((yas/recursive-edit-flag t))
    (call-interactively 'yas-expand)
    (recursive-edit)))
(defun yas-expand-snippet-sync (content &optional start end expand-env)
  "Execute `yas-expand-snippet'. This function exits after expanding snippet."
  (let ((yas/recursive-edit-flag t))
    (yas-expand-snippet content start end expand-env)
    (recursive-edit)))
(defun yas/after-exit-snippet-hook--recursive-edit ()
  (when yas/recursive-edit-flag
    (throw 'exit nil)))
(add-hook 'yas/after-exit-snippet-hook
          'yas/after-exit-snippet-hook--recursive-edit)

(autoload 'yasnippet "helm-c-yasnippet" "" t)
(setq helm-yas-space-match-any-greedy t)


(provide 'init-yasnippet)
