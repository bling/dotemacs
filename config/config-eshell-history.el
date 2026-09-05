;; -*- lexical-binding: t -*-

(defvar /eshell-history/directories nil
  "List of recently visited directories in Eshell.")

(defvar /eshell-history/count 1000
  "Number of directories to keep in history.")

(after 'savehist
  (add-to-list 'savehist-additional-variables '/eshell-history/directories))

(defun /eshell-history/record ()
  (let ((dir (expand-file-name default-directory)))
    (unless (file-remote-p dir)
      (setq /eshell-history/directories (cons dir (delete dir /eshell-history/directories))) ;; MRU order
      (when (> (length /eshell-history/directories) /eshell-history/count)
        (setcdr (nthcdr (- /eshell-history/count 1) /eshell-history/directories) nil)))))

(add-hook 'eshell-mode-hook #'/eshell-history/record)
(add-hook 'eshell-directory-change-hook #'/eshell-history/record)

(defun eshell/z (&rest args)
  "Jump to directory."
  (setq /eshell-history/directories (seq-filter #'file-directory-p /eshell-history/directories))
  (eshell/cd (completing-read "Jump to: " /eshell-history/directories nil t
                              (when args
                                (string-join (mapcar #'eshell-stringify (flatten-tree args)) " ")))))

(defun pcomplete/z ()
  (pcomplete-here* /eshell-history/directories))

(defalias 'eshell/j #'eshell/z)
(defalias 'pcomplete/j #'pcomplete/z)

(provide 'config-eshell-history)
