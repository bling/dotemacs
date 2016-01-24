(when (eq dotemacs-pair-engine 'emacs)
  (show-paren-mode)
  (setq show-paren-delay 0))


(line-number-mode t)
(column-number-mode t)
(display-time-mode t)
(size-indication-mode t)


(defun my-fold-overlay (ov)
  (when (eq 'code (overlay-get ov 'hs))
    (let ((col (save-excursion
                 (move-end-of-line 0)
                 (current-column)))
          (count (count-lines (overlay-start ov) (overlay-end ov))))
      (overlay-put ov 'after-string
                   (format "%s [ %d ] ... "
                           (make-string (- (window-width) col 32) (string-to-char "."))
                           count)))))
(setq hs-set-up-overlay 'my-fold-overlay)
(add-hook 'prog-mode-hook #'hs-minor-mode)


(require-package 'diminish)
(diminish 'visual-line-mode)
(after 'undo-tree (diminish 'undo-tree-mode))
(after 'auto-complete (diminish 'auto-complete-mode))
(after 'company (diminish 'company-mode))
(after 'projectile (diminish 'projectile-mode))
(after 'yasnippet (diminish 'yas-minor-mode))
(after 'which-key (diminish 'which-key-mode))
(after 'eldoc (diminish 'eldoc-mode))
(after 'smartparens (diminish 'smartparens-mode))
(after 'elisp-slime-nav (diminish 'elisp-slime-nav-mode))
(after 'git-gutter+ (diminish 'git-gutter+-mode))
(after 'highlight-symbol (diminish 'highlight-symbol-mode))
(after 'indent-guide (diminish 'indent-guide-mode))
(after 'hideshow (diminish 'hs-minor-mode))
(after 'ivy (diminish 'ivy-mode))
(after 'helm-mode (diminish 'helm-mode))
(after 'evil-commentary (diminish 'evil-commentary-mode))
(after 'page-break-lines (diminish 'page-break-lines-mode))
(after 'flycheck (diminish 'flycheck-mode))


(require-package 'spaceline)
(require 'spaceline-config)
(setq spaceline-highlight-face-func #'spaceline-highlight-face-evil-state)
(spaceline-spacemacs-theme)
(spaceline-info-mode)
(after "helm-autoloads"
  (spaceline-helm-mode))


(global-prettify-symbols-mode)
(add-hook 'js2-mode-hook
          (lambda ()
            (push '("function" . 955) prettify-symbols-alist)
            (push '("return" . 8592) prettify-symbols-alist)))


(delayed-init
 (require-package 'color-identifiers-mode)
 (global-color-identifiers-mode)
 (diminish 'color-identifiers-mode))


;; (require-package 'fancy-narrow)
;; (fancy-narrow-mode)


(require-package 'highlight-symbol)
(setq highlight-symbol-idle-delay 0.3)
(add-hook 'prog-mode-hook 'highlight-symbol-mode)


(require-package 'highlight-numbers)
(add-hook 'prog-mode-hook 'highlight-numbers-mode)


(require-package 'highlight-quoted)
(add-hook 'prog-mode-hook 'highlight-quoted-mode)


(require-package 'page-break-lines)
(global-page-break-lines-mode)


(add-hook 'find-file-hook 'hl-line-mode)


(provide 'init-eyecandy)
