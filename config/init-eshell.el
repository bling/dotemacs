(require 'eshell)
(setq eshell-directory-name (concat user-emacs-directory ".cache/eshell"))
(setq eshell-scroll-to-bottom-on-input 'all)
(setq eshell-buffer-shorthand t)


(require 'em-alias)
(setq eshell-aliases-file (concat user-emacs-directory ".eshell-aliases"))


(require 'em-glob)
(setq eshell-glob-case-insensitive t)
(setq eshell-error-if-no-glob t)


(defun eshell/ff (&rest args)
  "Opens a file in emacs."
  (when (not (null args))
    (mapc #'find-file (mapcar #'expand-file-name (eshell-flatten-list (reverse args))))))

       (string-match "m" "* master")


(defun my-current-git-branch ()
  (let ((branch (car (loop for match in (split-string (shell-command-to-string "git branch") "\n")
                            when (string-match "^\*" match)
                            collect match))))
    (if (not (eq branch nil))
        (concat " [" (substring branch 2) "]")
      nil)))


(defun my-eshell-prompt ()
  (concat (eshell/pwd)
          (my-current-git-branch)
          " $ "))


(require 'em-prompt)
(setq eshell-prompt-function 'my-eshell-prompt)
