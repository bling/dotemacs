;;; pt.el --- A front-end for pt, The Platinum Searcher.
;;
;; Copyright (C) 2014 by Bailey Ling
;; Author: Bailey Ling
;; URL: https://github.com/bling/pt.el
;; Filename: pt.el
;; Description: A front-end for pt, the Platinum Searcher
;; Created: 2014-04-27
;; Version: 0.0.1
;; Keywords: pt ack ag search
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING. If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Install:
;;
;; Autoloads will be set up automatically if you use package.el.
;;
;; Usage:
;;
;; M-x pt-regexp
;; M-x projectile-pt
;;
;;; Code:

(eval-when-compile (require 'cl))
(require 'compile)
(require 'grep)
(require 'thingatpt)

(defcustom pt-executable
  "pt"
  "Name of the pt executable to use."
  :type 'string
  :group 'pt)

(defcustom pt-arguments
  (list "--smart-case")
  "Default arguments passed to pt."
  :type '(repeat (string))
  :group 'pt)

(defcustom pt-highlight-search t
  "Non-nil means to highlight the search term in the results."
  :type 'boolean
  :group 'pt)

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

(define-compilation-mode pt-search-mode "Pt"
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
    (compilation-start
     (mapconcat 'identity
                (append (list pt-executable)
                        pt-arguments
                        '("--nogroup" "--nocolor" "--")
                        (list (shell-quote-argument pattern))) " ")
     'pt-search-mode)))

;;;###autoload
(defun pt-regexp (regexp directory)
  "Run a pt search with REGEXP rooted at DIRECTORY."
  (interactive (list (read-from-minibuffer "Pt search for: " (thing-at-point 'symbol))
                     (read-directory-name "Directory: ")))
  (pt--search regexp directory))

;;;###autoload
(defun projectile-pt (regexp)
  "Run a pt search with REGEXP rooted at the current projectile project root."
  (interactive (list (read-from-minibuffer "Pt search for: " (thing-at-point 'symbol))))
  (if (fboundp 'projectile-project-root)
      (pt--search regexp (projectile-project-root))
    (error "Projectile is not available")))

(provide 'pt)
;;; pt.el ends here
