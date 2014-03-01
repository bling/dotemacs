(add-hook
 'after-init-hook
 (lambda ()
   ;; always 2 char jumping
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
     (ace-jump-do (regexp-quote (string query-char1 query-char2))))


   ;; fixes git-grep usage in windows by replacing "'*'" with ""
   (defun projectile-grep ()
     "Perform rgrep in the project."
     (interactive)
     (let ((roots (projectile-get-project-directories))
           (search-regexp (if (and transient-mark-mode mark-active)
                              (buffer-substring (region-beginning) (region-end))
                            (read-string (projectile-prepend-project-name "Grep for: ")
                                         (projectile-symbol-at-point)))))
       (dolist (root-dir roots)
         (require 'grep)
         ;; in git projects users have the option to use `vc-git-grep' instead of `rgrep'
         (if (and (eq (projectile-project-vcs) 'git) projectile-use-git-grep)
             (vc-git-grep search-regexp "" root-dir)
           ;; paths for find-grep should relative and without trailing /
           (let ((grep-find-ignored-directories (-union (-map (lambda (dir) (s-chop-suffix "/" (file-relative-name dir root-dir)))
                                                              (cdr (projectile-ignored-directories))) grep-find-ignored-directories))
                 (grep-find-ignored-files (-union (-map (lambda (file) (file-relative-name file root-dir)) (projectile-ignored-files)) grep-find-ignored-files)))
             (grep-compute-defaults)
             (rgrep search-regexp "* .*" root-dir))))))))

(provide 'init-overrides)
