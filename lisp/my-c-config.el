;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ChenBin`s c-mode settings
(defun c-wx-lineup-topmost-intro-cont (langelem)
  (save-excursion
    (beginning-of-line)
    (if (re-search-forward "EVT_" (line-end-position) t)
      'c-basic-offset
      (c-lineup-topmost-intro-cont langelem))))

;; avoid default "gnu" style, use more popular one
(setq c-default-style "linux")

(defun fix-c-indent-offset-according-to-syntax-context (key val)
  ;; remove the old element
  (setq c-offsets-alist (delq (assoc key c-offsets-alist) c-offsets-alist))
  ;; new value
  (add-to-list 'c-offsets-alist '(key . val)))

(defun my-common-cc-mode-setup ()
  "setup shared by all languages (java/groovy/c++ ...)"
  (setq c-basic-offset 4)
  ;; give me NO newline automatically after electric expressions are entered
  (setq c-auto-newline nil)

  ;; syntax-highlight aggressively
  ;; (setq font-lock-support-mode 'lazy-lock-mode)
  (setq lazy-lock-defer-contextually t)
  (setq lazy-lock-defer-time 0)

  ;make DEL take all previous whitespace with it
  (c-toggle-hungry-state 1)

  ;; indent
  ;; google "C/C++/Java code indentation in Emacs" for more advanced skills
  ;; C code:
  ;;   if(1) // press ENTER here, zero means no indentation
  (fix-c-indent-offset-according-to-syntax-context 'substatement 0)
  ;;   void fn() // press ENTER here, zero means no indentation
  (fix-c-indent-offset-according-to-syntax-context 'func-decl-cont 0))

(defun my-c-mode-setup ()
  "C/C++ only setup"
  (message "my-c-mode-setup called (buffer-file-name)=%s" (buffer-file-name))
  ;; @see http://stackoverflow.com/questions/3509919/ \
  ;; emacs-c-opening-corresponding-header-file
  (local-set-key (kbd "C-x C-o") 'ff-find-other-file)

  (setq cc-search-directories '("." "/usr/include" "/usr/local/include/*" "../*/include" "$WXWIN/include"))

  ;; wxWidgets setup
  (c-set-offset 'topmost-intro-cont 'c-wx-lineup-topmost-intro-cont)

  ;; make a #define be left-aligned
  (setq c-electric-pound-behavior (quote (alignleft)))

  (when buffer-file-name

    ;; @see https://github.com/redguardtoo/cpputils-cmake
    ;; Make sure your project use cmake!
    ;; Or else, you need comment out below code:
    ;; {{
    (flymake-mode 1)
    (if (executable-find "cmake")
        (if (not (or (string-match "^/usr/local/include/.*" buffer-file-name)
                     (string-match "^/usr/src/linux/include/.*" buffer-file-name)))
            (cppcm-reload-all)))
    ;; }}

    ))

;; donot use c-mode-common-hook or cc-mode-hook because many major-modes use this hook
(defun c-mode-common-hook-setup ()
  (unless (is-buffer-file-temp)
    (my-common-cc-mode-setup)
    (unless (or (derived-mode-p 'java-mode) (derived-mode-p 'groovy-mode))
      (my-c-mode-setup))

    ;; gtags (GNU global) stuff
    (when (and (executable-find "global")
               ;; `man global' to figure out why
               (not (string-match-p "GTAGS not found"
                                    (shell-command-to-string "global -p"))))
      ;; emacs 24.4+ will set up eldoc automatically.
      ;; so below code is NOT needed.
      (eldoc-mode 1))
    ))
