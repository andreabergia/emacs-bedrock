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
  (evil-define-key 'normal dashboard-mode-map (kbd "RET") 'dashboard-return)

  ;; xref results (M-. / SPC l d / SPC l R) get evil's motion state, since it's
  ;; a read-only navigation buffer; motion state still claims RET and n for
  ;; its own evil-ret/evil-search-next, so restore xref's jump-to-match and
  ;; next-match commands on top of it
  (evil-set-initial-state 'xref--xref-buffer-mode 'motion)
  (evil-define-key 'motion xref--xref-buffer-mode-map
    (kbd "RET") 'xref-goto-xref
    "n" 'xref-next-line))

