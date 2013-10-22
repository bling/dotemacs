(require-package 'smart-mode-line)
(add-hook 'after-init-hook (sml/setup))


(require-package 'pretty-mode)
(global-pretty-mode)


(require-package 'smooth-scroll)
(require 'smooth-scroll)
(setq smooth-scroll/vscroll-step-size 8)
(smooth-scroll-mode t)


(require-package 'diminish)
(after 'diminish-autoloads
  (diminish 'global-visual-line-mode)
  (after 'undo-tree (diminish 'undo-tree-mode))
  (after 'auto-complete (diminish 'auto-complete-mode))
  (after 'projectile (diminish 'projectile-mode))
  (after 'yasnippet (diminish 'yas-minor-mode))
  (after 'guide-key (diminish 'guide-key-mode))
  (after 'eldoc (diminish 'eldoc-mode))
  (after 'smartparens (diminish 'smartparens-mode))
  (after 'company (diminish 'company-mode))
  (after 'git-gutter+ (diminish 'git-gutter+-mode))
  (after 'pretty-mode (diminish 'smooth-scroll-mode)))


(global-hl-line-mode +1)


(require 'linum)
(setq-default linum-format "%4d ")
(add-hook 'find-file-hook (lambda ()
                            (linum-mode)))


(provide 'init-eyecandy)
