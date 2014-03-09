;; eshell
(setq eshell-directory-name (concat user-emacs-directory ".cache/eshell"))
(setq eshell-scroll-to-bottom-on-input 'all)
(setq eshell-buffer-shorthand t)


;; em-alias
(setq eshell-aliases-file (concat user-emacs-directory ".eshell-aliases"))


;; em-glob
(setq eshell-glob-case-insensitive t)
(setq eshell-error-if-no-glob t)


(defun eshell/ff (&rest args)
  "Opens a file in emacs."
  (when (not (null args))
    (mapc #'find-file (mapcar #'expand-file-name (eshell-flatten-list (reverse args))))))


(defun my-current-git-branch ()
  (let ((branch (car (loop for match in (split-string (shell-command-to-string "git branch") "\n")
                            when (string-match "^\*" match)
                            collect match))))
    (if (not (eq branch nil))
        (concat " [" (substring branch 2) "]")
      "")))


(defun my-eshell-prompt ()
  (concat (propertize (abbreviate-file-name (eshell/pwd)) 'face 'eshell-prompt)
          (propertize (my-current-git-branch) 'face 'font-lock-function-name-face)
          (propertize " $ " 'face 'font-lock-constant-face)))


;; em-prompt
(setq eshell-prompt-function 'my-eshell-prompt)
(setq eshell-highlight-prompt nil)


(provide 'init-eshell)
