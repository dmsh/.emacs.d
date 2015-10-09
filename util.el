(defun load-path-recursive-dirs ()
  (let ((load-path (copy-sequence load-path)))
    (append
     (copy-sequence (normal-top-level-add-to-load-path '(".")))
     (normal-top-level-add-subdirs-to-load-path))))

(defun load-path-prepend-recursive (dir)
  (let ((default-directory dir))
    (setq load-path (append (load-path-recursive-dirs) load-path))))


(defun cfg-list-files (dir)
  (when (file-exists-p dir)
    (directory-files dir t "\\.el$")))

(defun cfg-load-file (file)
  (unless (load file t nil t)
    (message "TODO")))

(defun cfg-load-dir (dir)
  (mapc 'cfg-load-file (cfg-list-files dir)))
