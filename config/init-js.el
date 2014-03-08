(lazy-major-mode "\\.js$" js2-mode)

(after 'js2-mode
  (require-package 'ac-js2)
  (require-package 'js2-refactor)

  (setq js2-highlight-level 3)
  (setq-default js2-basic-offset 2)

  (require-package 'tern)
  (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
  (after 'tern
    (after 'auto-complete
      (require-package 'tern-auto-complete)
      (tern-ac-setup))
    (after 'company-mode
      (require-package 'company-tern))))

(provide 'init-js)
