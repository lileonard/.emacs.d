;;; Init-BasicSet.el --- basic settings              -*- lexical-binding: t; -*-
;; basic set and build in plugins
;; Copyright (C) 2016  Li Yuanheng

;; Author: Li Yuanheng <liyuanheng.leo@gmail.com>

;; 设置默认编码
(set-language-environment "UTF-8")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq visible-bell t
      mouse-yank-at-point t
      kill-ring-max 366
      fill-column 66
      sentence-end "\\([¡££¡£¿]\\|¡­¡­\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*"
      sentence-end-double-space nil
      column-number-mode t
      global-font-lock-mode t
      make-backup-files nil
      ;; select-enable-clipboard t
      suggest-key-bindings 1)
(setq-default indent-tabs-mode nil)

;; (flymake-mode nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq enable-recursive-minibuffers t
      scroll-conservatively 100)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(put 'set-goal-column          'disabled nil)
(put 'narrow-to-region         'disabled nil)
(put 'upcase-region            'disabled nil)
(put 'downcase-region          'disabled nil)
(put 'LaTeX-hide-environment   'disabled nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq user-full-name "Li Yuanheng"
      user-mail-address "liyuanheng.leo@gmail.com")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'yes-or-no-p 'y-or-n-p)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq-default cursor-type 'bar)
;; (blink-cursor-mode -1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq track-eol 1
      backup-by-copying t
      lpr-command ""
      printer-name "")

(delete-selection-mode t)
(fset 'print-buffer 'ignore)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; == No splash screen please... jeez =========================================
(setq inhibit-startup-screen t)
;;some TAB settings
(setq-default indent-tabs-mode nil
              default-tab-width 4)

(require 'paren)
(show-paren-mode t)
(setq show-paren-style 'parentheses)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'whitespace)
(global-whitespace-mode 1)
;;(setq whitespace-tabpace-style (quote (spaces tabs newline space-mark tab-mark newline-mark)))
(setq whitespace-style (quote (tab-mark))
      whitespace-display-mappings
      ;; all numbers are Unicode codepoint in decimal. e.g. (insert-char 182 1)
      '(
        (space-mark 32 [183] [46]) ; 32 SPACE 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
        (newline-mark 10 [182 10]) ; 10 LINE FEED
        (tab-mark 9 [8677 9]) ; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「」
        ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; don't let the cursor go into minibuffer prompt
(setq minibuffer-prompt-properties
      (quote
       (read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 保存时,检查文件是否包含#!,若包含则给文件添加执行权限
(defun mark-executable-when-save ()
  (add-hook 'after-save-hook
            'executable-make-buffer-file-executable-if-script-p nil t))
(add-hook 'prog-mode-hook #'mark-executable-when-save)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto refrech buffer from disk
(global-auto-revert-mode t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq truncate-partial-width-windows nil)
(setq-default grep-scroll-output t)
;; 随着grep输出结果的增多,buffer自动滚动

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 美化显示符号（elisp），比如lambda会显示为λ
(global-prettify-symbols-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; if OS is changed use    echo "" | g++ -v -x c++ -E -
;;  find code like this
;;  #include "..." search starts here:
;;  #include <...> search starts here:
;;   /usr/lib/gcc/x86_64-redhat-linux/4.4.7/../../../../include/c++/4.4.7
;;   /usr/lib/gcc/x86_64-redhat-linux/4.4.7/../../../../include/c++/4.4.7/x86_64-redhat-linux
;;   /usr/lib/gcc/x86_64-redhat-linux/4.4.7/../../../../include/c++/4.4.7/backward
;;   /usr/local/include
;;   /usr/lib/gcc/x86_64-redhat-linux/4.4.7/include
;;   /usr/include
;; and do NOT forget CUDA & MPI &FFTW
(defvar my-sys-c-include
  (list
   "/home/lyh/Soft/mpich/include"
   "/home/lyh/Soft/fftw3/include"
   "/home/lyh/Soft/QT/Qt4.8.1/Desktop/Qt/4.8.1/gcc/include"
   "/home/lyh/Soft/LeSeis/include"
   "."
   "/usr/lib/gcc/x86_64-redhat-linux/8/../../../../include/c++/8"
   "/usr/lib/gcc/x86_64-redhat-linux/8/../../../../include/c++/8/x86_64-redhat-linux"
   "/usr/lib/gcc/x86_64-redhat-linux/8/../../../../include/c++/8/backward"
   "/usr/lib/gcc/x86_64-redhat-linux/8/include"
   "/usr/local/include"
   "/usr/include"
   ))

(defvar my-custom-include-dirs 
  (list
   "./" "../" "../include" "../inc" "../common"
   "../public" "." "../config"
   "../.." "../../include" "../../inc"
   "../../common" "../../public" "../../config"
   "../../" "../../../include" "../../../inc"
   "../../../common" "../../../public" "../../../config"))

(provide 'init-basicset)
