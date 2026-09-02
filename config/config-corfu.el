;; -*- lexical-binding: t -*-

(when (eq dotemacs-completion-engine 'corfu)

  (use-package corfu :demand t
    :hook (prog-mode text-mode)
    :init
    (setq global-corfu-minibuffer nil)
    (setq corfu-auto-prefix 2)
    (setq corfu-auto t)
    (setq corfu-cycle t)
    (setq corfu-preselect 'first)
    (setq corfu-preview-current nil)
    (setq corfu-quit-at-boundary t)
    (setq corfu-quit-no-match t)
    (setq corfu-popupinfo-delay '(0.2 . 0.1))
    :config
    (corfu-popupinfo-mode t))

  (after 'prescient
    (when (eq dotemacs-consult/filtering 'prescient)
      (use-package corfu-prescient :demand t
        :init
        (setq corfu-prescient-override-sorting t)
        :config
        (corfu-prescient-mode t))))

  (after 'lsp-completion
    (setq lsp-completion-provider :none)
    (defun /corfu/lsp-setup-capf ()
      (setq-local completion-at-point-functions
                  (cons (cape-capf-super
                         #'lsp-completion-at-point
                         #'yasnippet-capf)
                        (remove #'yasnippet-capf
                                (remove #'lsp-completion-at-point completion-at-point-functions)))))
    (add-hook 'lsp-completion-mode-hook #'/corfu/lsp-setup-capf))

  (after 'eglot
    (advice-add 'eglot-completion-at-point :around #'cape-wrap-buster)
    (defun /corfu/eglot-setup-capf ()
      (setq-local completion-at-point-functions
                  (cons (cape-capf-super
                         #'eglot-completion-at-point
                         #'yasnippet-capf)
                        (remove #'yasnippet-capf
                                (remove #'eglot-completion-at-point completion-at-point-functions)))))
    (add-hook 'eglot-managed-mode-hook #'/corfu/eglot-setup-capf))

  (add-hook
   'eshell-mode-hook
   (defun /corfu/eshell-mode-hook ()
     (setq-local corfu-auto nil)
     (setq-local corfu-quit-at-boundary t)
     (setq-local corfu-quit-no-match t)
     (setq-local corfu-preview-current nil)))

  (use-package cape
    :init
    (add-hook 'completion-at-point-functions #'cape-dabbrev t)
    (add-hook 'completion-at-point-functions #'cape-file)
    (add-hook 'completion-at-point-functions #'cape-elisp-block)
    (add-hook 'completion-at-point-functions #'cape-keyword)

    ;; workarounds for upstream bugs
    (advice-add #'pcomplete-completions-at-point :around #'cape-wrap-silent)))

(provide 'config-corfu)
