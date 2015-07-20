(defconfig org
  (setq org-startup-indented t)
  (setq org-src-preserve-indentation t
	org-src-fontify-natively t)
  (setq org-html-htmlize-output-type 'css)
  (setq org-file-apps '((auto-mode . emacs)
			("\\.mm\\'" . default)
			("\\.x?html?\\'" . (browse-url-firefox file))
			("\\.pdf\\'" . default)))
  (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
  (add-hook 'org-mode-hook
	    (lambda ()
	      (visual-line-mode t))))

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
