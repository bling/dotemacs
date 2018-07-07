(defgroup dotemacs-typescript nil
  "Configuration options for TypeScript."
  :group 'dotemacs
  :prefix 'dotemacs-typescript)

(defcustom dotemacs-typescript/tide-format-before-save t
  "If non-nil, will auto format the buffer with tide prior to saving."
  :group 'dotemacs-typescript
  :type 'boolean)

(defcustom dotemacs-typescript/engine
  'tide
  "The engine to drive TypeScript."
  :type '(radio
          (const :tag "tide" tide)
          (const :tag "lsp" lsp))
  :group 'dotemacs-typescript)



(defun /typescript/setup ()
  (cond
   ((eq dotemacs-typescript/engine 'tide)
    (require-package 'tide)
    (setq tide-completion-detailed t)
    (setq tide-completion-ignore-case t)
    (setq tide-always-show-documentation t)
    (when dotemacs-typescript/tide-format-before-save
      (add-hook 'before-save-hook #'tide-format-before-save))

    (tide-setup)
    (tide-hl-identifier-mode t)
    (eldoc-mode t))
   ((eq dotemacs-typescript/engine 'lsp)
    (/lsp/activate 'lsp-typescript))))

(when (eq dotemacs-typescript/engine 'tide)
  (after [tide evil]
    (defadvice tide-jump-to-definition (before dotemacs activate)
      (evil-set-jump)))

  (after [tide flycheck]
    (flycheck-add-mode 'typescript-tslint 'web-mode)))

(/boot/lazy-major-mode "\\.ts$" typescript-mode)
(add-hook 'typescript-mode-hook #'/typescript/setup)

(/boot/lazy-major-mode "\\.tsx$" web-mode)
(add-hook 'web-mode-hook
          (defun /typescript/web-mode-hook ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (/typescript/setup))))

(defun /typescript/generate-typings-for-css ()
  "Generates a Typescript type definition file for the current CSS file."
  (interactive)
  (unless (s-ends-with-p "\.css" (buffer-file-name))
    (error "The current buffer is not a CSS file"))
  (let ((pos 0)
        (string (substring-no-properties (buffer-string)))
        matches)
    (while (string-match "^\.\\(\\w\\|-\\)+" string pos)
      (push (s-lower-camel-case (substring (match-string 0 string) 1)) matches)
      (setq pos (match-end 0)))
    (with-temp-file (concat (buffer-file-name) ".d.ts")
      (dolist (m (reverse matches))
        (insert (format "export const %s: string;\n" m))))))

(provide 'config-typescript)
