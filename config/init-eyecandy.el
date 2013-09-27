(require-package 'smart-mode-line)
(require 'smart-mode-line)
(if after-init-time (sml/setup)
  (add-hook 'after-init-hook 'sml/setup))

(require-package 'diminish)
(require 'diminish)

(when (display-graphic-p)
  (set-face-attribute 'default nil :font "Ubuntu Mono-14"))

(global-hl-line-mode +1)
(require 'linum)
(global-linum-mode t)
(setq linum-format "%4d "
      linum-delay t
      linum-eager nil)

(require-package 'monokai-theme)
(load-theme 'monokai t)

(provide 'init-eyecandy)
