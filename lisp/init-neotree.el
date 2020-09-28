(require 'neotree)
(setq neo-window-fixed-size nil
      neo-autorefresh t
      neo-smart-open t
      neo-show-hidden-files nil
      neo-window-width 33)
(global-set-key [f5] 'neotree-toggle)

(provide 'init-neotree)
