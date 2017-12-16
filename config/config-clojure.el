(add-hook 'clojure-mode-hook
          (lambda ()
            (require-package 'cider)
            (cider-mode t)))

(after [evil cider]
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'eldoc-mode)

  (evil-set-initial-state 'cider-popup-buffer-mode 'motion)
  (evil-set-initial-state 'cider-browse-ns-mode 'motion)
  (evil-set-initial-state 'cider-repl-mode 'emacs))

(provide 'config-clojure)
