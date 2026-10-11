;; -*- lexical-binding: t -*-

(global-set-key (kbd "C-.") #'embark-act)
(global-set-key (kbd "C-h B") #'embark-bindings)

(after 'evil
  (/bindings/define-keys evil-normal-state-map
    ("g." #'embark-act))
  (/bindings/define-keys evil-visual-state-map
    ("g." #'embark-act)))

(provide 'config-bindings-embark)
