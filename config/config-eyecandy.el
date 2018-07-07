(defgroup dotemacs-eyecandy nil
  "Configuration options for eye candy."
  :group 'dotemacs
  :prefix 'dotemacs-eyecandy)

(defcustom dotemacs-eyecandy/mode-line
  'spaceline
  "List of hooks to automatically start up in Evil Emacs state."
  :type '(radio
          (const :tag "smart mode line" sml)
          (const :tag "doom" doom)
          (const :tag "spaceline" spaceline))
  :group 'dotemacs-eyecandy)

(defcustom dotemacs-eyecandy/folding
  'origami
  "The library to use for folding."
  :type '(radio
          (const :tag "origami" origami)
          (const :tag "hide-show" hide-show))
  :group 'dotemacs-eyecandy)



(when (eq dotemacs-pair-engine 'emacs)
  (show-paren-mode)
  (setq show-paren-delay 0))


(line-number-mode t)
(column-number-mode t)
(display-time-mode t)
(size-indication-mode t)


(cond
 ((eq dotemacs-eyecandy/folding 'origami)
  (progn
    (require-package 'origami)
    (global-origami-mode)))
 ((eq dotemacs-eyecandy/folding 'hide-show)
  (progn
    (defun /eyecandy/fold-overlay (ov)
      (when (eq 'code (overlay-get ov 'hs))
        (let ((col (save-excursion
                     (move-end-of-line 0)
                     (current-column)))
              (count (count-lines (overlay-start ov) (overlay-end ov))))
          (overlay-put ov 'after-string
                       (format "%s [ %d ] ... "
                               (make-string (- (window-width) col 32) (string-to-char "."))
                               count)))))
    (setq hs-set-up-overlay '/eyecandy/fold-overlay)
    (add-hook 'prog-mode-hook #'hs-minor-mode))))


(require-package 'diminish)
(diminish 'visual-line-mode)
(after 'aggressive-indent (diminish 'aggressive-indent-mode))
(after 'auto-complete (diminish 'auto-complete-mode))
(after 'autorevert (diminish #'auto-revert-mode))
(after 'color-identifiers-mode (diminish 'color-identifiers-mode))
(after 'company (diminish 'company-mode))
(after 'counsel (diminish #'counsel-mode))
(after 'eldoc (diminish 'eldoc-mode))
(after 'elisp-slime-nav (diminish 'elisp-slime-nav-mode))
(after 'evil-commentary (diminish 'evil-commentary-mode))
(after 'flycheck (diminish 'flycheck-mode))
(after 'git-gutter+ (diminish 'git-gutter+-mode))
(after 'helm-mode (diminish 'helm-mode))
(after 'hideshow (diminish 'hs-minor-mode))
(after 'highlight-symbol (diminish 'highlight-symbol-mode))
(after 'indent-guide (diminish 'indent-guide-mode))
(after 'ivy (diminish 'ivy-mode))
(after 'page-break-lines (diminish 'page-break-lines-mode))
(after 'projectile (diminish 'projectile-mode))
(after 'smartparens (diminish 'smartparens-mode))
(after 'undo-tree (diminish 'undo-tree-mode))
(after 'which-key (diminish 'which-key-mode))
(after 'yasnippet (diminish 'yas-minor-mode))


(cond
 ((eq dotemacs-eyecandy/mode-line 'sml)
  (require-package 'smart-mode-line)
  (sml/setup)
  (after 'evil
    (defvar dotemacs--original-mode-line-bg (face-background 'mode-line))
    (defadvice evil-set-cursor-color (after dotemacs activate)
      (cond ((evil-emacs-state-p)
             (set-face-background 'mode-line "#440000"))
            ((evil-insert-state-p)
             (set-face-background 'mode-line "#002244"))
            ((evil-visual-state-p)
             (set-face-background 'mode-line "#440044"))
            (t
             (set-face-background 'mode-line dotemacs--original-mode-line-bg))))))
 ((eq dotemacs-eyecandy/mode-line 'spaceline)
  (require-package 'spaceline)
  (require 'spaceline-config)
  (setq spaceline-highlight-face-func #'spaceline-highlight-face-evil-state)
  (set-face-attribute 'spaceline-evil-emacs nil :background "red" :foreground "white")
  (spaceline-spacemacs-theme)
  (spaceline-info-mode)
  (after "helm-autoloads"
    (spaceline-helm-mode)))
 ((eq dotemacs-eyecandy/mode-line 'doom)
  (require-package 'doom-modeline)
  (doom-modeline-init)))


(when (fboundp 'global-prettify-symbols-mode)
  (global-prettify-symbols-mode)
  (add-hook 'js2-mode-hook
            (lambda ()
              (push '("function" . 955) prettify-symbols-alist)
              (push '("return" . 8592) prettify-symbols-alist))))


(/boot/delayed-init
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


(require-package 'eval-sexp-fu)
(require 'eval-sexp-fu)
(eval-sexp-fu-flash-mode)


(when (and (display-graphic-p)
           (font-info "all-the-icons"))
  (setq all-the-icons-scale-factor 0.7)
  (setq inhibit-compacting-font-caches t)

  (after 'dired
    (require-package 'all-the-icons-dired)
    (add-hook 'dired-mode-hook #'all-the-icons-dired-mode))

  (after 'ivy
    (require-package 'all-the-icons-ivy)
    (all-the-icons-ivy-setup)))


(add-hook 'find-file-hook #'hl-line-mode)

(if (fboundp #'display-line-numbers-mode)
    (add-hook 'find-file-hook #'display-line-numbers-mode)
  (add-hook 'find-file-hook 'linum-mode))


(provide 'config-eyecandy)
