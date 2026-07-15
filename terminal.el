;;; terminal.el --- Terminal emulation

(use-package vterm
  :ensure t
  ;; cua-mode remaps `yank' to `cua-paste' globally, and its minor-mode
  ;; keymap takes precedence over vterm-mode-map's own remap, so C-y/Cmd-v
  ;; end up calling `cua-paste', which errors on vterm's always-read-only
  ;; buffer. Binding the literal keys here (not via remap) wins instead.
  :bind (:map vterm-mode-map
              ("C-y" . vterm-yank)
              ("s-v" . vterm-yank)))

(defun my-new-terminal-tab ()
  "Open a new tab and start a new terminal (vterm) session in it.
Passes a non-nil arg to `vterm' so it always creates a fresh session
buffer instead of reusing an existing *vterm* buffer."
  (interactive)
  (tab-new)
  (vterm t))
