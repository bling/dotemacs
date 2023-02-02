;; -*- lexical-binding: t -*-

(after 'corfu
  (define-key corfu-map (kbd "C-s") #'/corfu/move-to-minibuffer)
  (define-key corfu-map (kbd "<tab>") #'corfu-next)
  (define-key corfu-map (kbd "<backtab>") #'corfu-previous))

(provide 'config-bindings-corfu)
