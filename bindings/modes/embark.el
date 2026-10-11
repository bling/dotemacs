;; -*- lexical-binding: t -*-

(keymap-global-set "C-." #'embark-act)
(keymap-global-set "C-h B" #'embark-bindings)

(after 'evil
  (/bindings/set-keys evil-normal-state-map
    ("g ." #'embark-act))
  (/bindings/set-keys evil-visual-state-map
    ("g ." #'embark-act)))

(provide 'config-bindings-embark)
