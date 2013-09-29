(require-package 'smart-mode-line)
(require 'smart-mode-line)
(if after-init-time (sml/setup)
  (add-hook 'after-init-hook 'sml/setup))

(require-package 'diminish)
(require 'diminish)
(diminish 'undo-tree-mode)
(diminish 'auto-complete-mode)
(diminish 'projectile-mode)
(diminish 'yas-minor-mode)
(diminish 'guide-key-mode)
(diminish 'helm-mode)
(diminish 'eldoc-mode)
(diminish 'smartparens-mode)

(when (display-graphic-p)
  (set-face-attribute 'default nil :font "Ubuntu Mono-14"))

(global-hl-line-mode +1)
(require 'linum)
(global-linum-mode t)
(setq linum-format "%4d "
      linum-delay t
      linum-eager nil)

(if (display-graphic-p)
    (progn
      (require-package 'soothe-theme)
      (load-theme 'soothe))
  (progn
    (require-package 'monokai-theme)
    (load-theme 'monokai t)))

(provide 'init-eyecandy)
