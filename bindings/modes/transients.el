;; -*- lexical-binding: t -*-

(defun /transients/switch-action (fallback &rest props)
  "Performs an action based on the value of `dotemacs-switch-engine'."
  (cond
   ((and (eq dotemacs-switch-engine 'helm) (plist-get props :helm))
    (call-interactively (plist-get props :helm)))
   ((and (eq dotemacs-switch-engine 'consult) (plist-get props :consult))
    (call-interactively (plist-get props :consult)))
   (t
    (if fallback
        (call-interactively fallback)
      (message "unsupported action")))))

(defalias '/transients/switch-to-buffer
  (bind (/transients/switch-action #'switch-to-buffer :helm #'helm-mini :consult #'consult-buffer)))

(defalias '/transients/imenu
  (bind (/transients/switch-action #'imenu :helm #'helm-semantic-or-imenu :consult #'consult-imenu)))

(defalias '/transients/occur-current
  (bind (/transients/switch-action nil :helm #'helm-occur :consult #'consult-line)))

(defalias '/transients/occur-all
  (bind (/transients/switch-action nil :helm #'helm-occur-visible-buffers :consult #'consult-line-multi)))



(defvar /transients/errors/flymake nil)

(transient-define-prefix /transients/errors ()
  :transient-suffix t
  :transient-non-suffix 'leave
  [["navigation"
    ("j" "next error"
     (lambda () (interactive)
       (if /transients/errors/flymake
           (call-interactively #'flymake-goto-next-error)
         (call-interactively #'next-error))))
    ("k" "previous error"
     (lambda () (interactive)
       (if /transients/errors/flymake
           (call-interactively #'flymake-goto-prev-error)
         (call-interactively #'previous-error))))
    ("t" (lambda () (format "toggle list (%s)" (if /transients/errors/flymake 'flymake 'emacs)))
     (lambda () (interactive) (setq /transients/errors/flymake (not /transients/errors/flymake))))]
   ["flymake"
    ("l" "list errors" flymake-show-buffer-diagnostics :transient nil)
    ("L" "list project errors" flymake-show-project-diagnostics :transient nil)]])



(transient-define-prefix /transients/quit ()
  [("q" "quit" save-buffers-kill-terminal)
   ("r" "restart" restart-emacs)])



(transient-define-prefix /transients/buffers ()
  [["buffers"
    ("b" "buffers" /transients/switch-to-buffer)
    ("m" "goto messages" (lambda () (interactive) (switch-to-buffer "*Messages*")))
    ("s" "goto scratch" /utils/goto-scratch-buffer)]
   ["kill"
    ("k" "kill buffer" kill-current-buffer)
    ("K" "kill other buffers" crux-kill-other-buffers)]
   ["actions"
    ("f" "open in os" crux-open-with)
    ("e" "erase buffer" erase-buffer)
    ("E" "erase buffer (force)" (lambda () (interactive) (let ((inhibit-read-only t)) (erase-buffer))))]])



(transient-define-prefix /transients/jumps ()
  [["jump"
    ("o" "outline in buffer" /transients/imenu)
    ("b" "bookmarks" bookmark-jump)]
   ["lines"
    ("l" "lines in current buffer" /transients/occur-current)
    ("L" "lines in all buffers" /transients/occur-all)]])



(transient-define-prefix /transients/search ()
  [["project"
    ("r" "rg" (lambda () (interactive)
                (cond
                 ((eq dotemacs-switch-engine 'consult)
                  (call-interactively #'consult-ripgrep))
                 ((eq dotemacs-switch-engine 'helm)
                  (call-interactively #'helm-do-grep-ag-project))))
     :if (lambda () (fboundp #'ripgrep-regexp)))]
   ["directory"
    ("R" "rg" ripgrep-regexp
     :if (lambda () (fboundp #'ripgrep-regexp)))]
   ["buffer"
    ("l" "lines" /transients/occur-current)]
   ["buffers"
    ("L" "lines" /transients/occur-all)]
   ["web"
    ("g" "google" /utils/google)]])



(transient-define-prefix /transients/files ()
  [["files"
    ("f" "find files" (lambda () (interactive) (/transients/switch-action #'find-file :helm #'helm-find-files)))
    ("r" "recent files" (lambda () (interactive) (/transients/switch-action nil :helm #'helm-recentf :consult #'consult-recent-file)))
    ("z" "fzf" fzf :if (lambda () (fboundp #'fzf)))]
   ["file ops"
    :if (lambda () (buffer-file-name))
    ("D" "delete" crux-delete-file-and-buffer)
    ("R" "rename" crux-rename-file-and-buffer)]
   ["copy"
    :if (lambda () (buffer-file-name))
    ("y" "copy filename" crux-kill-buffer-truename)
    ("c" "copy file" copy-file)]
   ["admin"
    :if (lambda () (buffer-file-name))
    ("E" "edit as root" crux-sudo-edit)]
   ["convert"
    ("Cd" "to dos" /utils/set-buffer-to-dos-format)
    ("Cu" "to unix" /utils/set-buffer-to-unix-format)]])



(defun /transients/toggles/activate-switch-engine (engine)
  (let ((func (intern (concat "/" (symbol-name dotemacs-switch-engine) "/activate-as-switch-engine"))))
    (funcall func nil))
  (setq dotemacs-switch-engine engine)
  (let ((func (intern (concat "/" (symbol-name engine) "/activate-as-switch-engine"))))
    (funcall func t))
  (message "Switched navigation engine to %s" engine))

(transient-define-prefix /transients/toggles/switch-engine ()
  ["engine"
   ("h" "helm" (lambda () (interactive) (/transients/toggles/activate-switch-engine 'helm)))
   ("c" "consult" (lambda () (interactive) (/transients/toggles/activate-switch-engine 'consult)))
   ("o" "ido" (lambda () (interactive) (/transients/toggles/activate-switch-engine 'ido)))])

(defun /transients/toggle-fmt (label var)
  (format "%s %s" label
          (if (and (boundp var) (symbol-value var))
              (propertize "on" 'face 'transient-value)
            (propertize "off" 'face 'transient-inactive-value))))

(transient-define-prefix /transients/toggles ()
  :transient-suffix t
  [["editing"
    ("a" (lambda () (/transients/toggle-fmt "aggressive indent" 'aggressive-indent-mode)) aggressive-indent-mode)
    ("f" (lambda () (/transients/toggle-fmt "auto-format" 'apheleia-mode)) apheleia-mode)
    ("F" (lambda () (/transients/toggle-fmt "auto-fill" 'auto-fill-function)) auto-fill-mode)
    ("w" (lambda () (/transients/toggle-fmt "whitespace" 'whitespace-mode)) whitespace-mode)]
   ["checks"
    ("m" (lambda () (/transients/toggle-fmt "flymake" 'flymake-mode)) flymake-mode)
    ("s" (lambda () (/transients/toggle-fmt "flyspell" 'flyspell-mode)) flyspell-mode)]
   ["modes"
    ("r" (lambda () (/transients/toggle-fmt "read only" 'buffer-read-only)) read-only-mode)
    ("c" (lambda () (/transients/toggle-fmt "completion" (if (eq dotemacs-completion-engine 'company) 'company-mode 'corfu-mode)))
     (lambda () (interactive)
       (if (eq dotemacs-completion-engine 'company)
           (call-interactively #'company-mode)
         (call-interactively #'corfu-mode))))
    ("p" (lambda () (/transients/toggle-fmt "auto-pairing" 'electric-pair-mode))
     (lambda () (interactive)
       (call-interactively #'electric-pair-mode)))]
   ["display"
    ("t" (lambda () (/transients/toggle-fmt "truncate lines" 'truncate-lines)) toggle-truncate-lines)
    ("n" (lambda () (/transients/toggle-fmt "line numbers" 'display-line-numbers)) display-line-numbers-mode)
    ("W" (lambda () (/transients/toggle-fmt "word wrap" 'word-wrap)) toggle-word-wrap)
    ("b" (lambda () (/transients/toggle-fmt "page break" 'page-break-lines-mode)) page-break-lines-mode)]
   ["debug"
    ("e" (lambda () (/transients/toggle-fmt "debug on error" 'debug-on-error)) toggle-debug-on-error)
    ("g" (lambda () (/transients/toggle-fmt "debug on quit" 'debug-on-quit)) toggle-debug-on-quit)]
   ["tools"
    ("'" (lambda () (format "switch engine: [%s]" dotemacs-switch-engine)) /transients/toggles/switch-engine)]])



(transient-define-prefix /transients/helm ()
  [:if
   (lambda () (fboundp #'helm-M-x))
   ["navigation"
    ("a" "apropos" helm-apropos)
    ("b" "mini" helm-mini)
    ("e" "recentf" helm-recentf)
    ("f" "files" helm-find-files)]
   ["project & bookmarks"
    ("m" "bookmarks" helm-bookmarks)
    ("p" "project" project-find-file)
    ("r" "register" helm-register)
    ("t" "tags" helm-etags-select)]
   ["tools & search"
    ("y" "kill-ring" helm-show-kill-ring)
    ("d" "dash" helm-dash)
    ("x" "M-x" helm-M-x)]
   ["occur"
    ("l" "occur" helm-occur)
    ("L" "occur (multi)" helm-occur-visible-buffers)]])



(transient-define-prefix /transients/consult ()
  [["buffers & files"
    ("b" "mini" consult-buffer)
    ("e" "recentf" consult-recent-file)
    ("f" "files" find-file)
    ("m" "bookmarks" consult-bookmark)]
   ["navigation"
    ("g" "goto line" consult-goto-line)
    ("l" "lines" consult-line)
    ("L" "lines (multi)" consult-line-multi)]
   ["registers & history"
    ("y" "kill-ring" consult-yank-from-kill-ring)
    ("r" "register" consult-register)
    ("x" "M-x" execute-extended-command)]
   ["other"
    ("d" "dash" consult-dash)
    ("E" "errors" consult-flymake)
    ("t" "themes" consult-theme)]])



(transient-define-prefix /transients/git ()
  [["magit"
    ("s" "status" magit-status)
    ("c" "commit" magit-commit)
    ("p" "push" magit-push)]
   ["log / diff"
    ("l" "log" magit-log)
    ("d" "diff" magit-diff)
    ("b" "blame" magit-blame)]
   ["file / merge"
    ("f" "file" magit-file-dispatch)
    ("z" "stash" magit-stash)
    ("m" "merge" magit-merge)]
   ["staging"
    :if (lambda () (buffer-file-name))
    ("a" "+hunk" diff-hl-stage-current-hunk :transient t)
    ("r" "-hunk" diff-hl-revert-hunk :transient t)
    ("A" "+file" magit-file-stage)
    ("R" "-file" magit-file-unstage)]
   ["history"
    :if (lambda () (buffer-file-name))
    ("t" "time machine" git-timemachine)]])



(transient-define-prefix /transients/narrow ()
  [["narrow"
    ("d" "defun" narrow-to-defun)
    ("n" "region" narrow-to-region)
    ("p" "page" narrow-to-page)]
   ["org"
    :if-derived org-mode
    ("b" "org-block" org-narrow-to-block)
    ("e" "org-element" org-narrow-to-element)
    ("s" "org-subtree" org-narrow-to-subtree)]
   ["widen"
    ("w" "widen" widen)]])

(provide 'config-bindings-transients)
