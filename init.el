(defun dotemacs-path (dir)
  (expand-file-name dir user-emacs-directory))

(load (dotemacs-path "util.el"))

(load-path-prepend (dotemacs-path "lisp-ext/use-package"))
(require 'use-package)

(load-path-prepend-recursive (dotemacs-path "lisp"))
(load-path-prepend-recursive (dotemacs-path "lisp-ext"))
(load-path-prepend-recursive (dotemacs-path "elpa"))

(cfg-load-dir (dotemacs-path "config"))
