;;(setq bookmark-save-flag 1) ; everytime bookmark is changed, automatically save it
(require 'bookmark)
(setq bookmark-save-flag t) ; save bookmark when emacs quits 
;;(setq bookmark-save-flag nil) ; never auto save.
(setq bookmark-default-file  (concat user-emacs-directory "bookmarks"))
(provide 'init-bookmark)
