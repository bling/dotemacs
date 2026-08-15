;; -*- lexical-binding: t -*-


(when (eq dotemacs-pair-engine 'emacs)
  (show-paren-mode)
  (setq show-paren-delay 0))


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


(require-package 'doom-modeline)
(require 'doom-modeline)
(doom-modeline-mode t)


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
  (add-hook 'js2-mode-hook #'/eyecandy/js-symbols)
  (add-hook 'typescript-mode-hook #'/eyecandy/js-symbols))


(require-package 'symbol-overlay)
(add-hook 'prog-mode-hook #'symbol-overlay-mode)


(require-package 'page-break-lines)
(global-page-break-lines-mode)


(require-package 'eros)
(eros-mode)


(when (display-graphic-p)
  (require-package 'nerd-icons)
  (setq inhibit-compacting-font-caches t)

  (after 'ibuffer
    (require-package 'nerd-icons-ibuffer)
    (add-hook 'ibuffer-mode-hook #'nerd-icons-ibuffer-mode))

  (after 'dired
    (require-package 'nerd-icons-dired)
    (add-hook 'dired-mode-hook #'nerd-icons-dired-mode))

  (after 'xref
    (require-package 'nerd-icons-xref)
    (nerd-icons-xref-mode))

  (after 'grep
    (require-package 'nerd-icons-grep)
    (nerd-icons-grep-mode))

  (after 'marginalia
    (require-package 'nerd-icons-completion)
    (nerd-icons-completion-mode)
    (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

  (after 'corfu
    (require-package 'nerd-icons-corfu)
    (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)))


(add-hook 'find-file-hook #'hl-line-mode)
(add-hook 'find-file-hook #'display-line-numbers-mode)


(provide 'config-eyecandy)
