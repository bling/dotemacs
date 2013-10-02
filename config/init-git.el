(require-package 'magit)
(require-package 'gist)

(if (display-graphic-p)
    (progn
      (require-package 'git-gutter-fringe+)
      (require 'git-gutter-fringe+))
  (require-package 'git-gutter+))

(global-git-gutter+-mode)

(provide 'init-git)
