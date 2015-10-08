(use-package ido
  :config
  (ido-mode)
  (setq ido-enable-flex-matching t)
  (setq ido-default-buffer-method 'selected-window)
  (setq ido-default-file-method 'selected-window))

(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'post-forward))

(use-package package
  :config
  (mapc (lambda (x) (add-to-list 'package-archives x))
        '(("marmalade" . "http://marmalade-repo.org/packages/")
          ("melpa"     . "http://melpa.milkbox.net/packages/")))
  (package-initialize))

(use-package custom
  :config
  (mapc (lambda (dir) (add-to-list 'custom-theme-load-path dir))
        (directory-files (dotemacs-path "themes") t "^[^\\.]"))
  (load-theme 'tango+ t))

(use-package simple
  :config
  (setq visual-line-fringe-indicators '(nil right-curly-arrow)))

(use-package man
  :bind ("C-c m" . man)
  :config
  (setq Man-switches "--no-hyphenation --no-justification"))
