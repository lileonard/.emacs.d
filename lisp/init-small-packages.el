;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'highlight-parentheses)
(global-highlight-parentheses-mode t)
(setq hl-paren-colors '("skyblue"
                        "IndianRed1"
                        "IndianRed3"
                        "IndianRed4")
      hl-paren-delay 0.3)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; indent-guide, a good but worse in performance plugin,
;; especially when you open a file that includes very large, deep blocks
;; (require 'indent-guide)
;; (add-hook 'c++-mode-hook           #'indent-guide-mode)
;; (add-hook 'c-mode-hook             #'indent-guide-mode)
;; (add-hook 'cmake-mode-hook         #'indent-guide-mode)
;; (add-hook 'lisp-mode-hook          #'indent-guide-mode)
;; (add-hook 'emacs-lisp-mode-hook    #'indent-guide-mode)
;; (add-hook 'python-mode-hook        #'indent-guide-mode)
;; (add-hook 'matlab-mode-hook        #'indent-guide-mode)
;; (setq indent-guide-delay 0.0)
;; (setq indent-guide-char "|")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'fuzzy)
(require 'pos-tip)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'smex)   
(smex-initialize) 
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'goto-last-change "goto-last-change" nil t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'rainbow-delimiters)
(add-hook 'c++-mode-hook           #'rainbow-delimiters-mode)
(add-hook 'c-mode-hook             #'rainbow-delimiters-mode)
(add-hook 'cmake-mode-hook         #'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook          #'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook    #'rainbow-delimiters-mode)
(add-hook 'python-mode-hook        #'rainbow-delimiters-mode)
(add-hook 'matlab-mode-hook        #'rainbow-delimiters-mode)
(set-face-attribute
 'rainbow-delimiters-depth-1-face nil
 :foreground "#CD661D")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'popup)
;; add some shotcuts in popup menu mode
(define-key popup-menu-keymap (kbd "TAB") 'popup-next)
(define-key popup-menu-keymap (kbd "<tab>") 'popup-next)
(define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
(define-key popup-menu-keymap "\r" nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;ource pair
(autoload 'sourcepair-load "sourcepair.el" "source pair for c/c++ and h" t)
(global-set-key (kbd "<f6>") 'sourcepair-load)
(defun sourcepair-settings ()
  "Settings for `sourcepair'."
  (setq sourcepair-recurse-igno '("CVS" "bin" "lib" "Obj" "Debug" "Release" ".svn"))
  ;; pair path                 
  (setq sourcepair-source-path 
        '( "./" "../../*" "./sr" "../src" ))
  (setq sourcepair-header-path my-custom-include-dirs)
  ;; pair extersion            
  (setq sourcepair-source-efxtenons
        '( ".cpp" ".CPP" ".Cpp" ".cxx" ".CXX" ".cc"
           ".CC" ".c" ".C" ".c++" ".C++" ".cu"))
  (setq sourcepair-header-extenons
        '( ".h" ".H" ".hpp" ".H" ".Hpp"
           ".hh" ".HH" ".hxx" "XX")))
(eval-after-load "sourcepair"  
  `(sourcepair-settings))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package: ws-butler
(require 'ws-butler)
(add-hook 'c-mode-hook    'ws-butler-mode)
(add-hook 'c++-mode-hook  'ws-butler-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'phi-rectangle "phi-rectangle.el" "phi-rectangle" t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'highlight-symbol)
(highlight-symbol-mode 1)
(setq highlight-symbol-idle-delay 0.5)
(global-set-key (kbd "<f11>")      'highlight-symbol-at-point)
(global-set-key (kbd "<C-f11>")    'highlight-symbol-next)
(global-set-key (kbd "<S-f11>")    'highlight-symbol-prev)
(global-set-key (kbd "<M-S-f11>")  'highlight-symbol-query-replace)
(global-set-key (kbd "<M-f11>")    'highlight-regexp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ctypes)
(ctypes-auto-parse-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'undo-tree)
(global-undo-tree-mode 1)
(define-key global-map [(control z)]  'undo-tree-undo)
(define-key global-map [(control y)]  'undo-tree-redo)
;; mode-line setting
(custom-set-variables
 '(undo-tree-mode-lighter "Undo"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cua-rect)
(defun hkb-mouse-mark-cua-rectangle (event)
  (interactive "e")
  (if (not cua--rectangle)
      (cua-mouse-set-rectangle-mark event)
    (cua-mouse-resize-rectangle event)))
(global-set-key (kbd "<s-mouse-1>") 'hkb-mouse-mark-cua-rectangle)
(define-key cua--rectangle-keymap (kbd "<s-mouse-1>") 'hkb-mouse-mark-cua-rectangle)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; turn on save place so that when opening a file, the cursor will be at the last position.
(require 'saveplace)
(setq save-place-file (concat user-emacs-directory "saveplace.el")) ; use standard emacs dir
(setq-default save-place t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'c-toggle-dot-pointer)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'beacon)
(beacon-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'highlight-numbers)
(add-hook 'c-mode-hook           'highlight-numbers-mode)
(add-hook 'c++-mode-hook         'highlight-numbers-mode)
(add-hook 'emacs-lisp-mode-hook  'highlight-numbers-mode)
(add-hook 'python-mode-hook      'highlight-numbers-mode)
(add-hook 'matlab-mode-hook      'highlight-numbers-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; belong to cedet 1.1 but deleted in new version of cedet
(require 'linemark)
(cond ((eq (frame-parameter nil 'background-mode) 'light)
       (set-face-attribute
        'linemark-funny-face nil
        :background "#9AFF9A"
        ;; :foreground "#585858"
        ))
      ((eq (frame-parameter nil 'background-mode) 'dark)
       (set-face-attribute
        'linemark-funny-face nil
        :background "#555555"
        ;; :foreground "#585858"
        )))
(global-set-key (kbd "<f2>")      'viss-bookmark-toggle)
(global-set-key (kbd "<S-f2>")    'viss-bookmark-prev-buffer)
(global-set-key (kbd "<C-f2>")    'viss-bookmark-next-buffer)
(global-set-key (kbd "<C-S-f2>")  'viss-bookmark-clear-all-buffer)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'popwin)
(popwin-mode 1)             
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'hungry-delete)
(add-hook 'emacs-lisp-mode-hook  #'(lambda () (hungry-keyboard emacs-lisp-mode-map)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'diff)
;; show whitespace in diff-mode
(add-hook 'diff-mode-hook (lambda ()
                            (setq-local whitespace-style
                                        '(face
                                          tabs
                                          tab-mark
                                          spaces
                                          space-mark
                                          trailing
                                          indentation::space
                                          indentation::tab
                                          newline
                                          newline-mark))
                            (whitespace-mode 1)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cursor settings
(require 'cursor-chg)
(change-cursor-mode 1)
(cond ((eq (frame-parameter nil 'background-mode) 'light)
       (setq curchg-default-cursor-color "#333333"))
       ((eq (frame-parameter nil 'background-mode) 'dark)
        (setq curchg-default-cursor-color "#BBBBBB")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ibuffer)
(global-set-key (kbd "<C-S-iso-lefttab>") 'ibuffer)
(require 'ibuffer-vc)
(add-hook 'ibuffer-hook
          (lambda ()
            (ibuffer-vc-set-filter-groups-by-vc-root)
            (unless (eq ibuffer-sorting-mode 'alphabetic)
              (ibuffer-do-sort-by-alphabetic))))
(global-set-key (kbd "C-x C-b") 'ibuffer)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'buff-menu+)
(require 'buffer-move)
(global-set-key (kbd "<s-left>")   'windmove-left)
(global-set-key (kbd "<s-right>")  'windmove-right)
(global-set-key (kbd "<s-up>")     'windmove-up)
(global-set-key (kbd "<s-down>")   'windmove-down)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'swiper)
(setq ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'pager-page-up       "pager.el" "pager" t)
(autoload 'pager-page-down     "pager.el" "pager" t)
(global-set-key [prior] 'pager-page-up)
(global-set-key [next]  'pager-page-down)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'electric-operator)
(add-hook 'c++-mode-hook           #'electric-operator-mode)
(add-hook 'c-mode-hook             #'electric-operator-mode)
(add-hook 'emacs-lisp-mode-hook    #'electric-operator-mode)
(add-hook 'python-mode-hook        #'electric-operator-mode)
(add-hook 'matlab-mode-hook        #'electric-operator-mode)
(electric-operator-add-rules-for-mode 'c++-mode
                                      (cons "*" nil)
                                      (cons "**" nil)
                                      (cons "/" nil)
                                      (cons "+1" "+1")
                                      (cons "-1" "-1")
                                      (cons "+2" "+2")
                                      (cons "-2" "-2")
                                      (cons "+i" "+i")
                                      (cons "-i" "-i")
                                      (cons "<<" "<< ")
                                      (cons ">>" " >>"))
(electric-operator-add-rules-for-mode 'c-mode
                                      (cons "*" nil)
                                      (cons "**" nil)
                                      (cons "+1" "+1")
                                      (cons "-1" "-1")
                                      (cons "+2" "+2")
                                      (cons "-2" "-2")
                                      (cons "+i" "+i")
                                      (cons "-i" "-i"))

(electric-operator-add-rules-for-mode 'emacs-lisp-mode
                                      (cons "-" nil))

(electric-operator-add-rules-for-mode 'matlab-mode
                                      (cons "+" " + ")
                                      (cons "-" " - ")
                                      (cons "=" " = ")
                                      (cons "==" "==")
                                      (cons "+1" "+1")
                                      (cons "-1" "-1")
                                      (cons "+2" "+2")
                                      (cons "-2" "-2")
                                      (cons "+i" "+i")
                                      (cons "-i" "-i"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'qt-pro-mode "qt-pro-mode.el" "qt-pro-mode" t)
;;(require 'qt-pro-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; end provide
(provide 'init-small-packages)

