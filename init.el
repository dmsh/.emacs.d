(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t)

(defun dotemacs-path (dir)
  (concat user-emacs-directory
	  (convert-standard-filename dir)))

(load (dotemacs-path "util.el"))
(load-path-prepend-recursive (dotemacs-path "lisp"))
(load-path-prepend-recursive (dotemacs-path "lisp-ext"))

(setq make-backup-files nil)
(defalias 'yes-or-no-p 'y-or-n-p)
(delete-selection-mode t)
(column-number-mode t)

(ido-mode)
(setq ido-enable-flex-matching t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)
