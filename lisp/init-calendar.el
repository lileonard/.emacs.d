(setq diary-file "~/orgs/diary"
      diary-mail-address "liyuanheng.leo@gmail.com")
;;设置所在地的经纬度
;;让Emacs计算日出日落的时间 在日历上点S即可看到
(setq calendar-latitude +36.36
      calendar-longitude +120.20
      calendar-location-name "青岛")
;;设置calendar的显示
(setq calendar-remove-frame-by-deleting t
      view-diary-entries-initially t
      mark-diary-entries-in-calendar t
      mark-holidays-in-calendar t
      view-calendar-holidays-initially t
      number-of-diary-entries 9
      calendar-week-start-day 1)

(setq appt-issue-message t)   ;;appointment message

(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)

(autoload 'chinese-year "cal-china" "Chinese year data" t)

(setq general-holidays '((holiday-fixed    1    1   "元旦")
                         (holiday-fixed    2   14   "情人节")
                         (holiday-fixed    3    5   "学雷锋")
                         (holiday-fixed    3    8   "妇女节")
                         (holiday-fixed    3   12   "植树节")
                         (holiday-fixed    3   15   "消费者日")
                         (holiday-fixed    3   23   "气象日")
                         (holiday-fixed    3   23   "安全教育日")
                         (holiday-fixed    4    1   "愚人节")
                         (holiday-fixed    4    7   "世界卫生日")
                         (holiday-fixed    4   22   "世界地球日")
                         (holiday-fixed    4   23   "莎士比亚日")
                         (holiday-fixed    5    1   "劳动节")
                         (holiday-fixed    5    4   "青年节")
                         (holiday-fixed    5    8   "红十字日")
                         (holiday-fixed    5   12   "护士节")
                         (holiday-fixed    5   15   "国际家庭日")
                         (holiday-fixed    5   16   "助残日")
                         (holiday-fixed    5   16   "国际电信日")
                         (holiday-fixed    5   16   "世界无烟日")
                         (holiday-fixed    6    1   "国际儿童节")
                         (holiday-fixed    6    5   "国际环境保护日")
                         (holiday-fixed    6    6   "全国爱眼日")
                         (holiday-fixed    6   25   "全国土地日")
                         (holiday-fixed    6   26   "国际禁毒日")
                         (holiday-fixed    7    1   "党的生日，香港回归")
                         (holiday-fixed    7    7   "抗日战争纪念日")
                         (holiday-fixed    7   11   "世界人口日")
                         (holiday-fixed    8    1   "建军节")
                         (holiday-fixed    9    8   "国际扫盲日")
                         (holiday-fixed    9   10   "中国教师节")
                         (holiday-fixed    9   20   "全国爱牙日")
                         (holiday-fixed    9   27   "世界旅游日")
                         (holiday-fixed    9   28   "国际聋人日")
                         (holiday-fixed   10    1   "国庆节")
                         (holiday-fixed   10    4   "世界动物日")
                         (holiday-fixed   10    8   "全国高血压日")
                         (holiday-fixed   10    9   "世界邮政日")
                         (holiday-fixed   10   14   "世界标准日")
                         (holiday-fixed   10   16   "世界粮食日")
                         (holiday-fixed   10   24   "联合国日")
                         (holiday-fixed   11    1   "万圣节")
                         (holiday-fixed   11    2   "万灵节")
                         (holiday-fixed   11   17   "国际学生日")
                         (holiday-fixed   12    5   "国际志愿人员日")
                         (holiday-float    5  0  2  "母亲节")
                         (holiday-float    6  0  3  "父亲节")
                         ))

(setq local-holidays '((holiday-fixed    10    6   "d")
                       (holiday-fixed    10   20   "m")
                       (holiday-fixed     9   26   "王")
                       (holiday-fixed     8    3   "i")))

;;here is some code to get rid of the ugly equal sings under the date
(defun alt-clean-equal-sings ()
  "this function makes lines of = sings invisible"
  (goto-char (point-main))
  (let ((state buffer-read-only))
    (when state (setq buffer-read-only nil))
    (while (not (eobp))
      (search-forward-regexp "^=+$" nil 'move)
      (add-text-properties (match-beginning 0)
                           (match-end 0)
                           '(invisible t)))
    (when state (setq buffer-read-only t))))
(require 'generic)
(define-generic-mode 'fancy-diary-display-mode
  nil
  (list "Exception" "Location" "Desc")
  '(("\\(.*\\)\n\\(=+\\)"
     (1 'font-lock-keyword-face) (2 'font-lock-preprocessor-face))
    ("^\\(todo [^:]*:\\)\\(.*\\)$"
     (1 'font-lock-string-face) (2 'font-lock-reference-face))
    ("\\(\\[.*\\]\\)"
     1 'font-lock-constant-face)
    ("^\\(0?\\([1-9][0-9]?:[0-9][0-9]\\)\\([ap]m\\)?\\(-0?\\([1-9][0-9]?:[0-9][0-9]\\)\\([ap]m\\)?\\)?\\)"
     1 'font-lock-type-face))
  nil
  (list
   (function
    (lambda ()
      (turn-on-font-lock)))))
(add-hook 'fancy-diary-display-mode-hook
          '(lambda ()
             (alt-clean-equal-sings)))

;;Chinese animal birth year
(defun animals-brith-year(birthyear)
  "calculate the Chinese animal birth year"
  (let ((x (% (- 1997 brithyear) 12)))
    (cond ((or (= x 1) (= x -11)) "鼠" ))
    (cond ((= x 0)  "牛" ))
    (cond ((or (= x 11) (= x -1)) "虎" ))
    (cond ((or (= x 10) (= x -2)) "兔" ))
    (cond ((or (= x 9) (= x -3)) "龙" ))
    (cond ((or (= x 8) (= x -4)) "蛇" ))
    (cond ((or (= x 7) (= x -5)) "马" ))
    (cond ((or (= x 6) (= x -6)) "羊" ))
    (cond ((or (= x 5) (= x -7)) "猴" ))
    (cond ((or (= x 4) (= x -8)) "鸡" ))
    (cond ((or (= x 3) (= x -9)) "狗" ))
    (cond ((or (= x 2) (= x -10)) "猪" ))))

(setq calendar-chinese-celestial-stem
      ["甲" "乙" "丙" "丁" "戊" "己" "庚" "辛" "壬" "癸"]
     calendar-chinese-terrestrial-branch
     ["子" "丑" "寅" "卯" "辰" "巳" "午" "未" "申" "酉" "戌" "亥"])

(global-set-key (kbd "C-`") 'calendar)

(provide 'init-calendar)