(lazy-major-mode "\\.js$" js2-mode)

(after 'js2-mode

  (require-package 'ac-js2)
  (add-hook 'js2-mode-hook 'ac-js2-mode)

  (require-package 'js2-refactor)
  (js2r-add-keybindings-with-prefix "C-c C-m")

  (setq js2-highlight-level 3)
  (setq-default js2-basic-offset 2)

  (when (executable-find "tern")
    (require-package 'tern)
    (add-hook 'js2-mode-hook 'tern-mode)
    (after 'tern
      (after 'auto-complete
        (require-package 'tern-auto-complete)
        (tern-ac-setup))
      (after 'company-mode
        (require-package 'company-tern)))))

(provide 'init-js)
