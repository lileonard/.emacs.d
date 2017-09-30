
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
;; basic settings
(defvar best-gc-cons-threshold 4000000 "Best default gc threshold value. Should't be too big.")
;; don't GC during startup to save time
(setq gc-cons-threshold most-positive-fixnum)
;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(setq *is-a-mac* (eq system-type 'darwin))
(setq *win64* (eq system-type 'windows-nt) )
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
(setq *emacs24* (and (not (featurep 'xemacs)) (or (>= emacs-major-version 24))) )
(setq *emacs25* (and (not (featurep 'xemacs)) (or (>= emacs-major-version 25))) )
(setq *no-memory* (cond
                   (*is-a-mac*
                    (< (string-to-number
                        (nth 1
                             (split-string
                              (shell-command-to-string "sysctl hw.physmem"))))
                       4000000000))
                   (*linux* nil)
                   (t nil)))

(setq *emacs24old*  (or (and (= emacs-major-version 24) (= emacs-minor-version 3))
                        (not *emacs24*)))

;; @see https://www.reddit.com/r/emacs/comments/55ork0/is_emacs_251_noticeably_slower_than_245_on_windows/
;; Emacs 25 does gc too frequently
(when *emacs25*
  ;; (setq garbage-collection-messages t) ; for debug
  (setq gc-cons-threshold (* 64 1024 1024) )
  (setq gc-cons-percentage 0.5)
  (run-with-idle-timer 5 t #'garbage-collect))
;; add all path in .emacs.d to load path
(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))
;; *Message* buffer should be writable in 24.4+
(defadvice switch-to-buffer (after switch-to-buffer-after-hack activate)
  (if (string= "*Messages*" (buffer-name))
      (read-only-mode -1)))

;; add all path under .emacs.d to loadpath
(let ((default-directory  "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))

;; basic settings
(require 'init-basicset)
;; face settings
(require 'init-windows)
(require 'init-colortheme)
(require 'init-framebuffers)
(require 'init-font)
(require 'init-powerline)
(require 'init-tabbar)
;; major mode settings
(require 'init-small-packages)
(require 'init-modbindings)
(require 'init-org)
(require 'init-matlab)
(require 'init-cmake)
(require 'init-lisp)
(require 'init-latex)
(require 'init-python)
;; ;; minor mode and plugin settings
(require 'init-sessions)
(require 'init-ido)
(require 'init-yasnippet)
(require 'init-company)
(require 'init-autocomplete)
(require 'init-helm)
(require 'init-magit)
(require 'init-tags)
(require 'init-gud)
(require 'init-eldoc)
(require 'init-bookmark)
(require 'init-multiple-cursors)
(require 'init-projectile)
(require 'init-flycheck)
(require 'init-hs-minor-mode)
(require 'init-cedet)
(require 'init-smartparens)
;; plugin inits
(require 'init-linum-mode)
(require 'init-highline)
(require 'init-neotree)
;; my init functions
(require 'my-c-config)
(require 'my-keybinding)
(require 'my-compilation-settings)
(require 'my-elisp-functions)
;; show start time and each init.el costs
(autoload 'esup "esup" "Emacs Start Up Profiler." t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq gc-cons-threshold best-gc-cons-threshold)
