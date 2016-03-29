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
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'rainbow-delimiters)
(add-hook 'c-mode-common-hook      #'rainbow-delimiters-mode)
(add-hook 'cmake-mode-hook         #'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook          #'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook    #'rainbow-delimiters-mode)
(add-hook 'python-mode-hook        #'rainbow-delimiters-mode)
(set-face-attribute
 'rainbow-delimiters-depth-1-face nil
 :foreground "#CD661D")
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
(add-hook 'c-mode-common-hook 'ws-butler-mode)
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
(require 'highlight-indentation)
(defun adjust-highlight-indentation-mode-face()
  "interactive"
  (let* ((color  (x-color-values (face-attribute 'default :background))))
    (if (null color)
        (error "not support.")
      (let ((my-color (mapcar
                       (lambda (x)
                         (let ((y (/ #XFFFF 4))
                               ;; delta is the color adjust parament
                               (delta #X0630))
                           (cond ((< x (* y 1))
                                  (+ x delta))
                                 ((< x (* y 2))
                                  (+ x delta))
                                 ((< x (* y 3))
                                  (- x delta))
                                 (t
                                  (- x delta))))) color)))
        (set-face-attribute
         'highlight-indentation-face nil
         :background
         (concat "#"
                 (mapconcat
                  (lambda (c) (format "%04X" c))
                  my-color
                  "")))))))
(adjust-highlight-indentation-mode-face)

;;( "#061939")
;;(set-face-background 'highlight-indentation-current-column-face "blue")
(add-hook 'c-mode-common-hook      'highlight-indentation-mode)
(add-hook 'emacs-lisp-mode-hook    'highlight-indentation-mode)
(add-hook 'python-mode-hook        'highlight-indentation-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'highlight-numbers "highlight-numbers.el" nil t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; belong to cedet 1.1 but deleted in new version of cedet
(require 'linemark)
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
(require 'golden-ratio)
(add-to-list 'golden-ratio-exclude-modes "ediff-mode")
(add-to-list 'golden-ratio-exclude-modes "helm-mode")
(add-to-list 'golden-ratio-exclude-modes "dired-mode")
(add-to-list 'golden-ratio-inhibit-functions 'pl/helm-alive-p)
(defun pl/helm-alive-p ()
  (if (boundp 'helm-alive-p)
      (symbol-value 'helm-alive-p)))
;; do not enable golden-raio in thses modes
(setq golden-ratio-exclude-modes '("ediff-mode"
                                   "gud-mode"
                                   "gdb-locals-mode"
                                   "gdb-registers-mode"
                                   "gdb-breakpoints-mode"
                                   "gdb-threads-mode"
                                   "gdb-frames-mode"
                                   "gdb-inferior-io-mode"
                                   "gud-mode"
                                   "gdb-inferior-io-mode"
                                   "gdb-disassembly-mode"
                                   "gdb-memory-mode"
                                   "magit-log-mode"
                                   "magit-reflog-mode"
                                   "magit-status-mode"
                                   "IELM"
                                   "eshell-mode" "dired-mode"))
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
(global-set-key (kbd "<s-left>") 'windmove-left)
(global-set-key (kbd "<s-right>") 'windmove-right)
(global-set-key (kbd "<s-up>") 'windmove-up)
(global-set-key (kbd "<s-down>") 'windmove-down)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 
(provide 'init-small-packages)
