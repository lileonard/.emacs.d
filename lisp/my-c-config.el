;; style settings
;; avoid default "gnu" style, use more popular one
(setq c-default-style "linux")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; google-c-style settings
;; I made a change on c-basic-offset c-comment-only-line-offset
(eval-when-compile (require 'cc-defs))
(defun google-c-lineup-expression-plus-4 (langelem)
  "Indents to the beginning of the current C expression plus 4 spaces.
This implements title \"Function Declarations and Definitions\"
of the Google C++ Style Guide for the case where the previous
line ends with an open parenthese.
\"Current C expression\", as per the Google Style Guide and as
clarified by subsequent discussions, means the whole expression
regardless of the number of nested parentheses, but excluding
non-expression material such as \"if(\" and \"for(\" control
structures.
Suitable for inclusion in `c-offsets-alist'."
  (save-excursion
    (back-to-indentation)
    ;; Go to beginning of *previous* line:
    (c-backward-syntactic-ws)
    (back-to-indentation)
    (cond
     ;; We are making a reasonable assumption that if there is a control
     ;; structure to indent past, it has to be at the beginning of the line.
     ((looking-at "\\(\\(if\\|for\\|while\\)\\s *(\\)")
      (goto-char (match-end 1)))
     ;; For constructor initializer lists, the reference point for line-up is
     ;; the token after the initial colon.
     ((looking-at ":\\s *")
      (goto-char (match-end 0))))
    (vector (+ 2 (current-column)))))

;;;###autoload
(defcustom google-c-style
  `((c-recognize-knr-p . nil)
    (c-enable-xemacs-performance-kludge-p . t) ; speed up indentation in XEmacs
    (c-basic-offset . 4)
    (indent-tabs-mode . nil)
    (c-comment-only-line-offset . 2)
    (c-hanging-braces-alist . ((defun-open after)
                               (defun-close before after)
                               (class-open after)
                               (class-close before after)
                               (inexpr-class-open after)
                               (inexpr-class-close before)
                               (namespace-open after)
                               (inline-open after)
                               (inline-close before after)
                               (block-open after)
                               (block-close . c-snug-do-while)
                               (extern-lang-open after)
                               (extern-lang-close after)
                               (statement-case-open after)
                               (substatement-open after)))
    (c-hanging-colons-alist . ((case-label)
                               (label after)
                               (access-label after)
                               (member-init-intro before)
                               (inher-intro)))
    (c-hanging-semi&comma-criteria
     . (c-semi&comma-no-newlines-for-oneline-inliners
        c-semi&comma-inside-parenlist
        c-semi&comma-no-newlines-before-nonblanks))
    (c-indent-comments-syntactically-p . t)
    (comment-column . 40)
    (c-indent-comment-alist . ((other . (space . 2))))
    (c-cleanup-list . (brace-else-brace
                       brace-elseif-brace
                       brace-catch-brace
                       empty-defun-braces
                       defun-close-semi
                       list-close-comma
                       scope-operator))
    (c-offsets-alist . ((arglist-intro google-c-lineup-expression-plus-4)
                        (func-decl-cont . ++)
                        (member-init-intro . ++)
                        (inher-intro . ++)
                        (comment-intro . 0)
                        (arglist-close . c-lineup-arglist)
                        (topmost-intro . 0)
                        (block-open . 0)
                        (inline-open . 0)
                        (substatement-open . 0)
                        (statement-cont
                         .
                         (,(when (fboundp 'c-no-indent-after-java-annotations)
                             'c-no-indent-after-java-annotations)
                          ,(when (fboundp 'c-lineup-assignments)
                             'c-lineup-assignments)
                          ++))
                        (label . /)
                        (case-label . +)
                        (statement-case-open . +)
                        (statement-case-intro . +) ; case w/o {
                        (access-label . /)
                        (innamespace . 0))))
  "Google C/C++ Programming Style.")

;;;###autoload
(defun google-set-c-style ()
  "Set the current buffer's c-style to Google C/C++ Programming
  Style. Meant to be added to `c-mode-common-hook'."
  (interactive)
  (make-local-variable 'c-tab-always-indent)
  (setq c-tab-always-indent t)
  (c-add-style "Google" google-c-style t))

;;;###autoload
(defun google-make-newline-indent ()
  "Sets up preferred newline behavior. Not set by default. Meant
  to be added to `c-mode-common-hook'."
  (interactive)
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  (define-key c-mode-base-map [ret] 'newline-and-indent))

(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my-google-c-style settings ends here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'cc-mode "cc-mode" "cc-mode" t)
;; basic seetings
(setq c-macro-shrink-window-flag t
      c-macro-preprocessor "cpp"
      c-macro-cppflags " "
      c-macro-prompt-flag t
      abbrev-mode t)


(defun c-includes-settings ()
  "Settings for `c-includes'."
  (setq c-includes-binding t)
  (setq c-includes-path my-sys-c-include))
(eval-after-load "c-includes"
  `(c-includes-settings))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; input "inc " then do a lot
(mapc (lambda (mode)
        (define-abbrev-table mode '(("inc" "" skeleton-include 1))))
      '(c-mode-abbrev-table c++-mode-abbrev-table))
(define-skeleton skeleton-include
  "generate include<>" ""
  > "#include <"
  (completing-read
   "Include File:"
   (mapcar #'(lambda (f) 
               (list f )) 
           (apply 'append
                  (mapcar
                   #'(lambda (dir)
                       (directory-files dir))
                   my-sys-c-include))))">")
;; Customizations for all modes in CC Mode through
;; google-c-style is good I still need something for my own
(defconst my-c-style
  '((c-tab-always-indent        . t)
    (c-hanging-braces-alist     . ((substatement-open after)
                                   (brace-list-open)))
    (c-hanging-colons-alist
     . ((member-init-intro before)
        (inher-intro)
        (case-label after)
        (label after)
        (access-label after)))
    (c-cleanup-list
     . (scope-operator
        empty-defun-braces
        defun-close-semi))
    (c-offsets-alist
     . ((arglist-close . c-lineup-arglist)
        (substatement-open . 0)
        (case-label        . 4)
        (block-open        . 0)
        (knr-argdecl-intro . -)))
    (c-echo-syntactic-information-p . t)
    )
  "My C Programming Style")
;; offset customizations not in my-c-style
(setq c-offsets-alist '((member-init-intro . ++)))
;; c style settings ends here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Alt+-Note selested words(if selected) or current line(if unselected)
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and we are not at the end of the line,
then comment current line.
Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'qiang-comment-dwim-line)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; When you have a long method name with long arguments, you would like to lay it out as follows:
;;   public void veryLongMethodNameHereWithArgs(
;;           String arg1,
;;           String arg2,
;;           int arg3)
(defconst my-c-lineup-maximum-indent 33)
(defun my-c-lineup-arglist (langelem)
  (let ((ret (c-lineup-arglist langelem)))
    (if (< (elt ret 0) my-c-lineup-maximum-indent)
        ret
      (save-excursion
        (goto-char (cdr langelem))
        (vector (+ (current-column) 8))))))

(defun my-indent-setup ()
  (setcdr (assoc 'arglist-cont-nonempty c-offsets-alist)
          '(c-lineup-gcc-asm-reg my-c-lineup-arglist)))

(defun c-wx-lineup-topmost-intro-cont (langelem)
  (save-excursion
    (beginning-of-line)
    (if (re-search-forward "EVT_" (line-end-position) t)
        'c-basic-offset
      (c-lineup-topmost-intro-cont langelem))))

(defun fix-c-indent-offset-according-to-syntax-context (key val)
  ;; remove the old element
  (setq c-offsets-alist (delq (assoc key c-offsets-alist) c-offsets-alist))
  ;; new value
  (add-to-list 'c-offsets-alist '(key . val)))

(defun my-common-cc-mode-setup ()
  "setup shared by all languages (java/groovy/c++ ...)
@see http://xugx2007.blogspot.com.au/2007/06/benjamin-rutts-emacs-c-development-tips.html"
  (setq compilation-window-height 8)
  (setq lazy-lock-defer-contextually t)
  (setq lazy-lock-defer-time 0)
  (setq global-cwarn-mode 1)
  ;; indent
  (fix-c-indent-offset-according-to-syntax-context 'substatement 0)
  (fix-c-indent-offset-according-to-syntax-context 'func-decl-cont 0))
(defun my-c-mode-setup ()
  "C/C++ only setup"
  (message "my-c-mode-setup called (buffer-file-name)=%s" (buffer-file-name))
  (setq cc-search-directories 
        '(my-sys-c-include        
          (lambda ()
            (if (derived-mode-p 'c-mode 'c++-mode)
                (cppcm-reload-all))))))

(defun my-c-mode-common-hook ()
  ;; add my personal style and set it for the current buffer
  (c-add-style "PERSONAL" my-c-style t)
  ;; other customizations
  (setq tab-width 4
        ;; this will make sure spaces are used instead of tabs
        indent-tabs-mode nil)
  (my-common-cc-mode-setup)
  (my-c-mode-setup)
  ;; we like auto-newline and hungry-delete
  (c-toggle-auto-hungry-state 1))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(defun c/c++-hightligh-included-files ()
  (interactive)
  (when (or (eq major-mode 'c-mode)
            (eq major-mode 'c++-mode))
    (save-excursion
      (goto-char (point-min))
      ;; remove all overlay first
      (mapc (lambda (ov) (if (overlay-get ov 'c/c++-hightligh-included-files)
                             (delete-overlay ov)))
            (overlays-in (point-min) (point-max)))
      (while (re-search-forward "^#include[ \t]+[\"<]\\(.*\\)[\">]" nil t nil)
        (let* ((begin  (match-beginning 1))
               (end (match-end 1))
               (ov (make-overlay begin end)))
          (overlay-put ov 'c/c++-hightligh-included-files t)
          (overlay-put ov 'keymap c/c++-hightligh-included-files-key-map)
          (overlay-put ov 'face 'underline))))))
(add-hook 'c-mode-common-hook 'c/c++-hightligh-included-files)
;; press enter to jump to pointed .h file
(defvar c/c++-hightligh-included-files-key-map nil)
(if c/c++-hightligh-included-files-key-map nil
  (setq c/c++-hightligh-included-files-key-map (make-sparse-keymap))
  (define-key c/c++-hightligh-included-files-key-map (kbd "<RET>") 'find-file-at-point))
(setq c/c++-hightligh-included-files-timer (run-with-idle-timer 4 t 'c/c++-hightligh-included-files))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;my highlight words
(defun my-c-mode-highlight ()
  ;;Basic
  (font-lock-add-keywords
   nil
   '(("\\(++\\|-+\\|<<+\\|>>+\\|==+\\)" 
      1 font-lock-warning-face prepend)))
  (font-lock-add-keywords
   nil 
   '(("\\(&&+\\|||+\\|RAM_+\\|fftw_+\\)" 
      1 font-lock-keyword-face prepend)))
  ;;Cuda
  (font-lock-add-keywords
   nil 
   '(("\\(cudaMalloc+\\|cudaMemcpy+\\|cudaFree+\\|cudaHostAlloc+\\|malloc+\\|free+\\)" 
      1 font-lock-keyword-face prepend)))
  (font-lock-add-keywords
   nil 
   '(("\\(__global__+\\|__host__+\\|__device__+\\|__noinline__+\\|__forceinline__+\\)" 
      1 font-lock-keyword-face prepend)))
  (font-lock-add-keywords
   nil 
   '(("\\(__shared__+\\|__constant__+\\|__restrict__+\\)" 
      1 font-lock-keyword-face prepend)))
  (font-lock-add-keywords
   nil 
   '(("\\(gridDim+\\|blockDim+\\|blockIdx+\\|threadIdx+\\|warpSize+\\)" 
      1 font-lock-warning-face prepend)))
  (font-lock-add-keywords
   nil 
   '(("\\(ProcessId+\\|dev_+\\)" 
      1 font-lock-warning-face prepend)))
  (font-lock-add-keywords
   nil 
   '(("\\(__syncthreads()+\\|cudaDeviceSynchronize()+\\)" 
      1 font-lock-builtin-face prepend)))
  ;;MPI & OPENMP 
  (font-lock-add-keywords
   nil 
   '(("\\(mpiProcessId+\\|mpiAofProcess+\\|MPI_+\\|ompThreadId+\\|ompAofThread+\\|cudaAofGPU+\\)" 
      1 font-lock-warning-face prepend))))
(add-hook 'c-mode-common-hook 'my-c-mode-highlight)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'my-c-config)
