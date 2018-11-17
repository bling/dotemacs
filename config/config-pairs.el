(defun /pairs/init-smartparens ()
  (require-package 'smartparens)
  (require 'smartparens-config)

  (electric-pair-mode -1)

  (setq sp-base-key-bindings 'sp)
  (setq sp-show-pair-from-inside t)

  (show-smartparens-global-mode t)
  (smartparens-global-mode t)

  (sp-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-pair "(" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-pair "[" nil :post-handlers '(("||\n[i]" "RET"))))

(defun /pairs/init-emacs ()
  ;; tabs/spaces only, do not include newlines
  (setq electric-pair-skip-whitespace-chars '(32 9))

  (electric-pair-mode t)

  (add-hook 'minibuffer-setup-hook (defun /pairs/off () (electric-pair-mode -1)))
  (add-hook 'minibuffer-exit-hook (defun /pairs/on () (electric-pair-mode t))))

(defun /pairs/toggle ()
  (interactive)
  (cond
   ((eq dotemacs-pair-engine 'smartparens)
    (call-interactively #'smartparens-global-mode))
   (t
    (call-interactively #'electric-pair-mode))))

(cond
 ((eq dotemacs-pair-engine 'smartparens)
  (/pairs/init-smartparens))
 (t
  (/pairs/init-emacs)))

(provide 'config-pairs)
