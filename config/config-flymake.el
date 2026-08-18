;; -*- lexical-binding: t -*-

(require 'flymake)

(add-hook 'prog-mode-hook #'flymake-mode)
(add-hook 'text-mode-hook #'flymake-mode)

(require-package 'flymake-collection)
(after 'flymake-collection
  (flymake-collection-hook-setup))

(defun /flymake/disable-dotfiles-elisp-checkers ()
  (remove-hook 'flymake-diagnostic-functions #'elisp-flymake-byte-compile t)
  (remove-hook 'flymake-diagnostic-functions #'elisp-flymake-checkdoc t))

(add-hook 'emacs-lisp-mode-hook #'/flymake/disable-dotfiles-elisp-checkers)

(provide 'config-flymake)
