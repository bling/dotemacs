(global-set-key (kbd "RET") 'newline-and-indent)

(require-package 'guide-key)
(setq guide-key/guide-key-sequence
      '("C-x" "C-c"))
(setq guide-key/recursive-key-sequence-flag t)
(guide-key-mode 1)

(provide 'init-bindings)
