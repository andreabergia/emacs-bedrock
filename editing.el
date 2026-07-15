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

(setopt dictionary-use-single-buffer t)
(setopt dictionary-server "dict.org")

