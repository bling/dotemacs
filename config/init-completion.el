(defcustom dotemacs-completion-engine
  'company
  "The completion engine the use."
  :type '(radio
          (const :tag "company-mode" company)
          (const :tag "auto-complete-mode" auto-complete))
  :group 'dotemacs)

(when (eq dotemacs-completion-engine 'company)
  (require 'init-company))

(when (eq dotemacs-completion-engine 'auto-complete)
  (require 'init-auto-complete))

(provide 'init-completion)
