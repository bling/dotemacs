;; -*- lexical-binding: t -*-

(after 'corfu
  (defun /bindings/corfu/move-to-minibuffer ()
    (interactive)
    (when completion-in-region--data
      (let ((completion-extra-properties (nth 4 completion-in-region--data)))
        (pcase-let ((`(,beg ,end ,table ,pred . ,_) completion-in-region--data))
          (corfu-quit)
          (consult-completion-in-region beg end table pred)))))

  (define-key corfu-map (kbd "C-s") #'/bindings/corfu/move-to-minibuffer)
  (define-key corfu-map (kbd "<tab>") #'corfu-next)
  (define-key corfu-map (kbd "<backtab>") #'corfu-previous))

(provide 'config-bindings-corfu)
