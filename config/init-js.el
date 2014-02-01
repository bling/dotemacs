(require-package 'js2-mode)
(require 'js2-mode)
(setq js2-highlight-level 3)
(setq-default js2-basic-offset 2)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))


(require-package 'ac-js2)


(require-package 'js2-refactor)


(after 'discover-autoloads
  (require-package 'discover-js2-refactor)
  (require 'discover-js2-refactor))


(require-package 'tern)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(after 'tern
  ;; remove conflict with discover-js2
  (define-key tern-mode-keymap (kbd "C-c C-r") nil)

  (after 'auto-complete
    (require-package 'tern-auto-complete)
    (tern-ac-setup))
  (after 'company-mode
    (require-package 'company-tern)))


(provide 'init-js)
