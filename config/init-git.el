(require-package 'magit)
(require-package 'gist)

(when (display-graphic-p)
  (require-package 'git-gutter-fringe+)
  (require 'git-gutter-fringe+)
  (global-git-gutter+-mode))

(provide 'init-git)
