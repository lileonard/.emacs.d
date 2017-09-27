(require 'linum)
(global-linum-mode 1)
(setq linum-mode-inhibit-modes-list
      '(eshell-mode
        shell-mode
        erc-mode
        help-mode
        jabber-roster-mode
        jabber-chat-mode
        twittering-mode
        compilation-mode
        weibo-timeline-mode
        woman-mode
        Info-mode
        calc-mode
        calc-trail-mode
        comint-mode
        gnus-group-mode
        inf-ruby-mode
        gud-mode
        term-mode
        w3m-mode
        speedbar-mode
        gnus-summary-mode
        gnus-article-mode
        calendar-mode
        org-mode))

(defadvice linum-on (around linum-on-inhibit-for-modes)
  "Stop the load of linum-mode for some major modes."
  (unless (member major-mode linum-mode-inhibit-modes-list)
    ad-do-it))

;; updated line number every second
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 1 nil #'linum-update-current))
(ad-activate 'linum-on)

(require 'hlinum)
(hlinum-activate)


(provide 'init-linum-mode)

