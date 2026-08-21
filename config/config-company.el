;; -*- lexical-binding: t -*-

(when (eq dotemacs-completion-engine 'company)

  (defgroup dotemacs-company nil
    "Configuration options for company-mode."
    :group 'dotemacs
    :prefix 'dotemacs-company)

  (use-package company :demand t
    :init
    (setq company-idle-delay 0.2)
    (setq company-minimum-prefix-length 1)
    (setq company-show-quick-access t)
    (setq company-tooltip-limit 20)

    (setq company-dabbrev-downcase nil)
    (setq company-dabbrev-ignore-case t)

    (setq company-dabbrev-code-ignore-case t)
    (setq company-dabbrev-code-everywhere t)

    (setq company-etags-ignore-case t)

    (setq company-global-modes
          '(not
            comint-mode
            erc-mode
            eshell-mode
            term-char-mode
            term-line-mode
            term-mode
            text-mode))
    :config
    (global-company-mode))

  (after 'yasnippet
    (setq company-backends (delq 'company-capf company-backends))
    (add-to-list 'company-backends '(:separate company-capf :with company-yasnippet)))

  (defun /company/merge-yasnippet-backend ()
    (setq-local company-backends
                (cons '(:separate company-capf :with company-yasnippet)
                      (cl-remove-if
                       (lambda (b)
                         (or (eq b 'company-capf)
                             (and (listp b) (memq 'company-capf b))))
                       (copy-sequence company-backends)))))

  (after 'lsp-completion
    (add-hook 'lsp-completion-mode-hook #'/company/merge-yasnippet-backend)))

(provide 'config-company)
