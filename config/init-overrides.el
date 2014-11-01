;; always 2 char jumping
(after 'ace-jump-mode
  (defun ace-jump-char-mode (query-char1 query-char2)
    "AceJump char mode"
    (interactive (list (read-char "Query Char (1/2):") (read-char "Query Char (2/2):")))

    ;; We should prevent recursion call this function.  This can happen
    ;; when you trigger the key for ace jump again when already in ace
    ;; jump mode.  So we stop the previous one first.
    (if ace-jump-current-mode (ace-jump-done))

    (if (or (eq (ace-jump-char-category query-char1) 'other)
            (eq (ace-jump-char-category query-char2) 'other))
        (error "[AceJump] Non-printable character"))

    ;; others : digit , alpha, punc
    (setq ace-jump-query-char query-char1)
    (setq ace-jump-current-mode 'ace-jump-char-mode)
    (ace-jump-do (regexp-quote (string query-char1 query-char2)))))


(provide 'init-overrides)
