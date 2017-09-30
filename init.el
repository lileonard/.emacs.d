
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
;; basic settings
(defvar best-gc-cons-threshold 4000000 "Best default gc threshold value. Should't be too big.")
;; don't GC during startup to save time
(setq gc-cons-threshold most-positive-fixnum)

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
(require 'init-highlight-indentation)
;; my init functions
(require 'my-c-config)
(require 'my-keybinding)
(require 'my-compilation-settings)
(require 'my-elisp-functions)
;; show start time and each init.el costs
(autoload 'esup "esup" "Emacs Start Up Profiler." t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq gc-cons-threshold best-gc-cons-threshold)
