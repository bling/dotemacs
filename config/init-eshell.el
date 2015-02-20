(defgroup dotemacs-eshell nil
  "Configuration options for eshell-mode."
  :group 'dotemacs
  :prefix 'dotemacs-eshell)

(defcustom dotemacs-eshell/plan9
  nil
  "Turns on Plan9 style prompt in eshell when non-nil."
  :group 'dotemacs-eshell)


;; eshell
(setq eshell-directory-name (concat dotemacs-cache-directory "eshell"))
(setq eshell-scroll-to-bottom-on-input 'all)
(setq eshell-buffer-shorthand t)

(when (executable-find "fortune")
  (defadvice eshell (before advice-for-eshell activate)
    (setq eshell-banner-message (concat (shell-command-to-string "fortune") "\n"))))


;; em-alias
(setq eshell-aliases-file (concat user-emacs-directory ".eshell-aliases"))


;; em-glob
(setq eshell-glob-case-insensitive t)
(setq eshell-error-if-no-glob t)


;; em-hist
(setq eshell-history-size 1024)


;; em-compl
(setq eshell-cmpl-ignore-case t)


;; plan 9 smart shell
(when dotemacs-eshell/plan9
  (after 'esh-module
    (add-to-list 'eshell-modules-list 'eshell-smart)
    (setq eshell-where-to-jump 'begin)
    (setq eshell-review-quick-commands nil)
    (setq eshell-smart-space-goes-to-end t)))


(defun eshell/clear ()
  "Clears the buffer."
  (let ((inhibit-read-only t))
    (erase-buffer)))


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


(defun my-eshell-ido-complete-command-history ()
  (interactive)
  (eshell-kill-input)
  (insert
   (ido-completing-read "Run command: " (delete-dups (ring-elements eshell-history-ring))))
  (eshell-send-input))


(defun eshell/j ()
  "Quickly jump to previous directories."
  (eshell/cd (ido-completing-read "Jump to directory: "
                                  (delete-dups (ring-elements eshell-last-dir-ring)))))


;; em-prompt
(setq eshell-prompt-function #'my-eshell-prompt)


(setq my-eshell-buffer-count 0)
(defun my-new-eshell-split ()
  (interactive)
  (split-window)
  (setq my-eshell-buffer-count (+ 1 my-eshell-buffer-count))
  (eshell my-eshell-buffer-count))


(add-hook 'eshell-mode-hook
	  (lambda ()
	    ;; get rid of annoying 'terminal is not fully functional' warning
	    (when (executable-find "cat")
	      (setenv "PAGER" "cat"))))


(provide 'init-eshell)
