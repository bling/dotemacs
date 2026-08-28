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


(use-package doom-modeline :demand t
  :config
  (doom-modeline-mode t))


(when (fboundp 'global-prettify-symbols-mode)
  (defun /eyecandy/js-symbols ()
    (setq-local
     prettify-symbols-alist
     '(
       ("function" . ?λ)
       ("return" . ?←)
       ("=>". ?⇒)
       (">=". ?≥)
       ("<=". ?≤)
       )))
  (add-hook 'js-mode-hook #'/eyecandy/js-symbols)
  (add-hook 'js-ts-mode-hook #'/eyecandy/js-symbols)
  (add-hook 'typescript-ts-mode-hook #'/eyecandy/js-symbols)
  (add-hook 'tsx-ts-mode-hook #'/eyecandy/js-symbols))


(use-package symbol-overlay
  :hook prog-mode)


(use-package page-break-lines :demand t
  :config
  (global-page-break-lines-mode))


(use-package eros :demand t
  :config
  (eros-mode))


(use-package ultra-scroll :demand t
  :if (display-graphic-p)
  :config
  (ultra-scroll-mode))


(use-package nerd-icons)
(setq inhibit-compacting-font-caches t)

(after 'ibuffer
  (use-package nerd-icons-ibuffer
    :hook ibuffer-mode))

(after 'dired
  (use-package nerd-icons-dired
    :hook dired-mode))

(after 'xref
  (use-package nerd-icons-xref :demand t
    :config
    (nerd-icons-xref-mode)))

(after 'grep
  (use-package nerd-icons-grep :demand t
    :config
    (nerd-icons-grep-mode)))

(after 'marginalia
  (use-package nerd-icons-completion :demand t
    :config
    (nerd-icons-completion-mode)
    (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup)))

(after 'corfu
  (use-package nerd-icons-corfu :demand t
    :config
    (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)))


(add-hook 'find-file-hook #'hl-line-mode)
(add-hook 'find-file-hook #'display-line-numbers-mode)


(provide 'config-eyecandy)
