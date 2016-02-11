
(if (eq system-type 'windows-nt)
    (progn
      (dolist (path (split-string (getenv "PATH") ";"))
        (add-to-list 'exec-path (replace-regexp-in-string "\\\\" "/" path))))
  (progn
    (require-package 'exec-path-from-shell)
    (exec-path-from-shell-initialize)))

(when (eq system-type 'darwin)
  (require-package 'reveal-in-osx-finder)
  (require-package 'vkill))
