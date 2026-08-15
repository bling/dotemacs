;; -*- lexical-binding: t -*-

(after 'corfu
  (define-key corfu-map (kbd "<tab>") #'corfu-next)
  (define-key corfu-map (kbd "<backtab>") #'corfu-previous))

(provide 'config-bindings-corfu)
