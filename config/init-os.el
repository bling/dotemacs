(setenv "PATH" (concat (getenv "PATH")
                       (if (eq system-type 'windows-nt) ";" ":")
                       (expand-file-name (concat user-emacs-directory "bin"))))

(if (eq system-type 'windows-nt)
    (dolist (path (split-string (getenv "PATH") ";"))
      (add-to-list 'exec-path (replace-regexp-in-string "\\\\" "/" path)))
  (require-package 'exec-path-from-shell)
  (exec-path-from-shell-initialize))

(when (eq system-type 'darwin)
  (require-package 'osx-trash)
  (osx-trash-setup)

  (require-package 'reveal-in-osx-finder)
  (require-package 'vkill)
  (evilify vkill-mode vkill-mode-map))

(when (eq system-type 'windows-nt)
  (defun reveal-in-osx-finder ()
    (interactive)
    (start-process "*explorer*" "*explorer*" "explorer.exe"
                   (replace-regexp-in-string "/" "\\\\" (file-name-directory (buffer-file-name))))))

(provide 'init-os)
