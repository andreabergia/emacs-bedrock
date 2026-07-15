;;; keybindings.el --- Leader key (SPC) bindings

(use-package general
  :ensure t
  :after evil
  :config
  (general-create-definer my-leader-def
    :states '(normal visual)
    :keymaps 'override
    :prefix "SPC")

  (my-leader-def
    "f"   '(:ignore t :which-key "file")
    "f f" '(find-file :which-key "find file")
    "f r" '(consult-recent-file :which-key "recent files")

    "b"   '(:ignore t :which-key "buffer")
    "b b" '(consult-buffer :which-key "switch buffer")
    "b k" '(kill-current-buffer :which-key "kill buffer")
    "b r" '(revert-buffer :which-key "revert buffer")

    "s"   '(:ignore t :which-key "search")
    "s r" '(consult-ripgrep :which-key "ripgrep project")
    "s l" '(consult-line :which-key "search buffer")
    "s L" '(consult-line-multi :which-key "search all buffers")
    "s o" '(consult-outline :which-key "outline")

    "g"   '(:ignore t :which-key "git")
    "g g" '(magit-status :which-key "status")))
