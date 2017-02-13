(setq gc-cons-threshold 40000000)
(require 'package)
(package-initialize)
(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/") t)

;; add all path in .emacs.d to load path
(let ((default-directory  "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))

;; basic settings
(require 'init-basicset)
;; face settings
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
;; minor mode and plugin settings
(require 'init-helm)
(require 'init-ido)
(require 'init-cedet)
(require 'init-sr-speedbar)
(require 'init-yasnippet)
(require 'init-autocomplete)
(require 'init-magit)
(require 'init-tags)
(require 'init-gud)
(require 'init-eldoc)
(require 'init-bookmark)
(require 'init-highline)
(require 'init-projectile)
(require 'init-linum-mode)
(require 'init-hs-minor-mode)
(require 'init-flycheck)
(require 'init-calendar)
;; settings that from others
(require 'coding-settings)
;; my settings
(require 'my-c-config)
(require 'my-compilation-settings)
(require 'my-bracket-pair)
(require 'my-elisp-functions)
(require 'my-keybinding)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; show start time and each init.el costs
(autoload 'esup "esup" "Emacs Start Up Profiler." t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



