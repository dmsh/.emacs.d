(defconfig ido now
  (ido-mode)
  (setq ido-enable-flex-matching t))

(defconfig uniquify now
  (setq uniquify-buffer-name-style 'post-forward))

(defconfig package
  (mapc (lambda (x) (add-to-list 'package-archives x))
        '(("marmalade" . "http://marmalade-repo.org/packages/")
          ("melpa"     . "http://melpa.milkbox.net/packages/")))
  (package-initialize))

(defconfig color-theme now
  (when (require 'tango+ nil t)
    (color-theme-tango+)))
