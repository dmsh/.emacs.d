(defconfig cc-mode
;;  (add-hook 'c-mode-common-hook
;;          (lambda ()
  (c-add-style "linux-tabs-only"
               '("linux"
                 (tab-width . 8)
                 (indent-tabs-mode . t)
                 (c-offsets-alist
                  (arglist-cont-nonempty
                   c-lineup-gcc-asm-reg
                   c-lineup-arglist-tabs-only))))
  (c-add-style "strongswan"
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
