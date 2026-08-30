;; -*- lexical-binding: t -*-

(after 'ghostel
  (add-to-list 'ghostel-keymap-exceptions "C-w")
  (ghostel--rebuild-semi-char-keymap)
  (when (and (fboundp 'ghostel--module-version)
             (ghostel--module-version))
    (add-hook 'eshell-load-hook #'ghostel-eshell-visual-command-mode)))

(after 'vterm
  (setopt vterm-keymap-exceptions (cons "C-w" vterm-keymap-exceptions)))

(after 'eat
  (eat-eshell-mode t)
  (keymap-unset eat-semi-char-mode-map "C-w")
  (keymap-unset eat-eshell-semi-char-mode-map "C-w")
  (keymap-unset eat-char-mode-map "C-w")
  (keymap-unset eat-eshell-char-mode-map "C-w"))

(provide 'config-terminal)
