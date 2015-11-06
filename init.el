(defun dotemacs-path (dir)
  (expand-file-name dir user-emacs-directory))

(load (dotemacs-path "util.el"))

(load-path-prepend (dotemacs-path "lisp-ext/use-package"))
(require 'use-package)

(load-path-prepend-recursive (dotemacs-path "lisp"))
(load-path-prepend-recursive (dotemacs-path "lisp-ext"))
;(load-path-prepend-recursive (dotemacs-path "elpa"))

;;;;;;;;;;

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(defalias 'yes-or-no-p 'y-or-n-p)
(delete-selection-mode t)
(add-to-list 'default-frame-alist '(font . "Monospace-11"))
;;(set-default-font "Monospace-11")
;;(set-face-attribute 'default nil :height 110)
(setq-default indent-tabs-mode nil)

;; (define-key input-decode-map [9] [control-i])
;; (global-set-key (kbd "<control-i>") 'forward-char)
;; (global-set-key (kbd "C-n") 'backward-char)
;; (global-set-key (kbd "C-u") 'previous-line)
;; (global-set-key (kbd "C-e") 'next-line)

;;;;;;;;;;

(use-package package
  :config
  (mapc (lambda (x) (add-to-list 'package-archives x))
        '(("marmalade" . "http://marmalade-repo.org/packages/")
          ("melpa"     . "http://melpa.milkbox.net/packages/")))
  (package-initialize))

(use-package ido
  :config
  (ido-mode)
  (setq ido-enable-flex-matching t)
  (setq ido-default-buffer-method 'selected-window)
  (setq ido-default-file-method 'selected-window)
  (defvar ido-enable-replace-completing-read t)
  (defadvice completing-read
      (around use-ido-when-possible activate)
    (if (or (not ido-enable-replace-completing-read) ; Manual override disable ido
            (and (boundp 'ido-cur-list)
                 ido-cur-list)) ; Avoid infinite loop from ido calling this
        ad-do-it
      (let ((allcomp (all-completions "" collection predicate)))
        (if allcomp
            (setq ad-return-value
                  (ido-completing-read prompt
                                       allcomp
                                       nil require-match initial-input hist def))
          ad-do-it)))))

(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'post-forward))

(use-package custom
  :config
  (mapc (lambda (dir) (add-to-list 'custom-theme-load-path dir))
        (directory-files (dotemacs-path "themes") t "^[^\\.]"))
  (load-theme 'tango+ t))

(use-package simple
  :config
  (column-number-mode t)
  (setq visual-line-fringe-indicators '(nil right-curly-arrow)))

(use-package man
  :bind ("C-c m" . man)
  :config
  (setq Man-switches "--no-hyphenation --no-justification"))

(use-package paren
  :config
  (show-paren-mode t))

(use-package anzu
  :config
  (setq anzu-mode-lighter nil)
  (global-anzu-mode t))

(use-package haskell-mode
  :defer t
  :config
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation))

;;; OCaml
(with-temp-buffer
  (insert (shell-command-to-string
           "ocp-edit-mode emacs -load-global-config"))
  (eval-buffer))

(use-package org
  :defer t
  :config
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

(use-package proof-site
  :defer t
  :config
  (setq proof-splash-enable nil
        coq-maths-menu-enable t
        coq-unicode-tokens-enable nil))

(use-package cc-mode
  :defer t
  :config
  (c-add-style
   "linux-tabs-only"
   '("linux"
     (tab-width . 8)
     (indent-tabs-mode . t)
     (c-offsets-alist . ((arglist-cont-nonempty . (c-lineup-gcc-asm-reg
                                                   c-lineup-arglist-tabs-only))))))

  (c-add-style
   "strongswan"
   '((tab-width . 4)
     (indent-tabs-mode . t)
     (c-basic-offset . 4)
     (c-offsets-alist . ((substatement-open . 0)
                         (case-label . +)
                         (label . 0)))))

  (add-hook 'c-mode-hook
            (lambda ()
              (setq indent-tabs-mode t)
              (c-set-style "linux-tabs-only"))))

(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))
