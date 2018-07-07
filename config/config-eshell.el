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

(defcustom dotemacs-eshell/visual-commands
  '("ssh" "htop" "top" "tail" "tmux")
  "Turns on additional git information in the prompt."
  :group 'dotemacs-eshell
  :type '(repeat string))



(setq eshell-directory-name (concat dotemacs-cache-directory "eshell"))
(setq eshell-buffer-maximum-lines 20000)
(setq eshell-scroll-to-bottom-on-input 'this)
(setq eshell-buffer-shorthand t)
(setq eshell-aliases-file (concat user-emacs-directory ".eshell-aliases"))
(setq eshell-glob-case-insensitive t)
(setq eshell-error-if-no-glob t)
(setq eshell-history-size (* 10 1024))
(setq eshell-hist-ignoredups t)
(setq eshell-cmpl-ignore-case t)
(setq eshell-prompt-function
      (lambda ()
        (concat (propertize (abbreviate-file-name (eshell/pwd)) 'face 'eshell-prompt)
                (when (and dotemacs-eshell/prompt-git-info
                           (fboundp #'vc-git-branches))
                  (let ((branch (car (vc-git-branches))))
                    (when branch
                      (concat
                       (propertize " [" 'face 'font-lock-keyword-face)
                       (propertize branch 'face 'font-lock-function-name-face)
                       (let* ((status (shell-command-to-string "git status --porcelain"))
                              (parts (split-string status "\n" t " "))
                              (states (mapcar #'string-to-char parts))
                              (added (count-if (lambda (char) (= char ?A)) states))
                              (modified (count-if (lambda (char) (= char ?M)) states))
                              (deleted (count-if (lambda (char) (= char ?D)) states)))
                         (when (> (+ added modified deleted) 0)
                           (propertize (format " +%d ~%d -%d" added modified deleted) 'face 'font-lock-comment-face)))
                       (propertize "]" 'face 'font-lock-keyword-face)))))
                (propertize " $ " 'face 'font-lock-constant-face))))


(when (executable-find "fortune")
  (defadvice eshell (before dotemacs activate)
    (setq eshell-banner-message (concat (shell-command-to-string "fortune") "\n"))))


;; plan 9 smart shell
(when dotemacs-eshell/plan9
  (after 'esh-module
    (add-to-list 'eshell-modules-list 'eshell-smart)
    (setq eshell-where-to-jump 'begin)
    (setq eshell-review-quick-commands nil)
    (setq eshell-smart-space-goes-to-end t)))


(defun eshell/ff (&rest args)
  "Opens a file in emacs."
  (when (not (null args))
    (mapc #'find-file (mapcar #'expand-file-name (eshell-flatten-list (reverse args))))))


(defun eshell/h ()
  "Quickly run a previous command."
  (insert (completing-read
           "Run previous command: "
           (delete-dups (ring-elements eshell-history-ring))
           nil
           t)))


(defun eshell/ssh-tramp (&rest args)
  (insert (apply #'format "cd /ssh:%s:\\~" args))
  (eshell-send-input))


(defun /eshell/color-filter (string)
  (let ((case-fold-search nil)
        (lines (split-string string "\n")))
    (cl-loop for line in lines
             do (progn
                  (cond ((string-match "\\[DEBUG\\]" line)
                         (put-text-property 0 (length line) 'font-lock-face font-lock-comment-face line))
                        ((string-match "\\[INFO\\]" line)
                         (put-text-property 0 (length line) 'font-lock-face compilation-info-face line))
                        ((string-match "\\[WARN\\]" line)
                         (put-text-property 0 (length line) 'font-lock-face compilation-warning-face line))
                        ((string-match "\\[ERROR\\]" line)
                         (put-text-property 0 (length line) 'font-lock-face compilation-error-face line)))))
    (mapconcat 'identity lines "\n")))


(after 'em-term
  (dolist (cmd dotemacs-eshell/visual-commands)
    (add-to-list 'eshell-visual-commands cmd)))


(eval-when-compile (require 'cl))
(lexical-let ((count 0))
  (defun /eshell/new-split ()
    (interactive)
    (split-window)
    (eshell (incf count))))


(after "magit-autoloads"
  (defalias 'eshell/s #'magit-status))


(require-package 'eshell-z)
(setq eshell-z-freq-dir-hash-table-file-name (concat dotemacs-cache-directory "eshell/z"))
(defalias 'eshell/j #'eshell/z)

(defun eshell/z-clean ()
  (let* ((directories (hash-table-keys eshell-z-freq-dir-hash-table))
         (non-existent (cl-remove-if #'file-exists-p directories)))
    (cl-loop for dir in non-existent
             do (remhash (eshell-z--expand-directory-name dir)
                         eshell-z-freq-dir-hash-table))
    (eshell-z--write-freq-dir-hash-table)))


(defun /eshell/eshell-mode-hook ()
  (require 'eshell-z)

  (add-to-list 'eshell-output-filter-functions #'eshell-truncate-buffer)
  (add-to-list 'eshell-preoutput-filter-functions #'/eshell/color-filter)

  ;; get rid of annoying 'terminal is not fully functional' warning
  (when (executable-find "cat")
    (setenv "PAGER" "cat"))

  (setenv "NODE_NO_READLINE" "1"))

(add-hook 'eshell-mode-hook #'/eshell/eshell-mode-hook)


(provide 'config-eshell)
