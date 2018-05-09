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

(defun /os/addpath (path)
  (let* ((directory (expand-file-name path))
         (env-value (concat directory path-separator (getenv "PATH"))))
    (when directory
      (setenv "PATH" env-value)
      (setq eshell-path-env env-value)
      (add-to-list 'exec-path directory))))

(/os/addpath (concat user-emacs-directory "bin"))
(dolist (path dotemacs-os/additional-exec-paths)
  (/os/addpath path))

(when (eq system-type 'darwin)
  (require-package 'osx-trash)
  (osx-trash-setup)

  (require-package 'reveal-in-osx-finder)
  (require-package 'vkill))

(defun /os/reveal-in-os ()
  (interactive)
  (if (eq system-type 'windows-nt)
      (start-process "*explorer*" "*explorer*" "explorer.exe"
                     (replace-regexp-in-string "/" "\\\\" (file-name-directory (buffer-file-name))))
    (call-interactively #'reveal-in-osx-finder)))

(provide 'config-os)
