;;; editing.el --- Editing behavior & navigation

;; auto parenthesis matching
(add-hook 'prog-mode-hook 'electric-pair-mode)

;; if saving a new shell file, chmod +x it
(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)

(use-package avy
  :ensure t
  :demand t
  :bind (("C-c j" . avy-goto-line)
         ("s-j"   . avy-goto-char-timer)))

(use-package eat
  :ensure t
  :custom
  (eat-term-name "xterm")
  :config
  ;; use Eat to handle term codes in program output
  (eat-eshell-mode)
  ;; commands like less will be handled by Eat
  (eat-eshell-visual-command-mode))

(setopt dictionary-use-single-buffer t)
(setopt dictionary-server "dict.org")

