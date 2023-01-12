;; -*- lexical-binding: t -*-

(after 'eglot
  (defhydra /bindings/eglot/hydra (:exit t)
    ("d" xref-find-definitions "xref definitions")
    ("r" xref-find-references "xref references")
    ("=" eglot-format-buffer "format")
    ("a" eglot-code-actions "apply code action")
    ("e" flymake-show-buffer-diagnostics "file errors")
    ("E" flymake-show-project-diagnostics "project errors"))

  (evil-define-key 'normal eglot-mode-map (kbd "RET") #'/bindings/eglot/hydra/body)
  (evil-define-key 'normal eglot-mode-map (kbd "g r") #'eglot-rename)
  (evil-define-key 'normal eglot-mode-map (kbd "g d") #'xref-find-definitions)
  (evil-define-key 'normal eglot-mode-map (kbd "K") #'eldoc))

(provide 'config-bindings-eglot)
