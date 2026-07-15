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
  ;; dashboard-mode stays in normal state (unlike vterm) so / and the
  ;; SPC leader keys work there; RET is restored to dashboard's own
  ;; open-item command, since evil's normal state would otherwise shadow it
  (evil-define-key 'normal dashboard-mode-map (kbd "RET") 'dashboard-return))

