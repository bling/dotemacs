(defgroup dotemacs-js nil
  "Configuration options for Javascript."
  :group 'dotemacs
  :prefix 'dotemacs-js)

(defcustom dotemacs-js/indent-offset 2
  "The number of spaces to indent nested statements."
  :type 'integer
  :group 'dotemacs-js)

(defcustom dotemacs-js/maximum-file-size (* 1024 20)
  "The threshold for when `fundamental-mode' is used instead."
  :type 'integer
  :group 'dotemacs-js)

(defcustom dotemacs-js/engine
  (if (executable-find "javascript-typescript-langserver")
      'lsp
    'js2-mode)
  "The engine to drive JavaScript."
  :type '(radio
          (const :tag "js2-mode" js2-mode)
          (const :tag "lsp" lsp))
  :group 'dotemacs-js)



(setq js-indent-level dotemacs-js/indent-offset)

(defun /js/auto-mode-alist-hook ()
  (cond
   ((> (buffer-size) dotemacs-js/maximum-file-size)
    (fundamental-mode))
   (t
    (require-package 'web-mode)
    (web-mode)
    (cond
     ((eq dotemacs-js/engine 'js2-mode)
      (require-package 'js2-mode)
      (js2-minor-mode))
     ((eq dotemacs-js/engine 'lsp)
      (/lsp/activate 'lsp-javascript-typescript))))))

(add-to-list 'auto-mode-alist '("\\.jsx?$" . /js/auto-mode-alist-hook))

(after 'js2-mode
  (setq js2-highlight-level 3)
  (setq-default js2-basic-offset dotemacs-js/indent-offset))

(after "js2-mode-autoloads"
  (require-package 'js2-refactor)
  (after 'js2-refactor
    (js2r-add-keybindings-with-prefix "C-c C-m"))

  (add-hook 'js2-mode-hook #'js2-refactor-mode)
  (add-hook 'js2-minor-mode-hook #'js2-refactor-mode))

(provide 'config-js)
