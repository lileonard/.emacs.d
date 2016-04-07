;; ;;; init-helm.el --- settings for helm and helm based plugins  -*- lexical-binding: t; -*-
(require 'helm)
(require 'helm-types)
(require 'helm-locate)
(require 'helm-buffers)
(require 'helm-files)
(autoload 'helm-semantic-or-imenu "helm-semantic.el" nil t)
(setq helm-recentf-fuzzy-match t
      helm-buffers-fuzzy-matching t
      helm-locate-fuzzy-match t
      helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match t
      helm-lisp-fuzzy-completion t)

;; ;; defface helm-source-header
;; (set-face-attribute
;;  'helm-selection nil
;;  :background "#551A8B"
;;  :foreground "#FFF68F")

(require 'helm-grep)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
;; rebihnd tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ;; make TAB works in terminal
(define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
(define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
(define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-scroll-amount 4
      ;; scroll 4 lines other window using M-<next>/M-<prior>
      helm-ff-search-library-in-sexp t
      ;; search for library in `require' and `declare-function' sexp.
      helm-split-window-in-side-p t
      ;; open helm buffer inside current window, not occupy whole other window
      helm-candidate-number-limit 500
      ;; limit the number of displayed canidates
      helm-ff-file-name-history-use-recentf t
      helm-move-to-line-cycle-in-source t
      ;; move to end or beginning of source when reaching top or bottom of source.
      ;; useful in helm-mini that lists buffers
      )

(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
(global-set-key (kbd "C-c h o") 'helm-occur)

(global-set-key (kbd "C-c h C-c w") 'helm-wikipedia-suggest)

(global-set-key (kbd "C-c h x") 'helm-register)
;; (global-set-key (kbd "C-x r j") 'jump-to-register)

(define-key 'help-command (kbd "C-f") 'helm-apropos)
(define-key 'help-command (kbd "r") 'helm-info-emacs)
(define-key 'help-command (kbd "C-l") 'helm-locate-library)

;; use helm to list eshell history
(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map (kbd "M-l")  'helm-eshell-history)))

;;; Save current position to mark ring
(add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)

;; show minibuffer history with Helm
(define-key minibuffer-local-map (kbd "M-p") 'helm-minibuffer-history)
(define-key minibuffer-local-map (kbd "M-n") 'helm-minibuffer-history)

(define-key global-map [remap find-tag] 'helm-etags-select)

(define-key global-map [remap list-buffers] 'helm-buffers-list)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: helm-swoop                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Locate the helm-swoop folder to your path
(require 'helm-swoop)
;;basic settings
;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)
;; If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows nil)
;; Split direcion. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)
;; If nil, you can slightly boost invoke speed in exchange for text color
(setq helm-swoop-speed-or-color t)
;; If you prefer fuzzy matching
(setq helm-swoop-use-fuzzy-match t)
;; ;; Go to the opposite side of line from the end or beginning of line
(setq helm-swoop-move-to-line-cycle t)
;; If there is no symbol at the cursor, use the last used words instead.

(setq helm-swoop-pre-input-function
      (lambda ()
        (let (($pre-input (thing-at-point 'symbol)))
          (if (eq (length $pre-input) 0)
              helm-swoop-pattern ;; this variable keeps the last used words
            $pre-input))))
;; hot key settings
(global-set-key (kbd "C-f") 'helm-swoop)
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
;; ;; face settings
;; (set-face-attribute
;;  'helm-swoop-target-line-face nil
;;  :background "black"
;;  :foreground "#dcdccc")
;; (set-face-attribute
;;  'helm-swoop-target-word-face nil
;;  :background "gray13"
;;  :foreground "red")

(defun helm-swoop-flash-word ($match-beg $match-end)
  (interactive)
  (unwind-protect
      (let (($o (make-overlay $match-beg $match-end)))
        (when $o
          (overlay-put $o 'face 'helm-swoop-target-word-face)
          (overlay-put $o 'helm-swoop-overlay-word-frash t)))
    (run-with-idle-timer
     2.2 nil (lambda () (helm-swoop--delete-overlay 'helm-swoop-overlay-word-frash)))))

(require 'helm-flx)
(helm-flx-mode 1)

(require 'helm-projectile)
(global-set-key (kbd "M-f") 'helm-projectile-grep)

(provide 'init-helm)
