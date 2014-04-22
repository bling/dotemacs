;;; pt.el --- A front-end for pt, The Platinum Searcher.

;; Copyright (C) 2014 Bailey Ling <bling@live.ca>

;;; Commentary:

;;; License:

;; This file is not part of GNU Emacs.
;; However, it is distributed under the same license.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:
(eval-when-compile (require 'cl))
(require 'compile)
(require 'grep)
(require 'thingatpt)

;; copied from ag.el/ag-filter
(defun pt--filter ()
  "Handle match highlighting escape sequences inserted by the pt process.
This function is called from `compilation-filter-hook'."
  (save-excursion
    (forward-line 0)
    (let ((end (point)) beg)
      (goto-char compilation-filter-start)
      (forward-line 0)
      (setq beg (point))
      ;; Only operate on whole lines so we don't get caught with part of an
      ;; escape sequence in one chunk and the rest in another.
      (when (< (point) end)
        (setq end (copy-marker end))
        ;; Highlight pt matches and delete marking sequences.
        (while (re-search-forward "\033\\[30;43m\\(.*?\\)\033\\[[0-9]*m" end 1)
          (replace-match (propertize (match-string 1)
                                     'face nil 'font-lock-face 'grep-match-face)
                         t t))
        ;; Delete all remaining escape sequences
        (goto-char beg)
        (while (re-search-forward "\033\\[[0-9;]*[mK]" end 1)
          (replace-match "" t t))))))

(define-compilation-mode pt-search-compilation-mode "Pt"
  "Platinum searcher results compilation mode"
  (set (make-local-variable 'truncate-lines) t)
  (set (make-local-variable 'compilation-disable-input) t)
  (let ((symbol 'compilation-pt)
        (pattern '("^\\([^:\n]+?\\):\\([0-9]+\\):[^0-9]" 1 2)))
    (set (make-local-variable 'compilation-error-regexp-alist) (list symbol))
    (set (make-local-variable 'compilation-error-regexp-alist-alist) (list (cons symbol pattern))))
  (set (make-local-variable 'compilation-error-face) grep-hit-face)
  (add-hook 'compilation-filter-hook 'pt--filter nil t))

(defun pt--search (pattern directory)
  (let ((default-directory directory))
  (compilation-start (concat "pt --nogroup --nocolor --smart-case " (shell-quote-argument pattern))
                     'pt-search-compilation-mode)))

;;;###autoload
(defun pt (pattern directory)
  (interactive (list (read-from-minibuffer "Search: " (thing-at-point 'symbol))
                     (read-directory-name "Directory: ")))
  (pt--search pattern directory))

;;;###autoload
(defun projectile-pt (pattern)
  (interactive (list (read-from-minibuffer "Search: " (thing-at-point 'symbol))))
  (pt--search pattern (projectile-project-root)))

(provide 'pt)
;;; pt.el ends here
