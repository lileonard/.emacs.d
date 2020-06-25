;;;;;;;;;;;;AucTex;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (load "auctex.el.in" nil t t)
;; (load "preview-latex.el" nil t t)
(require 'tex-mik)
(setq Tex-auto-save t)
(setq Tex-parse-self t)
(setq-default Tex-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(setq reftex-plug-into-AUCTeX t)

(defun latex-help-get-cmd-alist () ;corrected version:
  "Scoop up the commands in the index of the latex info manual.
   The values are saved in `latex-help-cmd-alist' for speed."
  ;; mm, does it contain any cached entries
  (if (not (assoc "\\begin" latex-help-cmd-alist))
      (save-window-excursion
        (setq latex-help-cmd-alist nil)
        (Info-goto-node (concat latex-help-file "Command Index"))
        (end-of-buffer)
        (while (re-search-backward "^\\* \\(.+\\): *\\(.+\\)\\." nil t)
          (setq key (ltxh-buffer-substring (match-beginning 1) (match-end 1)))
          (setq value (ltxh-buffer-substring (match-beginning 2) (match-end 2)))
          (setq latex-help-cmd-alist
                (cons (cons key value) latex-help-cmd-alist)))))
  latex-help-cmd-alist)
;; bibtex settings 
;; (setq bibtex-autokey-names 1
;;       bibtex-autokey-names-stretch 1
;;       bibtex-autokey-name-separator "-"
;;       bibtex-autokey-additional-names "-et.al."
;;       bibtex-autokey-name-case-convert 'identity
;;       bibtex-autokey-name-year-separator "-"
;;       bibtex-autokey-titlewords-stretch 0
;;       bibtex-autokey-titlewords 0
;;       bibtex-maintain-sorted-entries 'plain
;;       bibtex-entry-format '(opts-or-alts numerical-fields))

;;;;;;;;;;;;RefTex;;;;;;;;;;;;;;;;
(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex) 
(setq reftex-plug-into-AUCTeX t
      reftex-enable-partial-scans t
      reftex-save-parse-info t
      reftex-use-multiple-selection-buffers t
      reftex-toc-split-windows-horizontally t ;;*toc*buffer在左侧。
      reftex-toc-split-windows-fraction 0.2)  ;;*toc*buffer 使用整个frame的比例。
(autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)  
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase mode" t)

;;;;;;;;;;;;;;;CDLatex;;;;;;;;;;;;
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
(autoload 'cdlatex-mode "cdlatex" "CDLaTeX Mode" t)
(autoload 'turn-on-cdlatex "cdlatex" "CDLaTeX Mode" nil)

;;;;;;;;;LaTex-mode settings;;;;;
(add-hook 'LaTeX-mode-hook 
          (lambda ()
            (tex-pdf-mode 1)
            (TeX-source-correlate-mode 1)
            (TeX-fold-mode 1)
            (auto-complete-mode 1)
            (LaTeX-math-mode 1)
            (outline-minor-mode 1)            ;;使用 LaTeX mode 的时候打开 outline mode
            (setq TeX-show-compilation t)   ;;NOT display compilation windows
            (setq TeX-global-PDF-mode t       ;;PDF mode enable, not plain
                  TeX-engine 'xetex           ;;use xelatex default
                  TeX-auto-untabify t                  
                  TeX-clean-confirm nil
                  TeX-save-query nil
                  font-latex-fontify-script t
                  TeX-fold-help-echo-max-length 0
                  TeX-view-program-list '(("Evince" "evince %o")))  ;;重新定义pdf viewer
            (setq TeX-view-program-selection 
                  (quote (((output-dvi style-pstricks) "dvips and gv") 
                          (output-dvi "xdvi") 
                          (output-pdf "evince")
                          (output-html "xdg-open"))))
            (setq TeX-PDF-mode t)
            (TeX-global-PDF-mode t)       ; PDF mode enable, not plain
            (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)
            (imenu-add-menubar-index)
            (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
            (setq TeX-command-default "XeLaTeX")
            (setq TeX-fold-env-spec-list (quote 
                                          (("[comment]" ("comment")) ("[figure]" ("figure")) ("[table]" ("table"))("[itemize]"("itemize"))("[enumerate]"("enumerate"))("[description]"("description"))("[overpic]"("overpic"))("[tabularx]"("tabularx"))("[code]"("code"))("[shell]"("shell")))))
            ;;定义latex-mode下的快捷键
            (define-key LaTeX-mode-map (kbd "C-c C-p") 'reftex-parse-all)
                  ;;;;;;设置更深层的目录;;;;;;;;;;;;;
            (setq reftex-section-levels
                  '(("part" . 0) ("chapter" . 1) ("section" . 2) ("subsection" . 3)
                    ("frametitle" . 4) ("subsubsection" . 4) ("paragraph" . 5)
                    ("subparagraph" . 6) ("addchap" . -1) ("addsec" . -2)))
            (setq LaTeX-section-hook
                  '(LaTeX-section-heading
                    LaTeX-section-title
                    ;;LaTeX-section-toc
                    LaTeX-section-section
                    LaTeX-section-label))))
(add-hook 'latex-mode-hook (lambda ()
                             (flyspell-mode 1)
                             (auto-complete-mode t)
                             (latex-electric-env-pair-mode t)
                             (local-set-key (kbd "s-b") 'latex-insert-block)
                             (local-set-key (kbd "s-i") 'latex-insert-item)))
;; always start the server for inverse search
(setq-default TeX-source-correlate-start-server 0)


(provide 'init-latex)
