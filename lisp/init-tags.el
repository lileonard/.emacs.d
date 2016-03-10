(add-to-list 'load-path
             (expand-file-name
              "~/.emacs.d/site-lisp/tags"))

(require 'ctags)
;; Alternatively, you can install it using the Marmalade ELPA repository.
;; Don't ask before rereading the TAGS files if they have changed
(setq tags-revert-without-query t)
;; Do case-sensitive tag searches
(setq tags-case-fold-search nil) ;; t=case-insensitive, nil=case-sensitive
;; Don't warn when TAGS files are large
(setq large-file-warning-threshold nil)
;; {{ etags-select
(autoload 'etags-select-find-tag-at-point "etags-select" "" t nil)
(autoload 'etags-select-find-tag "etags-select" "" t nil)
;; }}
(global-set-key (kbd "<f7>") 'ctags-create-or-update-tags-table)
(global-set-key (kbd "<f8>") 'visit-tags-table)
;; Then just press <f7> to update or create your TAGS file. That function look
;; for a file TAGS in the current and its parent directories, if a TAG file is
;; not found it ask you where create a new one.
(global-set-key (kbd "M-s")  'ctags-search)
;; https://github.com/leoliu/ggtags
(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

(defun gtags-ext-produce-tags-if-needed (dir)
  (if (not (= 0 (call-process "global" nil nil nil " -p"))) ; tagfile doesn't exist?
      (let ((default-directory dir))
        (shell-command "gtags && echo 'created tagfile'"))
    ;;  tagfile already exists; update it
    (shell-command "global -u && echo 'updated tagfile'")))

;; @see http://emacs-fu.blogspot.com.au/2008/01/navigating-through-source-code-using.html
(defun gtags-ext-create-or-update ()
  "create or update the gnu global tag file"
  (interactive)
  (gtags-ext-produce-tags-if-needed (read-directory-name
                                     "gtags: top of source tree:" default-directory)))

(defun gtags-ext-add-gtagslibpath (libdir &optional del)
  "add external library directory to environment variable GTAGSLIBPATH.\ngtags will can that directory if needed.\nC-u M-x add-gtagslibpath will remove the directory from GTAGSLIBPATH."
  (interactive "DDirectory containing GTAGS:\nP")
  (let (sl)
    (if (not (file-exists-p (concat (file-name-as-directory libdir) "GTAGS")))
        ;; create tags
        (let ((default-directory libdir))
          (shell-command "gtags && echo 'created tagfile'")))

    (setq libdir (directory-file-name libdir)) ;remove final slash
    (setq sl (split-string (if (getenv "GTAGSLIBPATH") (getenv "GTAGSLIBPATH") "")  ":" t))
    (if del (setq sl (delete libdir sl)) (add-to-list 'sl libdir t))
    (setenv "GTAGSLIBPATH" (mapconcat 'identity sl ":"))
    ))

(defun gtags-ext-print-gtagslibpath ()
  "print the GTAGSLIBPATH (for debug purpose)"
  (interactive)
  (message "GTAGSLIBPATH=%s" (getenv "GTAGSLIBPATH")))

(global-set-key (kbd "<C-f7>") 'ggtags-create-tags)
(global-set-key (kbd "<M-f7>") 'ggtags-update-tags)
(global-set-key (kbd "<C-f8>") 'ggtags-find-definition)
(global-set-key (kbd "<M-f8>") 'ggtags-find-reference)
(global-set-key (kbd "<S-f8>") 'ggtags-find-tag-dwim)
(global-set-key (kbd "<s-f8>") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)


;; Before using the ggtags
;; remember to create a GTAGS database
;; by running gtags at your project root in terminal:

;; $ cd /path/to/project/root
;; $ gtags

;; After this, a few files are created:

;; $ ls G*
;; GPATH   GRTAGS  GTAGS

(provide 'init-tags)
