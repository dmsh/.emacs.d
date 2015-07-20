(defconfig org
  (setq org-startup-indented t)
  (setq org-src-preserve-indentation t
	org-src-fontify-natively t)
  (setq org-html-htmlize-output-type 'css)
  (setq org-file-apps '((auto-mode . emacs)
			("\\.mm\\'" . default)
			("\\.x?html?\\'" . (browse-url-firefox file))
			("\\.pdf\\'" . default)))
  (add-hook 'org-mode-hook
	    (lambda ()
	      (visual-line-mode t))))
