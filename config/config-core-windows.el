;; -*- lexical-binding: t -*-

(defgroup dotemacs-core-windows nil
  "Configuration options for window management and buffer display."
  :group 'dotemacs
  :prefix 'dotemacs-core-windows)

(defcustom dotemacs-core/display-buffer-rules
  '((help-mode           . fixed-right)
    (helpful-mode        . fixed-right)
    (diff-mode           . percent-right)
    (magit-diff-mode     . percent-right)
    (magit-revision-mode . percent-right)
    (ibuffer-mode        . percent-right)
    (grep-mode           . percent-right)
    (ripgrep-search-mode . percent-right)
    (compilation-mode    . percent-bottom)
    ("^\\*helm.*\\*$"    . bottom))
  "Rules for buffer display placement.
Each element is a cons cell (TARGET . POSITION) where:
- TARGET is a major-mode symbol (matched via `derived-mode-p')
  or a regexp string (matched against the buffer name).
- POSITION is one of:
  - `percent-right' (or `right-half'): 50% width on the right
  - `fixed-right': 100 columns fixed on the right
  - `percent-bottom': 30% height at the bottom
  - `bottom': bottom window"
  :type '(repeat
          (cons (choice (symbol :tag "Major Mode")
                        (string :tag "Regexp Buffer Name"))
                (choice (const :tag "Right (50% width)" percent-right)
                        (const :tag "Right (100 columns fixed)" fixed-right)
                        (const :tag "Bottom (30% height)" percent-bottom)
                        (const :tag "Bottom" bottom))))
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
              (when (or (eq pos position)
                        (and (eq position 'percent-right) (eq pos 'right-half)))
                (when (if (symbolp target)
                          (derived-mode-p target)
                        (string-match-p target (buffer-name buf)))
                  (throw 'match t))))))))))

(setq display-buffer-alist
      `(;; half right
        ((lambda (buf _alist)
           (/core/windows/display-buffer-match-p 'percent-right buf))
         (display-buffer-reuse-window display-buffer-in-direction)
         (direction . right)
         (window . root)
         (window-width . 0.5))

        ;; fixed right
        ((lambda (buf _alist)
           (/core/windows/display-buffer-match-p 'fixed-right buf))
         (display-buffer-reuse-window display-buffer-in-direction)
         (direction . right)
         (window . root)
         (window-width . 100))

        ;; bottom 30%
        ((lambda (buf _alist)
           (/core/windows/display-buffer-match-p 'percent-bottom buf))
         (display-buffer-reuse-window display-buffer-in-direction)
         (direction . bottom)
         (window . root)
         (window-height . 0.3))

        ;; bottom
        ((lambda (buf _alist)
           (/core/windows/display-buffer-match-p 'bottom buf))
         (display-buffer-at-bottom))))

(provide 'config-core-windows)
