;; -*- lexical-binding: t -*-

(defgroup dotemacs-spelling nil
  "Configuration options for spelling."
  :group 'dotemacs
  :prefix 'dotemacs-spelling)

(defcustom dotemacs-spelling/major-modes
  '(text-mode)
  "List of major modes to enable spelling in."
  :type '(repeat (symbol))
  :group 'dotemacs-spelling)

(when (or (executable-find "aspell")
          (executable-find "ispell")
          (executable-find "hunspell"))
  (add-hook 'after-change-major-mode-hook
            (lambda ()
              (when (apply #'derived-mode-p dotemacs-spelling/major-modes)
                (flyspell-mode)))))

(provide 'config-spelling)
