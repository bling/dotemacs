;; -*- lexical-binding: t -*-

(when (eq dotemacs-completion-engine 'corfu)

  (require-package 'corfu)
  (setq corfu-auto-prefix 2)
  (setq corfu-auto t)
  (global-corfu-mode t)

  (setq corfu-popupinfo-delay '(1.0 . 0.2))
  (corfu-popupinfo-mode t)

  (defun /corfu/move-to-minibuffer ()
    (interactive)
    (let ((completion-extra-properties corfu--extra)
          completion-cycle-threshold completion-cycling)
      (apply #'consult-completion-in-region completion-in-region--data)))

  (after [prescient]
    (require-package 'corfu-prescient)
    (setq corfu-prescient-override-sorting t)
    (corfu-prescient-mode t))

  (after [lsp-completion]
    (setq lsp-completion-provider :none)
    (defun /corfu/lsp-setup-completion ()
      (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
            '(flex)))
    (add-hook 'lsp-completion-mode #'/corfu/lsp-setup-completion))

  (add-hook
   'eshell-mode-hook
   (defun /corfu/eshell-mode-hook ()
     (setq-local corfu-auto nil)))

  (advice-add
   #'corfu-insert
   :after
   (defun /corfu/corfu-insert-for-shell (&rest _)
     "Send completion candidate when insude comint/eshell."
     (cond
      ((derived-mode-p 'eshell-mode) (eshell-send-input))
      ((derived-mode-p 'comint-mode) (comint-send-input)))))

  (require-package 'cape)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword)

  ;; workarounds for upstream bugs
  (advice-add #'pcomplete-completions-at-point :around #'cape-wrap-silent)
  (advice-add #'pcomplete-completions-at-point :around #'cape-wrap-purify))
