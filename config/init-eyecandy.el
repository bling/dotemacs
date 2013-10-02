(require-package 'smart-mode-line)
(add-hook 'after-init-hook (sml/setup))

(require-package 'diminish)
(require 'diminish)
(after 'undo-tree (diminish 'undo-tree-mode))
(after 'auto-complete (diminish 'auto-complete-mode))
(after 'projectile (diminish 'projectile-mode))
(after 'yasnippet (diminish 'yas-minor-mode))
(after 'guide-key (diminish 'guide-key-mode))
(after 'eldoc (diminish 'eldoc-mode))
(after 'smartparens (diminish 'smartparens-mode))
(after 'company (diminish 'company-mode))
(after 'git-gutter+ (diminish 'git-gutter+-mode))

(global-hl-line-mode +1)

(require 'linum)
(setq linum-format "%4d ")
(global-linum-mode t)

(require-package 'soothe-theme)
;; (require-package 'birds-of-paradise-plus-theme)
;; (require-package 'sublime-themes)
(load-theme 'birds-of-paradise-plus)

(when (display-graphic-p)
  (set-face-attribute 'default nil :font "Ubuntu Mono-14")
  (fringe-mode 16))

(provide 'init-eyecandy)
