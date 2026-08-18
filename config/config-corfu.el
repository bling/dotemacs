;; -*- lexical-binding: t -*-

(when (eq dotemacs-completion-engine 'corfu)

  (require-package 'corfu)
  (setq corfu-auto-prefix 2)
  (setq corfu-auto t)
  (setq corfu-cycle t)
  (setq global-corfu-minibuffer nil)
  (global-corfu-mode t)

  (setq corfu-popupinfo-delay '(1.0 . 0.2))
  (corfu-popupinfo-mode t)

  (after 'prescient
    (when (eq dotemacs-consult/filtering 'prescient)
      (require-package 'corfu-prescient)
      (setq corfu-prescient-override-sorting t)
      (corfu-prescient-mode t)))

  (after 'lsp-completion
    (setq lsp-completion-provider :none))

  (after 'eglot
    (setf (alist-get 'styles (alist-get 'eglot completion-category-overrides))
          '(flex basic))
    (setf (alist-get 'styles (alist-get 'eglot-capf completion-category-overrides))
          '(flex basic))
    (advice-add 'eglot-completion-at-point :around #'cape-wrap-buster))

  (add-hook
   'eshell-mode-hook
   (defun /corfu/eshell-mode-hook ()
     (setq-local corfu-auto nil)
     (setq-local corfu-quit-at-boundary t)
     (setq-local corfu-quit-no-match t)
     (setq-local corfu-preview-current nil)))

  (require-package 'cape)
  (add-hook 'completion-at-point-functions #'cape-dabbrev t)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  (add-hook 'completion-at-point-functions #'cape-keyword)

  ;; workarounds for upstream bugs
  (advice-add #'pcomplete-completions-at-point :around #'cape-wrap-silent))

(provide 'config-corfu)
