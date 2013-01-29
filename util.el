(defun load-path-recursive-dirs ()
  (let ((load-path (copy-sequence load-path)))
    (append
     (copy-sequence (normal-top-level-add-to-load-path '(".")))
     (normal-top-level-add-subdirs-to-load-path))))

(defun load-path-prepend-recursive (dir)
  (let ((default-directory dir))
    (setq load-path (append (load-path-recursive-dirs) load-path))))
