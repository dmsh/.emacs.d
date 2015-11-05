(use-package ido
  :config
  (ido-mode)
  (setq ido-enable-flex-matching t)
  (setq ido-default-buffer-method 'selected-window)
  (setq ido-default-file-method 'selected-window)
  (defvar ido-enable-replace-completing-read t)
  (defadvice completing-read
      (around use-ido-when-possible activate)
    (if (or (not ido-enable-replace-completing-read) ; Manual override disable ido
            (and (boundp 'ido-cur-list)
                 ido-cur-list)) ; Avoid infinite loop from ido calling this
        ad-do-it
      (let ((allcomp (all-completions "" collection predicate)))
        (if allcomp
            (setq ad-return-value
                  (ido-completing-read prompt
                                       allcomp
                                       nil require-match initial-input hist def))
          ad-do-it)))))

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

(use-package paren
  :config
  (show-paren-mode t))