(add-hook 'c-mode-common-hook 'c-mode-common-hook-setup)
;; ChenBin`s c-mode setting ends here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




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
;; c style settings ends here

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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;my highlight words
(defun my-c-mode-highlight ()
  ;;Basic
  (font-lock-add-keywords
   nil
   '(("\\(++\\|-+\\|<<+\\|>>+\\|==+\\)" 
      1 font-lock-variable-name-face prepend)))
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
      1 font-lock-variable-name-face prepend)))
  (font-lock-add-keywords
   nil 
   '(("\\(ProcessId+\\|dev_+\\)" 
      1 font-lock-variable-name-face prepend)))
  (font-lock-add-keywords
   nil 
   '(("\\(__syncthreads()+\\|cudaDeviceSynchronize()+\\)" 
      1 font-lock-builtin-face prepend)))
  ;;MPI & OPENMP 
  (font-lock-add-keywords
   nil 
   '(("\\(mpiProcessId+\\|mpiAofProcess+\\|MPI_+\\|ompThreadId+\\|ompAofThread+\\|cudaAofGPU+\\)" 
      1 font-lock-variable-name-face prepend))))
(add-hook 'c-mode-common-hook 'my-c-mode-highlight)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun c-includes-settings ()
  "Settings for `c-includes'."
  (setq c-includes-binding t)
  (setq c-includes-path my-sys-c-include))
(eval-after-load "c-includes"
  `(c-includes-settings))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; input "inc " then do a lot
;; (mapc (lambda (mode)
;;         (define-abbrev-table mode '(("inc" "" skeleton-include 1))))
;;       '(c-mode-abbrev-table c++-mode-abbrev-table))
;; (define-skeleton skeleton-include
;;   "generate include<>" ""
;;   > "#include <"
;;   (completing-read
;;    "Include File:"
;;    (mapcar #'(lambda (f) 
;;                (list f )) 
;;            (apply 'append
;;                   (mapcar
;;                    #'(lambda (dir)
;;                        (directory-files dir))
;;                    my-sys-c-include))))">")

;; 输入 inc , 可以自动提示输入文件名称,可以自动补全.
;; Provided by yangyingchao@gmail.com
(mapc
 (lambda (mode)
   (define-abbrev-table mode '(
                               ("inc" "" skeleton-include 1)
                               )))
 '(c-mode-abbrev-table c++-mode-abbrev-table))
(defvar inc-minibuffer-compl-list nil "nil")

(defun yc/update-minibuffer-complete-table ( )
  "Complete minibuffer"
  (interactive)
  (let ((prompt (minibuffer-prompt))
        (comp-part (minibuffer-contents-no-properties)))
    (when (and (string= "Include File:" prompt)
               (> (length comp-part) 0))
      (setq minibuffer-completion-table
            (append minibuffer-completion-table
                    (let ((inc-files nil)
                          (dirname nil)
                          (tmp-name nil))
                      (mapc
                       (lambda (d)
                         (setq dirname (format "%s/%s" d comp-part))
                         (when (file-exists-p dirname)
                           (mapc
                            (lambda (x)
                              (when (not (or (string= "." x)
                                             (string= ".." x)))
                                (setq tmp-name (format "%s/%s" comp-part x))
                                (add-to-list 'inc-files tmp-name)))
                            (directory-files dirname))))
                       my-sys-c-include)
                      inc-files)))))
  (insert "/"))

(let ((map minibuffer-local-completion-map))
  (define-key map "/" 'yc/update-minibuffer-complete-table))

(defun yc/update-inc-marks ( )
  "description"
  (let ((statement (buffer-substring-no-properties
                    (point-at-bol) (point-at-eol)))
        (inc-file nil)
        (to-begin nil)
        (to-end nil)
        (yc/re-include
         (rx "#include" (+ ascii) "|file|" (group (+ ascii)) "|file|")))
    (when (string-match yc/re-include statement)
      (setq inc-file (match-string 1 statement))
      (if (file-exists-p (format "./%s" inc-file))
          (setq to-begin "\"" to-end "\"")
        (setq to-begin "<" to-end ">")
        )
      (move-beginning-of-line 1)
      (kill-line)
      (insert (format "#include %s%s%s" to-begin inc-file to-end))
      (move-end-of-line 1))))

(define-skeleton skeleton-include
  "generate include<>" ""
  > "#include |file|"
  (completing-read
   "Include File:"
   (mapcar
    (lambda (f) (list f ))
    (apply
     'append
     (mapcar
      (lambda (dir)
        (directory-files
         dir nil
         "\\(\\.h\\)?"))
      my-sys-c-include))))
  "|file|"
  (yc/update-inc-marks))











(provide 'my-c-config)
