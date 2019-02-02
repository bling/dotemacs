(after 'vdiff
  (define-key vdiff-mode-map (kbd "C-c") vdiff-mode-prefix-map)
  (define-key vdiff-3way-mode-map (kbd "C-c") vdiff-mode-prefix-map))

(after [evil vdiff]
  (evil-define-minor-mode-key 'normal 'vdiff-mode (kbd "RET") #'vdiff-hydra/body)
  (evil-define-minor-mode-key 'insert 'vdiff-mode (kbd "RET") #'evil-ret)
  (evil-define-minor-mode-key 'normal 'vdiff-3way-mode (kbd "RET") #'vdiff-hydra/body)
  (evil-define-minor-mode-key 'insert 'vdiff-3way-mode (kbd "RET") #'evil-ret))

(defun /bindings/vdiff/turn-on ()
  (after [magit vdiff]
    (define-key magit-mode-map "e" 'vdiff-magit-dwim)
    (define-key magit-mode-map "E" 'vdiff-magit-popup)
    (setcdr (assoc ?e (plist-get magit-dispatch-popup :actions))
            '("vdiff dwim" 'vdiff-magit-dwim))
    (setcdr (assoc ?E (plist-get magit-dispatch-popup :actions))
            '("vdiff popup" 'vdiff-magit-popup))))

(defun /bindings/vdiff/turn-off ()
  (after [magit]
    (define-key magit-mode-map "e" 'magit-ediff-dwim)
    (define-key magit-mode-map "E" 'magit-ediff-popup)
    (setcdr (assoc ?e (plist-get magit-dispatch-popup :actions))
            '("Ediff dwimming" 'magit-ediff-dwim))
    (setcdr (assoc ?E (plist-get magit-dispatch-popup :actions))
            '("Ediffing" 'magit-ediff-popup))))

(provide 'config-bindings-vdiff)
