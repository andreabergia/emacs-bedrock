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
    "f g" '(consult-fd :which-key "find file (fuzzy, fd)")
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
    "g g" '(magit-status :which-key "status")
    "g b" '(magit-blame-addition :which-key "blame")
    "g B" '(magit-branch :which-key "branch")
    "g l" '(magit-log :which-key "log")

    "p"   '(:ignore t :which-key "project")
    "p p" '(my-project-switch-project :which-key "switch project")
    "p f" '(project-find-file :which-key "find file")
    "p d" '(project-dired :which-key "dired")
    "p b" '(project-switch-to-buffer :which-key "switch buffer")
    "p k" '(project-kill-buffers :which-key "kill buffers")
    "p a" '(project-remember-projects-under :which-key "add projects under dir")
    "p s" '(consult-ripgrep :which-key "search (ripgrep)"))

  ;; vim-unimpaired-style motions between git change hunks (needs diff-hl)
  (general-define-key
   :states 'normal
   "]c" 'diff-hl-next-hunk
   "[c" 'diff-hl-previous-hunk))
