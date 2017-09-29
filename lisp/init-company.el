(require 'company)
(require 'company-gtags)
(require 'company-etags)
(require 'company-dabbrev)
(require 'company-c-headers)
(add-hook 'after-init-hook 'global-company-mode)

;; @see https://github.com/company-mode/company-mode/issues/348
(require 'company-statistics)
(company-statistics-mode)
(add-to-list 'company-backends 'company-cmake)
(add-to-list 'company-backends 'company-c-headers)
(add-to-list 'company-c-headers-path-system 'my-sys-c-include)
(add-to-list 'company-c-headers-path-user   'my-custom-include-dirs)
;; don`t need it beacuse I have ac keywords
;;(add-to-list 'company-backends 'company-keywords)

;; can't work with TRAMP
(setq company-backends (delete 'company-ropemacs company-backends))
;; (setq company-backends (delete 'company-capf company-backends))

;; I don't like the downcase word in company-dabbrev!
(setq company-dabbrev-downcase nil
      ;; make previous/next selection in the popup cycles
      company-selection-wrap-around t
      ;; Some languages use camel case naming convention,
      ;; so company should be case sensitive.
      company-dabbrev-ignore-case nil
      ;; press M-number to choose candidate
      company-show-numbers t
      company-idle-delay nil
      company-require-match nil
      company-etags-ignore-case t)

;; @see https://github.com/redguardtoo/emacs.d/commit/2ff305c1ddd7faff6dc9fa0869e39f1e9ed1182d
(defadvice company-in-string-or-comment (around company-in-string-or-comment-hack activate)
  ;; you can use (ad-get-arg 0) and (ad-set-arg 0) to tweak the arguments
  (if (memq major-mode '(php-mode html-mode web-mode nxml-mode))
      (setq ad-return-value nil)
    ad-do-it))

;; press SPACE will accept the highlighted candidate and insert a space
;; `M-x describe-variable company-auto-complete-chars` for details
;; That's BAD idea.
(setq company-auto-complete nil)

;; NOT to load company-mode for certain major modes.
;; Ironic that I suggested this feature but I totally forgot it
;; until two years later.
;; https://github.com/company-mode/company-mode/issues/29
(setq company-global-modes
      '(not
        eshell-mode comint-mode erc-mode gud-mode rcirc-mode
        minibuffer-inactive-mode))

(eval-after-load 'company-etags
  '(progn
     ;; insert major-mode not inherited from prog-mode
     ;; to make company-etags work
     (add-to-list 'company-etags-modes 'web-mode)
     (add-to-list 'company-etags-modes 'lua-mode)))

(global-set-key (kbd "<backtab>") 'company-complete-common)

;; set face
(set-face-attribute
 'company-tooltip-annotation nil
 :foreground "yellow")

(provide 'init-company)
