;; init font size and type
;; font and line space settings
;; (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-14"))
;; (add-to-list 'default-frame-alist '(font . "Monospace-13"))
(autoload 'find-if "cl" "this setting needs it" t)

(defun qiang-font-existsp (font)
  (if (null (x-list-fonts font))
      nil t))
(defun qiang-make-font-string (font-name font-size)
  (if (and (stringp font-size)
           (equal ":" (string (elt font-size 0))))
      (format "%s%s" font-name font-size)
    (format "%s %s" font-name font-size)))
(defun qiang-set-font (english-fonts
                       english-font-size
                       chinese-fonts
                       chinese-font-size)
  "english-font-size could be set to \":pixelsize=18\" or a integer.
If set/leave chinese-font-size to nil, it will follow english-font-size"
  (let ((en-font (qiang-make-font-string
                  (find-if #'qiang-font-existsp english-fonts)
                  english-font-size))
        (zh-font (qiang-make-font-string
                  (find-if #'qiang-font-existsp chinese-fonts)
                  chinese-font-size)))
    ;; (zh-font (font-spec :family (find-if #'qiang-font-existsp chinese-fonts)
    ;;                     :size chinese-font-size)))

    ;; Set the default English font
    ;;
    ;; The following 2 method cannot make the font settig work in new frames.
    ;; (set-default-font "Consolas:pixelsize=18")
    ;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=18"))
    ;; We have to use set-face-attribute
    ;; (message "Set English Font to %s" en-font)
    (set-face-attribute
     'default nil :font en-font)

    (setq-default line-spacing 5)
    ;; Set Chinese font
    ;; Do not use 'unicode charset, it will cause the english font setting invalid
    ;; (message "Set Chinese Font to %s" zh-font)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset zh-font))))
;; this is on the 4k screen
(qiang-set-font
 '("Consolas"
   "Monaco"
   "DejaVu Sans Mono"
   "DejaVu LGC Sans Mono"
   "Monospace"
   "Courier New")
 ":pixelsize=33"
 '("XTXINWEI"
   "STXinwei"
   "Microsoft Yahei"
   "AR PL KaitiM GB"
   "SIMSONG"
   "ZYSong18030")
 ":pixelsize=36")

;; ;; this is on the 1080p screen
;; (qiang-set-font
;;  '("Consolas"
;;    "Monaco"
;;    "DejaVu Sans Mono"
;;    "DejaVu LGC Sans Mono"
;;    "Monospace"
;;    "Courier New")
;;  ":pixelsize=22"
;;  '("XTXINWEI"
;;    "STXinwei"
;;    "Microsoft Yahei"
;;    "AR PL KaitiM GB"
;;    "SIMSONG"
;;    "ZYSong18030")
;; ":pixelsize=24")

(provide 'init-font)
