;;; init-autocomplete.el --- 
(require 'auto-complete)
(require 'auto-complete-config)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; basic settings for ac
;; (global-auto-complete-mode t)
(ac-config-default)
;; my auto-complete-settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-auto-complete-settings ()
  "Settings for `auto-complete'."
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict-lyh")
  (setq ac-cursor-color nil
        ac-inline nil
        ac-show-menu nil
        ac-menu nil
        ac-completing nil
        ac-point nil
        ac-last-point nil
        ac-prefix nil
        ac-prefix-overlay nil
        ac-selected-candidate nil
        ac-common-part nil
        ac-whole-common-part nil
        ac-triggered nil
        ac-limit nil
        ac-candidates nil
        ac-candidates-cache nil
        ac-fuzzy-enable t
        ac-dwim-enable t
        ac-compiled-sources nil
        ac-current-sources nil
        ac-current-prefix-def nil
        ac-ignoring-prefix-def nil
        ac-auto-show-menu 0.6
        ac-menu-height 9
        ;; Start auto-completion after 2 characters of a word
        ac-auto-start 2
        ac-ignore-case t
        help-xref-following nil 
        ac-quick-help-prefer-pos-tip t
        )
  (setq-default ac-expand-on-auto-complete nil)
  )
(eval-after-load "auto-complete"
  '(my-auto-complete-settings))
;; quick help settings
(setq ac-use-quick-help t)
(setq ac-quick-help-delay 1)
;; face settings
(setq ac-candidate-limit ac-menu-height)
(setq ac-candidate-max ac-candidate-menu-height)
;; (set-face-background 'ac-candidate-face "#FAEBD7")
;; (set-face-underline  'ac-candidate-face "#BEBEBE")
;; (set-face-background 'ac-selection-face "#6495ED")
;; settings for auto-complete with tags
(require 'ac-etags)
(ac-etags-setup)
;; Setup auto-complete source for etags. This command must be called at the beginning.
(ac-etags-ac-setup)
;; Setup etags auto-complete source and enable auto-complete-mode if auto-complete is not enabled.
(ac-etags-clear-cache)
;; Clear completions cache. You should clear cache if you switch project and TAGS file.

(require 'auto-complete-exuberant-ctags)
(ac-exuberant-ctags-setup)
;; In your project root directory, do follow command to make tags file.
;; ctags --verbose -R --fields="+afikKlmnsSzt"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; basic settings for ac-math
(autoload 'ac-math "ac-math" "ac-math" t)
(add-to-list 'ac-modes 'latex-mode)
;; make auto-complete aware of `latex-mode`
(defun ac-latex-mode-setup ()
  ;; add ac-sources to default ac-sources
  (setq ac-sources
        (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
                ac-sources)))
(add-hook 'TeX-mode-hook 'ac-latex-mode-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; forbid the enter up and down key
;; (define-key ac-completing-map "\r" nil)
;; (define-key ac-completing-map [up] nil)
;; (define-key ac-completing-map [down] nil)
;; (define-key ac-completing-map " " 'ac-complete)
;; Exclude very large buffers from dabbrev

;; hook AC into completion-at-point
(defun sanityinc/auto-complete-at-point ()
  (when (and (not (minibufferp))
             (fboundp 'auto-complete-mode)
             auto-complete-mode)
    #'auto-complete))
(defun sanityinc/never-indent ()
  (set (make-local-variable 'indent-line-function) (lambda () 'noindent)))

(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions
        (cons 'sanityinc/auto-complete-at-point
              (remove 'sanityinc/auto-complete-at-point completion-at-point-functions))))
(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)

(defun ac-semantic-construct-candidates (tags)
  "Construct candidates from the list inside of tags."
  (apply 'append
         (mapcar
          (lambda (tag)
            (if (listp tag)
                (let ((type (semantic-tag-type tag))
                      (class (semantic-tag-class tag))
                      (name (semantic-tag-name tag)))
                  (if (or (and (stringp type)
                               (string= type "class"))
                          (eq class 'function)
                          (eq class 'variable))
                      (list (list name type class))))))
          tags)))

(defvar ac-source-semantic-analysis nil)
(setq ac-source-semantic
      `((sigil . "b")
        (init . (lambda ()
                  (setq
                   ac-source-semantic-analysis
                   (condition-case nil
                       (ac-semantic-construct-candidates
                        (semantic-fetch-tags))))))
        (candidates . (lambda ()
                        (if ac-source-semantic-analysis
                            (all-completions
                             ac-target
                             (mapcar 'car ac-source-semantic-analysis)))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun ac-settings-4-cc ()
  "`auto-complete' settings for `cc-mode'."
  (dolist (command `(c-electric-backspace
                     c-electric-backspace-kill))
    (add-to-list 'ac-trigger-commands-on-completing command)))
(eval-after-load "cc-mode"
  '(ac-settings-4-cc))

(defun ac-settings-4-autopair ()
  "`auto-complete' settings for `autopair'."
  (defun ac-trigger-command-p (command)
    "Return non-nil if `this-command' is a trigger command."
    (or
     (and
      (symbolp command)
      (or (memq command ac-trigger-commands)
          (string-match "self-insert-command" (symbol-name command))
          (string-match "electric" (symbol-name command))
          (let* ((autopair-emulation-alist nil)
                 (key (this-single-command-keys))
                 (beyond-autopair (or (key-binding key)
                                      (and (setq key (lookup-key local-function-key-map key))
                                           (key-binding key)))))
            (or
             (memq beyond-autopair ac-trigger-commands)
             (and ac-completing
                  (memq beyond-autopair ac-trigger-commands-on-completing)))))))))
(eval-after-load "autopair"
  '(ac-settings-4-autopair))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://auto-complete.org/doc/manual.html#builtin-sources
(set-default 'ac-sources
             '(ac-source-words-in-buffer
               ac-source-words-in-same-mode-buffers
               ac-source-dictionary
               ac-source-yasnippet
               ac-source-gtags
               ac-source-etags
               ac-source-semantic
               ;; ac-source-semantic-raw
               ;; a good ac source but too slow
               ac-source-features
               ac-source-imenu
               ac-source-abbrev
               ac-source-words-in-all-buffer
               ac-source-files-in-current-dir
               ac-source-filename))
(add-to-list 'ac-omni-completion-sources
             (cons "\\." '(ac-source-semantic)))
(add-to-list 'ac-omni-completion-sources
             (cons "->" '(ac-source-semantic)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; major mode for auto-complete

(dolist (mode '(matlab-mode
                c-mode cc-mode c++-mode cmake-mode
                qt-pro-mode
                org-mode idlwave-mode
                latex-mode plain-tex-mode
                log-edit-mode  text-mode
                sass-mode
                html-mode nxml-mode sh-mode smarty-mode
                lisp-mode emacs-lisp-mode scheme-mode
                textile-mode markdown-mode
                sql-mode
                rspec-mode python-mode
                objc-mode
                js-mode clojure-mode))
  (add-to-list 'ac-modes mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun my-gud-ac-not-use-enter()
;;    (define-key ac-completing-map "\r" nil))
;; (add-hook 'gud-mode-hook 'my-gud-ac-not-use-enter)

(provide 'init-autocomplete)
