(defcustom dotemacs-os/additional-exec-paths
  nil
  "Additional paths to be added to `exec-path'."
  :type '(repeat (string))
  :group 'dotemacs)

(if (eq system-type 'windows-nt)
    (dolist (path (split-string (getenv "PATH") ";"))
      (add-to-list 'exec-path (replace-regexp-in-string "\\\\" "/" path)))
  (require-package 'exec-path-from-shell)
  (exec-path-from-shell-initialize))

(add-to-list 'exec-path (expand-file-name (concat user-emacs-directory "bin")))
(dolist (path dotemacs-os/additional-exec-paths)
  (add-to-list 'exec-path path))

(setq eshell-path-env (mapconcat #'identity exec-path path-separator))

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
