;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;frame and appearance settings
(auto-image-file-mode t)
(setq inhibit-startup-echo-area-message t
      inhibit-startup-screen t
      inhibit-startup-message t
      use-file-dialog t
      use-dialog-box t
      display-time-mode nil
      ;; Show a marker in the left fringe for lines not in the buffer
      indicate-empty-lines t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default
 initial-scratch-message
 (concat ";; Hi "(or user-login-name "")" welcome!
;; This buffer is for notes that you don't want to save, and for Lisp evaluation. \n;;"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;设置窗格标题更有意义。
;; (%-constructs are allowed when the string is the entire mode-line-format
;;  or when it is found in a cons-cell or a list)
;; %b -- print buffer name.      %f -- print visited file name.
;; %F -- print frame name.
;; %* -- print %, * or hyphen.   %+ -- print *, % or hyphen.
;;       %& is like %*, but ignore read-only-ness.
;;       % means buffer is read-only and * means it is modified.
;;       For a modified read-only buffer, %* gives % and %+ gives *.
;; %s -- print process status.   %l -- print the current line number.
;; %c -- print the current column number (this makes editing slower).
;;       To make the column number update correctly in all cases,
;;       `column-number-mode' must be non-nil.
;; %p -- print percent of buffer above top of window, or Top, Bot or All.
;; %P -- print percent of buffer above bottom of window, perhaps plus Top,
;;       or print Bottom or All.
;; %m -- print the mode name.
;; %n -- print Narrow if appropriate.
;; %z -- print mnemonics of buffer, terminal, and keyboard coding systems.
;; %Z -- like %z, but including the end-of-line format.
;; %[ -- print one [ for each recursive editing level.  %] similar.
;; %% -- print %.   %- -- print infinitely many dashes.
(setq frame-title-format '((:eval
                            (if (buffer-file-name)
                                (abbreviate-file-name (buffer-file-name))))
                           " (%I) "
                           " || Emacs: "(:eval emacs-version) " on "
                           (:eval (getenv-internal "LOGNAME"))
                           "@"
                           (:eval (system-name))
                           " || "
                           "window system:"
                           (:eval (prin1-to-string window-system))
                           "-"
                           (:eval (number-to-string window-system-version))
                           ;;" : "
                           " || code system: %z"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;these 3 lines turn off GUI junk
;; NO tool bar
(if (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
;; no scroll bar
(if (fboundp 'set-scroll-bar-mode)
  (set-scroll-bar-mode nil))
;; no menu bar
(if (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (toggle-frame-fullscreen)
(toggle-frame-maximized)
;; not work perfect so
;; (setq initial-frame-alist
;;       '((left . 0)
;;         (top . 0)
;;         (width . 333)
;;         (height . 666)))
(provide 'init-framebuffers)
