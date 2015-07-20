(defun dotemacs-path (dir)
  (concat user-emacs-directory
          (convert-standard-filename dir)))

(load (dotemacs-path "util"))

(load-path-prepend-recursive (dotemacs-path "lisp"))
(load-path-prepend-recursive (dotemacs-path "lisp-ext"))

(cfg-load-dir (dotemacs-path "config"))

(defconfig anzu now
  (setq anzu-mode-lighter nil)
  (global-anzu-mode t))
