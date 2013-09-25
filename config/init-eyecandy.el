(require-package 'smart-mode-line)
(require 'smart-mode-line)
(if after-init-time (sml/setup)
  (add-hook 'after-init-hook 'sml/setup))

(require-package 'diminish)
(require 'diminish)

(when (display-graphic-p)
  (set-face-attribute 'default nil :font "Ubuntu Mono-14"))

(provide 'init-eyecandy)
