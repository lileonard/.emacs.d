;;; Init-CMake.el ---                                -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Li Yuanheng

;; Author: Li Yuanheng <liyuanheng.leo@gmail.com>
(autoload 'cmake-mode "cmake-mode.el" "cmake-mode official" t)
(defun alexott/cmake-mode-hook ()
  (local-set-key [return] 'newline-and-indent))
(add-hook 'cmake-mode-hook 'alexott/cmake-mode-hook)

(require 'cmake-font-lock)
(add-hook 'cmake-mode-hook 'cmake-font-lock-activate)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'cmake-font-lock-activate "cmake-font-lock" nil t)
(add-hook 'cmake-mode-hook 'cmake-font-lock-activate)
;; Customizing
;; `cmake-font-lock-add-keywords' -- Add keyword information:
;;
;; Adding the list of keywords to a function is a simple way to get
;; basic coloring correct. For most functions, this is sufficient.
;; For example:
;;
(cmake-font-lock-add-keywords
 "my-func" '("FILE" "RESULT" "OTHER"))
;;
;; `cmake-font-lock-set-signature' -- Set full function type:
;;
;; Set the signature (the type of the arguments) for a function. For
;; example:
;;
;; (cmake-font-lock-set-signature
;;    "my-func" '(:var nil :prop) '(("FILE" :file) ("RESULT" :var)))
;;
;; Custom types:
;;
;; The signatures of CMake functions provided by this package use a
;; number of types (see `cmake-font-lock-function-signatures'
;; for details). However, when adding new signatures, it's possible to
;; use additional types. In that case, the variable
;; `cmake-font-lock-argument-kind-face-alist' must be modified
;; to map the CMake type to a concrete Emacs face. For example:
;;
;; (cmake-font-lock-set-signature "my_warn" (:warning))
;; (add-to-list '(:warning . font-lock-warning-face)
;;              cmake-font-lock-argument-kind-face-alist)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(require 'cmake-project)
(require 'cmake-project)
(defun maybe-cmake-project-hook ()
  (if (file-exists-p "CMakeLists.txt")
      (cmake-project-mode)))
(add-hook 'c-mode-hook 'maybe-cmake-project-hook)
(add-hook 'c++-mode-hook 'maybe-cmake-project-hook)
(setq cmake-project-default-build-dir-name "build/")
(global-set-key (kbd "<C-f9>")   'cmake-project-configure-project)
(global-set-key (kbd "<f9>")     'compile)

(provide 'init-cmake)
