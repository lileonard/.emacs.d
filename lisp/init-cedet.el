;;; Init-CEDET.el --- CEDET init                     -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Li Yuanheng

;; Author: Li Yuanheng <liyuanheng.leo@gmail.com>

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; basic modes
(dolist (hook '(emacs-lisp-mode-hook  
                c-mode-hook
                c++-mode-hook
                java-mode-hook
                python-mode-hook))
  (add-hook hook (lambda ()
                   (semantic-mode)
                   (global-ede-mode)
                   (global-semantic-idle-local-symbol-highlight-mode)
                   (global-semantic-idle-scheduler-mode)
                   (global-semantic-idle-summary-mode)
                   (global-semanticdb-minor-mode)
                   (global-semantic-highlight-func-mode)
                   (global-semantic-idle-completions-mode)
                   (global-semantic-decoration-mode)
                   ;; (global-semantic-stickyfunc-mode)
                   ;; (global-semantic-show-unmatched-syntax-mode)
                   ;; commit it for my tab-bar
                   )))
;; let semantic show all the function information
(require 'stickyfunc-enhance)

;;customise my CEDET
;; Include settings
(autoload 'semantic/db "semantic/db" "db" t)
(autoload 'semantic/ia "semantic/ia" "ia" t)
(autoload 'semantic/bovine/gcc "semantic/bovine/gcc" "gcc" t)
(autoload 'semantic-add-system-include "semantic/bovine/c" "c" t)
;; semanticdb path
(setq semanticdb-default-save-directory "~/.emacs.d/.semanticdb/")
;; project include setting
(defun my-semantic-include-setting ()
  (let ((include-sys-dirs my-sys-c-include))
    (setq include-sys-dirs (append include-sys-dirs my-sys-c-include))
    (mapc (lambda (dir)
            (semantic-add-system-include dir 'cc-mode)
            (semantic-add-system-include dir 'c++-mode)
            (semantic-add-system-include dir 'c-mode))
          include-sys-dirs))
  (let ((include-custom-dirs my-custom-include-dirs))
    (setq include-custom-dirs (append include-custom-dirs my-custom-include-dirs))
    (mapc (lambda (dir)
            (semantic-add-system-include dir 'cc-mode)
            (semantic-add-system-include dir 'c++-mode)
            (semantic-add-system-include dir 'c-mode))
          include-custom-dirs)))
(eval-after-load "cc-mode"
  '(my-semantic-include-setting))
;; if the cursor on a function press f4 to jump to the function
(global-set-key (kbd "<f4>") 'semantic-ia-fast-jump)
(global-set-key (kbd "<s-f4>") 'semantic-ia-show-summary)
(global-set-key (kbd "<s-f1>") 'semantic-ia-complete-symbol-menu)

(autoload 'fa-config-default "function-args" nil t)
(defun my-function-args-settings()
(fa-config-default)
(set-face-attribute
 'fa-face-hint nil
 :background "black"
 :foreground "gray66")
(set-face-attribute
 'fa-face-type nil
 :background "black"
 :foreground "white"))
(eval-after-load "cc-mode"
  '(my-function-args-settings))

(autoload 'srefactor-refactor-at-point "srefactor" "refactor C using semantic" t)

(provide 'init-cedet)
