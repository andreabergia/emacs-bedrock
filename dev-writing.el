;;; dev-writing.el --- Prose and writing tools

(when (>= emacs-major-version 30)
  (add-hook 'text-mode-hook 'visual-wrap-prefix-mode))

; spell-checker
(use-package jinx
  :ensure t
  :hook (((text-mode prog-mode) . jinx-mode))
  :bind (("C-;" . jinx-correct))
  :custom
  (jinx-camel-modes '(prog-mode))
  (jinx-delay 0.01))

(use-package olivetti
  :ensure t
  :hook ((markdown-mode . olivetti-mode)))

