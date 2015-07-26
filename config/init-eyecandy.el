(show-paren-mode)
(setq show-paren-delay 0)


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
(after 'projectile (diminish 'projectile-mode))
(after 'yasnippet (diminish 'yas-minor-mode))
(after 'guide-key (diminish 'guide-key-mode))
(after 'eldoc (diminish 'eldoc-mode))
(after 'smartparens (diminish 'smartparens-mode))
(after 'company (diminish 'company-mode))
(after 'elisp-slime-nav (diminish 'elisp-slime-nav-mode))
(after 'git-gutter+ (diminish 'git-gutter+-mode))
(after 'highlight-symbol (diminish 'highlight-symbol-mode))
(after 'indent-guide (diminish 'indent-guide-mode))
(after 'hideshow (diminish 'hs-minor-mode))
(after 'ivy (diminish 'ivy-mode))
(after 'helm-mode (diminish 'helm-mode))
(after 'evil-commentary (diminish 'evil-commentary-mode))


(require-package 'smart-mode-line)
(setq sml/show-client t)
(setq sml/show-eol t)
(setq sml/show-frame-identification t)
(sml/setup)


(if (fboundp 'global-prettify-symbols-mode)
    (progn
      (global-prettify-symbols-mode)
      (add-hook 'js2-mode-hook
                (lambda ()
                  (push '("function" . 955) prettify-symbols-alist)
                  (push '("return" . 8592) prettify-symbols-alist))))
  (progn
    (require-package 'pretty-symbols)
    (require 'pretty-symbols)
    (diminish 'pretty-symbols-mode)
    (add-to-list 'pretty-symbol-categories 'js)
    (add-to-list 'pretty-symbol-patterns '(955 js "\\<function\\>" (js2-mode)))
    (add-to-list 'pretty-symbol-patterns '(8592 js "\\<return\\>" (js2-mode)))
    (add-hook 'find-file-hook 'pretty-symbols-mode)))


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


;; this is pretty slow on big files
(require-package 'indent-guide)
(require 'indent-guide)
(setq indent-guide-recursive t)
(add-to-list 'indent-guide-inhibit-modes 'package-menu-mode)
(indent-guide-global-mode)


(add-hook 'find-file-hook 'hl-line-mode)


(provide 'init-eyecandy)
