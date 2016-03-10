;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'fuzzy)

(require 'smex)   
(smex-initialize) 
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
 
(autoload 'goto-last-change "goto-last-change" nil t)

(require 'session)
(add-hook 'after-init-hook 'session-initialize)

(require 'rainbow-delimiters)
(add-hook 'c-mode-common-hook      #'rainbow-delimiters-mode)
(add-hook 'cmake-mode-hook         #'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook          #'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook    #'rainbow-delimiters-mode)
(add-hook 'python-mode-hook        #'rainbow-delimiters-mode)
;; Rainbow delimiters
(defun assemblage-rainbow-delim-set-face ()
  (set-face-attribute 'rainbow-delimiters-depth-1-face   nil :foreground "#D7D7D7")
  (set-face-attribute 'rainbow-delimiters-depth-2-face   nil :foreground "#FFA07A")
  (set-face-attribute 'rainbow-delimiters-depth-3-face   nil :foreground "#CEC87B")
  (set-face-attribute 'rainbow-delimiters-depth-4-face   nil :foreground "#4EEE94")
  (set-face-attribute 'rainbow-delimiters-depth-5-face   nil :foreground "#00FFFF")
  (set-face-attribute 'rainbow-delimiters-depth-6-face   nil :foreground "#87CEFA")
  (set-face-attribute 'rainbow-delimiters-depth-7-face   nil :foreground "#EEAEEE")
  (set-face-attribute 'rainbow-delimiters-depth-8-face   nil :foreground "#8B00FF")
  (set-face-attribute 'rainbow-delimiters-depth-9-face   nil :foreground "#EFFFEE")
  (set-face-attribute 'rainbow-delimiters-unmatched-face nil :foreground "#AA0000"))
(if (display-graphic-p)
    (eval-after-load "rainbow-delimiters" '(assemblage-rainbow-delim-set-face)))

;; source pair
(autoload 'sourcepair-load "sourcepair" "source pair for c/c++ and h" t)
(global-set-key (kbd "<f6>") 'sourcepair-load)
(defun sourcepair-settings ()
  "Settings for `sourcepair'."
  (setq sourcepair-recurse-igno '("CVS" "bin" "lib" "Obj" "Debug" "Release" ".svn"))
  ;; pair path                 
  (setq sourcepair-source-path 
        '( "./" "../../*" "./sr" "../src" ))
  (setq sourcepair-header-path -custom-include-dirs)
  ;; pair extersion            
  (setq sourcepair-source-extenons
        '( ".cpp" ".CPP" ".Cpp" ".cxx" ".CXX" ".cc"
           ".CC" ".c" ".C" ".c++" ".C++" ".cu"))
  (setq sourcepair-header-extenons
        '( ".h" ".H" ".hpp" ".H" ".Hpp"
           ".hh" ".HH" ".hxx" "XX")))
(eval-after-load "sourcepair"  
  `(sourcepair-settings))

(require 'browse-kill-ring)
(global-set-key (kbd "M-y") 'browse-kill-ring)

(autoload 'phi-rectangle "phi-rectangle.el" "phi-rectangle" t)

(require 'highlight-symbol)
(highlight-symbol-mode 1)
(setq highlight-symbol-idle-delay 0.5)
(global-set-key (kbd "<f11>")      'highlight-symbol-at-point)
(global-set-key (kbd "<C-f11>")    'highlight-symbol-next)
(global-set-key (kbd "<S-f11>")    'highlight-symbol-prev)
(global-set-key (kbd "<M-S-f11>")  'highlight-symbol-query-replace)
(global-set-key (kbd "<M-f11>")    'highlight-regexp)

(require 'ctypes)
(ctypes-auto-parse-mode 1)

(require 'undo-tree)
(global-undo-tree-mode 1)
(define-key global-map [(control z)]  'undo-tree-undo)
(define-key global-map [(control y)]  'undo-tree-redo)

(require 'cua-rect)
(defun hkb-mouse-mark-cua-rectangle (event)
  (interactive "e")
  (if (not cua--rectangle)
      (cua-mouse-set-rectangle-mark event)
    (cua-mouse-resize-rectangle event)))
(global-set-key (kbd "<s-mouse-1>") 'hkb-mouse-mark-cua-rectangle)
(define-key cua--rectangle-keymap (kbd "<s-mouse-1>") 'hkb-mouse-mark-cua-rectangle)

;; turn on save place so that when opening a file, the cursor will be at the last position.
(require 'saveplace)
(setq save-place-file (concat user-emacs-directory "saveplace.el")) ; use standard emacs dir
(setq-default save-place t)

(require 'c-toggle-dot-pointer)

(require 'highlight-indentation)
(set-face-background 'highlight-indentation-face "#061939")
;;(set-face-background 'highlight-indentation-current-column-face "blue")
(add-hook 'c-mode-common-hook      'highlight-indentation-mode)
(add-hook 'emacs-lisp-mode-hook    'highlight-indentation-mode)
(add-hook 'python-mode-hook        'highlight-indentation-mode)

(autoload 'highlight-numbers "highlight-numbers.el" nil t)

;; belong to cedet 1.1 but deleted in new version of cedet
(require 'linemark)
(global-set-key (kbd "<f2>")      'viss-bookmark-toggle)
(global-set-key (kbd "<S-f2>")    'viss-bookmark-prev-buffer)
(global-set-key (kbd "<C-f2>")    'viss-bookmark-next-buffer)
(global-set-key (kbd "<C-S-f2>")  'viss-bookmark-clear-all-buffer)

(require 'ediff)
(defmacro csetq (variable value)
  `(funcall (or (get ',variable 'custom-set)
                'set-default)
            ',variable ,value))
(csetq ediff-window-setup-function 'ediff-setup-windows-plain)
(csetq ediff-split-window-function 'split-window-horizontally)
(csetq ediff-diff-options "-w")
(defun ora-ediff-hook ()
  (ediff-setup-keymap)
  (define-key ediff-mode-map "j" 'ediff-next-difference)
  (define-key ediff-mode-map "k" 'ediff-previous-difference))
(add-hook 'ediff-mode-hook 'ora-ediff-hook)

(require 'smart-cursor-color)
(smart-cursor-color-mode 1)

(require 'popwin)
(popwin-mode 1)             

(require 'hungry-delete)
(add-hook 'emacs-lisp-mode-hook  #'(lambda () (hungry-keyboard emacs-lisp-mode-map)))

(require 'golden-ratio)

(require 'smooth-scrolling)
(smooth-scrolling-mode 1)

(provide 'init-small-packages)
