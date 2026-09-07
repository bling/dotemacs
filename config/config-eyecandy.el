;; -*- lexical-binding: t -*-


(show-paren-mode t)
(line-number-mode t)
(column-number-mode t)
(display-time-mode t)
(size-indication-mode t)


(defun /eyecandy/fold-overlay (ov)
  (when (eq 'code (overlay-get ov 'hs))
    (let ((col (save-excursion
                 (move-end-of-line 0)
                 (current-column)))
          (count (count-lines (overlay-start ov) (overlay-end ov))))
      (overlay-put ov 'after-string
                   (format "%s [ %d ] ... "
                           (make-string (max 0 (- (window-width) col 32)) (string-to-char "."))
                           count)))))
(setq hs-set-up-overlay '/eyecandy/fold-overlay)
(add-hook 'prog-mode-hook #'hs-minor-mode)


(use-package doom-modeline
  :config
  (doom-modeline-mode t))


(when (fboundp 'global-prettify-symbols-mode)
  (defun /eyecandy/set-pretty-symbols ()
    (setq-local prettify-symbols-alist '(
                                         ("function" . ?λ)
                                         ("return" . ?←)
                                         ("=>". ?⇒)
                                         (">=". ?≥)
                                         ("<=". ?≤)
                                         )))
  (add-hook 'js-base-mode-hook #'/eyecandy/set-pretty-symbols)
  (add-hook 'typescript-ts-base-mode #'/eyecandy/set-pretty-symbols))


(use-package symbol-overlay
  :hook prog-mode)


(use-package page-break-lines
  :config
  (global-page-break-lines-mode))


(use-package eros
  :config
  (eros-mode))


(when (and (display-graphic-p) (eq system-type 'darwin))
  (use-package ultra-scroll
    :config
    (ultra-scroll-mode)))


(setq inhibit-compacting-font-caches t)
(use-package nerd-icons :defer t)
(use-package nerd-icons-ibuffer :hook ibuffer-mode)
(use-package nerd-icons-dired :hook dired-mode)
(use-package nerd-icons-xref :config (nerd-icons-xref-mode))
(use-package nerd-icons-grep :config (nerd-icons-grep-mode))
(use-package nerd-icons-completion
  :config
  (nerd-icons-completion-mode)
  (after 'marginalia
    (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup)))
(when (eq dotemacs-switch-engine 'consult)
  (use-package nerd-icons-corfu
    :after corfu
    :config
    (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)))


(add-hook 'find-file-hook #'hl-line-mode)
(add-hook 'find-file-hook #'display-line-numbers-mode)


(provide 'config-eyecandy)
