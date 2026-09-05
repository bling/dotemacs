;; -*- lexical-binding: t -*-

(require 'cl-lib)

(defgroup dotemacs-eshell nil
  "Configuration options for eshell-mode."
  :group 'dotemacs
  :prefix 'dotemacs-eshell)

(defcustom dotemacs-eshell/plan9
  nil
  "Turns on Plan9 style prompt in eshell when non-nil."
  :group 'dotemacs-eshell
  :type 'boolean)

(defcustom dotemacs-eshell/prompt-git-info
  (executable-find "git")
  "Turns on additional git information in the prompt."
  :group 'dotemacs-eshell
  :type 'boolean)



(setq eshell-directory-name (concat dotemacs-cache-directory "eshell/"))
(setq eshell-buffer-maximum-lines 20000)
(setq eshell-scroll-to-bottom-on-input 'this)
(setq eshell-aliases-file (concat user-emacs-directory ".eshell-aliases"))
(setq eshell-glob-case-insensitive t)
(setq eshell-error-if-no-glob t)
(setq eshell-history-size (* 10 1024))
(setq eshell-hist-ignoredups t)
(setq eshell-cmpl-ignore-case t)
(setq eshell-history-isearch 'dwim)
(setq eshell-prompt-function
      (lambda ()
        (concat (propertize (abbreviate-file-name (eshell/pwd)) 'face 'eshell-prompt)
                (when (and dotemacs-eshell/prompt-git-info
                           (not (file-remote-p default-directory))
                           (fboundp #'vc-git-branches))
                  (let ((branch (car (vc-git-branches))))
                    (when branch
                      (concat
                       (propertize " [" 'face 'font-lock-keyword-face)
                       (propertize branch 'face 'font-lock-function-name-face)
                       (let* ((status (shell-command-to-string "git status --porcelain"))
                              (lines (split-string status "\n" t))
                              (added 0)
                              (modified 0)
                              (deleted 0))
                         (dolist (line lines)
                           (let ((x (and (> (length line) 0) (aref line 0)))
                                 (y (and (> (length line) 1) (aref line 1))))
                             (when (or (eq x ?A) (eq y ?A)) (cl-incf added))
                             (when (or (eq x ?M) (eq y ?M)) (cl-incf modified))
                             (when (or (eq x ?D) (eq y ?D)) (cl-incf deleted))))
                         (when (> (+ added modified deleted) 0)
                           (propertize (format " +%d ~%d -%d" added modified deleted) 'face 'font-lock-comment-face)))
                       (propertize "]" 'face 'font-lock-keyword-face)))))
                (propertize " λ " 'face 'font-lock-constant-face))))
(setq eshell-prompt-regexp "^[^λ\n]* λ ")

(when (executable-find "fortune")
  (advice-add
   'eshell :before
   (lambda (&rest _)
     (setq eshell-banner-message (concat (shell-command-to-string "fortune") "\n")))))

(unless (eq system-type 'windows-nt)
  ;; prevents freezing when used on a large number of files/directories
  (after 'em-unix
    (fmakunbound 'eshell/cat)
    (fmakunbound 'eshell/cp)
    (fmakunbound 'eshell/du)
    (fmakunbound 'eshell/mv)
    (fmakunbound 'eshell/rm)
    (fmakunbound 'eshell/rmdir)))

;; plan 9 smart shell
(when dotemacs-eshell/plan9
  (after 'esh-module
    (add-to-list 'eshell-modules-list 'eshell-smart)
    (setq eshell-where-to-jump 'begin)
    (setq eshell-review-quick-commands nil)
    (setq eshell-smart-space-goes-to-end t)))

(defun eshell/ff (&rest args)
  "Opens a file in emacs."
  (if (null args)
      (call-interactively #'find-file)
    (mapc #'find-file (mapcar #'expand-file-name (flatten-tree (reverse args))))))

(defun eshell/h ()
  "Quickly run a previous command."
  (insert (completing-read
           "Run previous command: "
           (delete-dups (ring-elements eshell-history-ring)) nil t)))

(defun eshell/ssh-tramp (&rest args)
  (insert (apply #'format "cd /ssh:%s:\\~" args))
  (eshell-send-input))

(let ((count 0))
  (defun /eshell/new-split ()
    (interactive)
    (split-window)
    (eshell (cl-incf count))))

(after "magit-autoloads"
  (defalias 'eshell/s #'magit-status))

(defun /eshell/eshell-mode-hook ()
  (add-to-list 'eshell-output-filter-functions #'eshell-truncate-buffer)
  (buffer-disable-undo)

  (setq-local completion-styles '(basic partial-completion emacs22))
  (setq-local process-environment (copy-sequence process-environment))

  ;; get rid of annoying 'terminal is not fully functional' warning
  (when (executable-find "cat")
    (setenv "PAGER" "cat"))

  (setenv "NODE_NO_READLINE" "1"))

(add-hook 'eshell-mode-hook #'/eshell/eshell-mode-hook)

(provide 'config-eshell)
