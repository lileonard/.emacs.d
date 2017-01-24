(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)
(add-hook 'python-mode-hook     'hs-minor-mode)
(add-hook 'fortran-mode-hook    'hs-minor-mode)
(add-hook 'latex-mode-hook      'hs-minor-mode)

(defvar hs-headline-max-len 30 "*Maximum length of `hs-headline' to display.")
(defvar hs-overlay-map (make-sparse-keymap) "Keymap for hs minor mode overlay.")
(defvar hs-hide-all nil "Current state of hideshow for toggling all.")
(defvar fold-all-fun nil "Function to fold all.")
(defvar fold-fun nil "Function to fold.")

(defun hs-minor-mode-face-settings ()
  "Face settings for `hideshow'."
  (defface hs-block-flag-face
    '((((type tty pc)) :foreground "white" :background "red")
      (t :foreground "#AF210000AF21" :background "lightgreen" :box (:line-width -1 :style released-button)))
    "Face of hs minor mode block flag."))
(eval-after-load "hideshow"
  `(hs-minor-mode-face-settings))

(defun hs-display-headline ()
  (let* ((len (length hs-headline))
         (headline hs-headline)
         (postfix ""))
    (when (>= len hs-headline-max-len)
      (setq postfix "...")
      (setq headline (substring hs-headline 0 hs-headline-max-len)))
    (if hs-headline (concat headline postfix " ") "")))

(defun hs-abstract-overlay (ov)
  (let* ((start (overlay-start ov))
         (end (overlay-end ov))
         (str (format "<%d lines>" (count-lines start end))) text)
    (setq text (propertize str 'face 'hs-block-flag-face 'help-echo (buffer-substring (1+ start) end)))
    (overlay-put ov 'display text)
    (overlay-put ov 'pointer 'hand)
    (overlay-put ov 'keymap hs-overlay-map)))

(defun hs-toggle-hiding-all ()
  "Toggle hideshow all."
  (interactive)
  (setq hs-hide-all (not hs-hide-all))
  (if hs-hide-all
      (hs-hide-all)
    (hs-show-all)))

(defun hs-toggle-fold-all ()
  "Toggle fold all."
  (interactive)
  (if fold-all-fun
      (call-interactively fold-all-fun)
    (hs-toggle-hiding-all)))

(defun hs-toggle-fold ()
  "Toggle fold."
  (interactive)
  (if fold-fun
      (call-interactively fold-fun)
    (hs-toggle-hiding)))

(eval-after-load "hideshow"
  '(progn
     (setq hs-isearch-open t)
     (setq-default mode-line-format
                   (append '((:eval (hs-display-headline))) mode-line-format))
     (setq hs-set-up-overlay 'hs-abstract-overlay)
     (make-local-variable 'hs-hide-all)
     (make-variable-buffer-local 'fold-all-fun)
     (make-variable-buffer-local 'fold-fun)

     (defadvice goto-line (after expand-after-goto-line activate compile)
       (save-excursion (hs-show-block)))

     (defadvice find-tag (after expand-after-find-tag activate compile)
       (save-excursion (hs-show-block)))
     ))

(setq hs-minor-mode-map
      (let ((map (make-sparse-keymap)))
        (define-key map (kbd "M-1") 'hs-show-all)
        (define-key map (kbd "s-1") 'hs-hide-level)
        (define-key map (kbd "C-1") 'hs-toggle-hiding)map))

(provide 'init-hs-minor-mode)
