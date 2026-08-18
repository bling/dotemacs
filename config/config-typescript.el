;; -*- lexical-binding: t -*-

(defgroup dotemacs-typescript nil
  "Configuration options for TypeScript."
  :group 'dotemacs
  :prefix 'dotemacs-typescript)

(defcustom dotemacs-typescript/engine
  'lsp
  "The engine to drive TypeScript."
  :type '(radio
          (const :tag "eglot" eglot)
          (const :tag "lsp" lsp))
  :group 'dotemacs-typescript)



(when (fboundp 'typescript-ts-mode)
  (add-to-list 'auto-mode-alist '("\\.[mc]?ts\\'" . typescript-ts-mode))
  (add-hook 'typescript-ts-mode-hook #'/utils/activate-lsp))

(when (fboundp 'tsx-ts-mode)
  (add-to-list 'auto-mode-alist '("\\.[mc]?tsx\\'" . tsx-ts-mode))
  (add-hook 'tsx-ts-mode-hook #'/utils/activate-lsp))

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
