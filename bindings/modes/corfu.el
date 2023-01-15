;; -*- lexical-binding: t -*-

(after 'corfu
  (define-key corfu-map (kbd "C-s") #'/corfu/move-to-minibuffer))

(provide 'config-bindings-corfu)
