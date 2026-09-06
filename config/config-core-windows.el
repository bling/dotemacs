;; -*- lexical-binding: t -*-

(defgroup dotemacs-core-windows nil
  "Configuration options for window management and buffer display."
  :group 'dotemacs
  :prefix 'dotemacs-core-windows)

(defcustom dotemacs-core/display-buffer-rules
  '((help-mode           . right-fixed)
    (helpful-mode        . right-fixed)
    (diff-mode           . right-half)
    (magit-diff-mode     . right-half)
    (magit-revision-mode . right-half)
    (ibuffer-mode        . right-half)
    (grep-mode           . right-half)
    (ripgrep-search-mode . right-half)
    (compilation-mode    . bottom)
    (vc-annotate-mode    . full-screen)
    (magit-status-mode   . full-screen)
    ("^\\*helm.*\\*$"    . bottom))
  "Rules for buffer display placement.
Each element is a cons cell (TARGET . POSITION) where:
- TARGET is a major-mode symbol (matched via `derived-mode-p')
  or a regexp string (matched against the buffer name).
- POSITION is one of:
  - `right-half': 50% width on the right
  - `right-fixed': 100 columns fixed on the right
  - `bottom': bottom window
  - `full-screen': full frame"
  :type '(repeat
          (cons (choice (symbol :tag "Major Mode")
                        (string :tag "Regexp Buffer Name"))
                (choice (const :tag "Right (50% width)" right-half)
                        (const :tag "Right (100 columns fixed)" right-fixed)
                        (const :tag "Bottom" bottom)
                        (const :tag "Full screen" full-screen))))
  :group 'dotemacs-core-windows)

(defun /core/windows/display-buffer-match-p (position buffer)
  "Return non-nil if BUFFER matches a rule in `dotemacs-core/display-buffer-rules' with POSITION."
  (let ((buf (get-buffer buffer)))
    (when (buffer-live-p buf)
      (with-current-buffer buf
        (catch 'match
          (dolist (entry dotemacs-core/display-buffer-rules)
            (let ((target (car entry))
                  (pos (cdr entry)))
              (when (eq pos position)
                (when (if (symbolp target)
                          (derived-mode-p target)
                        (string-match-p target (buffer-name buf)))
                  (throw 'match t))))))))))

(setq display-buffer-alist
      `(;; full screen
        ((lambda (buf _alist)
           (/core/windows/display-buffer-match-p 'full-screen buf))
         (display-buffer-full-frame))

        ;; half right
        ((lambda (buf _alist)
           (/core/windows/display-buffer-match-p 'right-half buf))
         (display-buffer-reuse-window display-buffer-in-direction)
         (direction . right)
         (window . root)
         (window-width . 0.5))

        ;; fixed right
        ((lambda (buf _alist)
           (/core/windows/display-buffer-match-p 'right-fixed buf))
         (display-buffer-reuse-window display-buffer-in-direction)
         (direction . right)
         (window . root)
         (window-width . 100))

        ;; bottom
        ((lambda (buf _alist)
           (/core/windows/display-buffer-match-p 'bottom buf))
         (display-buffer-at-bottom))))

(provide 'config-core-windows)
