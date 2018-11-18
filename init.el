
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
  ;; (setq garbage-collection-messages t) ; for debug
(setq gc-cons-threshold (* 64 1024 1024) )
(setq gc-cons-percentage 0.5)
(run-with-idle-timer 5 t #'garbage-collect)
(package-initialize)
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
(require 'init-cedet)
(require 'init-gud)
(require 'init-eldoc)
(require 'init-bookmark)
(require 'init-multiple-cursors)
(require 'init-projectile)
(require 'init-flycheck)
(require 'init-hs-minor-mode)
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
(remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)
