;; -*- lexical-binding: t -*-

(defcustom dotemacs-os/additional-exec-paths
  nil
  "Additional paths to be added to `exec-path'."
  :type '(repeat (string))
  :group 'dotemacs)

(if (eq system-type 'windows-nt)
    (dolist (path (split-string (getenv "PATH") ";"))
      (add-to-list 'exec-path (replace-regexp-in-string "\\\\" "/" path)))
  (use-package exec-path-from-shell :demand t
    :config
    (exec-path-from-shell-initialize)))

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
  (use-package reveal-in-osx-finder))

(defun /os/reveal-in-os ()
  (interactive)
  (let ((dir (file-name-directory (or (buffer-file-name) default-directory))))
    (pcase system-type
      ('windows-nt
       (start-process "*explorer*" "*explorer*" "explorer.exe"
                      (replace-regexp-in-string "/" "\\\\" dir)))
      ('darwin
       (call-interactively #'reveal-in-osx-finder))
      (_
       (if (executable-find "xdg-open")
           (start-process "*xdg-open*" nil "xdg-open" dir)
         (dired dir))))))

(provide 'config-os)
