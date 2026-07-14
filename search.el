;;; search.el --- Search and navigation enhancements

(use-package consult
  :ensure t
  :bind (
         ("C-x b" . consult-buffer)
         ("M-y"   . consult-yank-pop)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s s" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s o" . consult-outline)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)
         ("M-s e" . consult-isearch-history)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi))
  :config
  ;; narrowing lets you restrict results to certain groups of candidates
  (setq consult-narrow-key "<"))

(use-package embark-consult
  :ensure t)

(use-package embark
  :ensure t
  :demand t
  :after (avy embark-consult)
  ;; bind this to an easy key to hit
  :bind (("C-c a" . embark-act))
  :init
  (defun bedrock/avy-action-embark (pt)
    (unwind-protect
        (save-excursion
          (goto-char pt)
          (embark-act))
      (select-window
       (cdr (ring-ref avy-ring 0))))
    t)
  ;; After invoking avy-goto-char-timer, hit "." to run embark at the next candidate
  (setf (alist-get ?. avy-dispatch-alist) 'bedrock/avy-action-embark))

(use-package wgrep
  :ensure t
  :config
  (setq wgrep-auto-save-buffer t))
