;; -*- lexical-binding: t -*-

(use-package eat
  :init
  (setq eat-kill-buffer-on-exit t)
  (setq eat-enable-shell-prompt-annotation t)
  (setq eat-enable-kill-from-terminal t)
  (setq eat-enable-yank-to-terminal t)

  ;; disable blinking
  (setq eat-very-visible-cursor-type '(t nil nil))
  (setq eat-very-visible-vertical-bar-cursor-type '(bar nil nil))
  (setq eat-very-visible-horizontal-bar-cursor-type '(hbar nil nil))
  :config
  (keymap-unset eat-semi-char-mode-map "C-w")
  (keymap-unset eat-eshell-semi-char-mode-map "C-w")
  (keymap-unset eat-char-mode-map "C-w")
  (keymap-unset eat-eshell-char-mode-map "C-w"))

(after 'esh-mode
  (eat-eshell-mode t)
  (eat-eshell-visual-command-mode t))

(after 'ghostel
  (add-to-list 'ghostel-keymap-exceptions "C-w")
  (ghostel--rebuild-semi-char-keymap)
  (when (and (fboundp 'ghostel--module-version)
             (ghostel--module-version))
    (add-hook 'eshell-load-hook #'ghostel-eshell-visual-command-mode)))

(after 'vterm
  (setopt vterm-keymap-exceptions (cons "C-w" vterm-keymap-exceptions)))

(provide 'config-terminal)
