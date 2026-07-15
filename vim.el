;;; vim.el --- Evil mode

(use-package evil
  :ensure t
  :init
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode)
  (add-hook 'git-commit-setup-hook 'evil-insert-state)
  (evil-set-initial-state 'vterm-mode 'emacs)
  (evil-set-initial-state 'dashboard-mode 'emacs))

