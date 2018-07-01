(defun /pairs/init-smartparens ()
  (require-package 'smartparens)
  (require 'smartparens-config)

  (electric-pair-mode -1)

  (setq sp-autoinsert-quote-if-followed-by-closing-pair nil)
  (setq sp-autoinsert-pair t)

  (setq sp-show-pair-delay 0)
  (setq sp-show-pair-from-inside t)

  (show-smartparens-global-mode t)
  (smartparens-global-mode t)

  (sp-use-smartparens-bindings)

  ;; fix conflict where smartparens clobbers yas' key bindings
  (after 'yasnippet
    (defadvice yas-expand (before dotemacs activate)
      (sp-remove-active-pair-overlay))))

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
