(defun dotemacs-path (dir)
  (concat user-emacs-directory
          (convert-standard-filename dir)))

(load (dotemacs-path "util"))

(require 'use-package)

(load-path-prepend-recursive (dotemacs-path "lisp"))
(load-path-prepend-recursive (dotemacs-path "lisp-ext"))
(load-path-prepend-recursive (dotemacs-path "elpa"))

(cfg-load-dir (dotemacs-path "config"))
