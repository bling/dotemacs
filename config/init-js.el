(require-package 'js2-mode)
(require 'js2-mode)
(setq js2-highlight-level 3)
(setq-default js2-basic-offset 2)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))


(require-package 'ac-js2)


(require-package 'js2-refactor)
(require 'js2-refactor)
(js2r-add-keybindings-with-prefix "C-c C-m")


(require-package 'tern)
(require-package 'tern-auto-complete)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(after 'tern
  (after 'auto-complete
    (require 'tern-auto-complete)
    (tern-ac-setup)))


(provide 'init-js)
