(require-package 'smart-mode-line)

(require 'smart-mode-line)
(if after-init-time (sml/setup)
  (add-hook 'after-init-hook 'sml/setup))

(provide 'init-eyecandy)
