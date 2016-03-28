(setq  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
       python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
       python-shell-completion-setup-code
       "from IPython.core.completerlib import module_completion"
       python-shell-completion-module-string-code
       "';'.join(module_completion('''%s'''))\n"
       python-shell-completion-string-code
       "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")
;; -----------------------------
;; emacs IPython notebook config
;; -----------------------------
;; IPython notebook
(require 'ein)
;; shortcut function to load notebooklist
(defun load-ein () 
  (ein:notebooklist-load)
  (interactive)
  (ein:notebooklist-open))
;; use autocompletion, but don't start to autocomplete after a dot
(setq ein:complete-on-dot -1)
(setq ein:use-auto-complete 1)
;; timeout settings
(setq ein:query-timeout 1000)
;; ------------------
;; misc python config
;; ------------------
;; pydoc info
(require 'pydoc-info)
;; ; jedi python completion
;; (include-elget-plugin "ctable")   ; required for epc
;; (include-elget-plugin "deferred") ; required for epc
;; (include-elget-plugin "epc")      ; required for jedi
;; (include-elget-plugin "jedi")
;; (require 'jedi)
;; (setq jedi:setup-keys t)
;; (autoload 'jedi:setup "jedi" nil t)
;; (add-hook 'python-mode-hook 'jedi:setup)
(setq auto-mode-alist
      (append 
       (list '("\\.pyx" . python-mode)
             '("SConstruct" . python-mode))
       auto-mode-alist))
;; keybindings
(eval-after-load 'python
  '(define-key python-mode-map (kbd "C-c !") 'python-shell-switch-to-shell))
(eval-after-load 'python
  '(define-key python-mode-map (kbd "C-c |") 'python-shell-send-region))

(defun python-mode-hook-setup ()
  (unless (is-buffer-file-temp)
    z    ;; run command `pip install jedi flake8 importmagic` in shell,
    ;; or just check https://github.com/jorgenschaefer/elpy
    (elpy-mode 1)
    ;; http://emacs.stackexchange.com/questions/3322/python-auto-indent-problem/3338#3338
    ;; emacs 24.4 only
    (setq electric-indent-chars (delq ?: electric-indent-chars))))
(add-hook 'python-mode-hook 'python-mode-hook-setup)
(provide 'init-python)
