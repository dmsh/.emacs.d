(defconfig ido now
  (ido-mode)
  (setq ido-enable-flex-matching t)
  (setq ido-default-buffer-method 'selected-window)
  (setq ido-default-file-method 'selected-window))

(defconfig uniquify now
  (setq uniquify-buffer-name-style 'post-forward))

(defconfig package now
  (mapc (lambda (x) (add-to-list 'package-archives x))
        '(("marmalade" . "http://marmalade-repo.org/packages/")
          ("melpa"     . "http://melpa.milkbox.net/packages/")))
  (package-initialize))

(defconfig custom now
  (mapc (lambda (dir) (add-to-list 'custom-theme-load-path dir))
        (directory-files (dotemacs-path "themes") t "^[^\\.]"))
  (load-theme 'tango+ t))

(defconfig simple
  (setq visual-line-fringe-indicators '(nil right-curly-arrow)))

(global-set-key (kbd "C-c m") 'man)
(defconfig man
  (setq Man-switches "--no-hyphenation --no-justification"))
