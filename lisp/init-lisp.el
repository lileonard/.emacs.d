;; {{ scheme setup
(setq scheme-program-name "guile")
(eval-after-load 'scheme-mode
  '(progn
     (require 'quack)))
;; }}

;; A quick way to jump to the definition of a function given its key binding
(global-set-key (kbd "C-h K") 'find-function-on-key)

(eval-after-load 'paredit
  '(progn
     (diminish 'paredit-mode " Par")))


(defvar paredit-minibuffer-commands
  '(eval-expression
    pp-eval-expression
    eval-expression-with-eldoc
    ibuffer-do-eval
    ibuffer-do-view-and-eval)
  "Interactive commands for which paredit should be enabled in the minibuffer.")

(defun conditionally-paredit-mode (flag)
  "Enable paredit during lisp-related minibuffer commands."
  (if (memq this-command paredit-minibuffer-commands)
      (paredit-mode flag)))
;; ----------------------------------------------------------------------------
;; Highlight current sexp
;; ----------------------------------------------------------------------------
;; Prevent flickery behaviour due to hl-sexp-mode unhighlighting before each command
(eval-after-load 'hl-sexp
  '(defadvice hl-sexp-mode (after unflicker (turn-on) activate)
     (when turn-on
       (remove-hook 'pre-command-hook #'hl-sexp-unhighlight))))

;; ----------------------------------------------------------------------------
;; First, turn on eldoc everywhere it's useful:
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;; Define some niceties for popping up an ielm buffer:
(defun ielm-other-window ()
  "Run ielm on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*ielm*"))
  (call-interactively 'ielm))

(provide 'init-lisp)

