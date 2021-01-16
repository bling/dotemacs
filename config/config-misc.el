(defgroup dotemacs-misc nil
  "Configuration options for miscellaneous."
  :group 'dotemacs
  :prefix 'dotemacs-misc)

(defcustom dotemacs-misc/inhibit-undo-tree
  t
  "If non-nil, disables undo-tree and replaces it with desktop-mode."
  :type 'boolean
  :group 'dotemacs-evil)



(require-package 'pcache)
(setq pcache-directory (concat dotemacs-cache-directory "pcache/"))


(require-package 'request)
(setq request-storage-directory (concat dotemacs-cache-directory "request/"))


(require-package 'undo-tree)
(if dotemacs-misc/inhibit-undo-tree
    (after 'evil-integration
      (global-undo-tree-mode -1)

      (defun /misc/append-buffer-undo-list (alist)
        (append `(,(cons 'buffer-undo-list buffer-undo-list)) alist))

      ;; due to a bug, buffer-undo-list is not included here, so we have to patch it in
      (advice-add #'buffer-local-variables :filter-return #'/misc/append-buffer-undo-list)

      (add-to-list 'desktop-locals-to-save 'buffer-undo-list))
  (require-package 'undo-tree)
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-enable-undo-in-region nil)
  (setq undo-tree-history-directory-alist
        `(("." . ,(concat dotemacs-cache-directory "undo/"))))
  (setq undo-tree-visualizer-timestamps t)
  (setq undo-tree-visualizer-diff t)
  (global-undo-tree-mode))


(require-package 'multiple-cursors)
(setq mc/list-file (concat dotemacs-cache-directory "mc-lists.el"))
(after 'evil
  (add-hook 'multiple-cursors-mode-enabled-hook #'evil-emacs-state)
  (add-hook 'multiple-cursors-mode-disabled-hook #'evil-normal-state))


(require-package 'dumb-jump)
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
(add-hook 'dumb-jump-after-jump-hook #'evil-set-jump)


(require-package 'wgrep)


(when (executable-find "pt")
  (require-package 'pt)
  (require-package 'wgrep-pt)
  (after 'evil
    (add-to-list 'evil-motion-state-modes 'pt-search-mode)
    (evil-add-hjkl-bindings pt-search-mode-hook 'motion)))


(when (executable-find "ag")
  (require-package 'ag)
  (setq ag-highlight-search t)
  (setq-default ag-ignore-list dotemacs-globally-ignored-directories)
  (add-hook 'ag-mode-hook (lambda () (toggle-truncate-lines t)))
  (require-package 'wgrep-ag))


(require-package 'avy)


(require-package 'expand-region)


(when (executable-find "editorconfig")
  (require-package 'editorconfig)
  (editorconfig-mode))


(require-package 'aggressive-indent)
(require 'aggressive-indent)
(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
(add-hook 'lisp-mode-hook #'aggressive-indent-mode)


(require 'etags-select)
(setq etags-select-go-if-unambiguous t)


(require-package 'windsize)
(require 'windsize)
(setq windsize-cols 16)
(setq windsize-rows 8)
(windsize-default-keybindings)


(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)


(require 'framemove)
(setq framemove-hook-into-windmove t)


(require-package 'discover-my-major)


(setq paradox-execute-asynchronously t)
(require-package 'paradox)


(require-package 'vlf)
(setq vlf-application 'dont-ask)
(require 'vlf-setup)


(require-package 'shackle)
(shackle-mode)
(setq shackle-rules
      '((help-mode :align right :size 80)
        (compilation-mode :align bottom :size 0.2)
        (diff-mode :align right :size 0.5)
        (magit-diff-mode :align right :size 0.5)
        (magit-revision-mode :align right :size 0.5)
        (ibuffer-mode :align right :size 0.5)
        (ag-mode :align right :size 0.5)
        (compilation-mode :align bottom :size 0.3)
        ("^\\*helm.*\\*$" :regexp t :align bottom)
        ))


(when (executable-find "prettier")
  (require-package 'reformatter)
  (reformatter-define prettier-css :program "prettier" :args '("--parser=css"))
  (reformatter-define prettier-html :program "prettier" :args '("--parser=html"))
  (reformatter-define prettier-javascript :program "prettier" :args '("--parser=babylon"))
  (reformatter-define prettier-json :program "prettier" :args '("--parser=json"))
  (reformatter-define prettier-markdown :program "prettier" :args '("--parser=markdown"))
  (reformatter-define prettier-typescript :program "prettier" :args '("--parser=typescript"))
  (reformatter-define prettier-yaml :program "prettier" :args '("--parser=yaml")))


(require-package 'restart-emacs)


(provide 'config-misc)
