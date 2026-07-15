;;; keybindings.el --- Leader key (SPC) bindings

(use-package general
  :ensure t
  :after evil
  :config
  (general-create-definer my-leader-def
    :states '(normal visual insert emacs)
    :keymaps 'override
    :prefix "SPC"
    :non-normal-prefix "M-SPC")

  (my-leader-def
    "SPC" '(project-find-file :which-key "find file (project)")

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

    "a"   '(:ignore t :which-key "ai")
    "a c" '(agent-shell-anthropic-start-claude-code :which-key "claude code")
    "a a" '(agent-shell-manager-toggle :which-key "manager")

    "p"   '(:ignore t :which-key "project")
    "p p" '(my-project-switch-project :which-key "switch project")
    "p f" '(project-find-file :which-key "find file")
    "p d" '(project-dired :which-key "dired")
    "p b" '(project-switch-to-buffer :which-key "switch buffer")
    "p k" '(project-kill-buffers :which-key "kill buffers")
    "p a" '(project-remember-projects-under :which-key "add projects under dir")
    "p F" '(project-forget-project :which-key "forget project")
    "p s" '(consult-ripgrep :which-key "search (ripgrep)")

    "w"   '(:ignore t :which-key "frame")
    "w n" '(make-frame :which-key "new frame")
    "w d" '(clone-frame :which-key "duplicate frame")
    "w k" '(delete-frame :which-key "kill frame")
    "w o" '(other-frame :which-key "other frame")

    "l"   '(:ignore t :which-key "lsp")
    "l l" '(eglot :which-key "start")
    "l r" '(eglot-rename :which-key "rename")
    "l a" '(eglot-code-actions :which-key "code action")
    "l f" '(eglot-format-buffer :which-key "format buffer")
    "l d" '(xref-find-definitions :which-key "find definition")
    "l R" '(xref-find-references :which-key "find references")
    "l e" '((lambda () (interactive) (consult-flymake t)) :which-key "diagnostics (project)")
    "l E" '(consult-flymake :which-key "diagnostics (buffer)")

    "t"   '(:ignore t :which-key "tab")
    "t n" '(tab-new :which-key "new tab")
    "t t" '(my-new-terminal-tab :which-key "new terminal tab")
    "t k" '(tab-close :which-key "close tab")
    "t o" '(tab-next :which-key "next tab")
    "t p" '(tab-previous :which-key "previous tab"))

  ;; vim-unimpaired-style motions between git change hunks (needs diff-hl)
  (general-define-key
   :states 'normal
   "]c" 'diff-hl-next-hunk
   "[c" 'diff-hl-previous-hunk))
