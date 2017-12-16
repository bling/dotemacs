(after 'dired
  (require 'dired-x))

(require-package 'dired-sidebar)
(setq dired-sidebar-should-follow-file t)
(setq dired-sidebar-follow-file-idle-delay 0.2)

(provide 'config-dired)
