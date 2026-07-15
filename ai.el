;;; ai.el --- Claude Code, via agent-shell

;; agent-shell is a chat buffer (built on comint) for talking to coding
;; agents through the Agent Client Protocol (ACP). For Claude Code, it
;; shells out to the `claude-agent-acp` adapter, installed globally via:
;;   npm install -g @agentclientprotocol/claude-agent-acp
(use-package agent-shell
  :ensure t
  :custom
  ;; reuse the same login as the `claude` CLI --- no API key to manage
  (agent-shell-anthropic-authentication
   (agent-shell-anthropic-make-authentication :login t))
  ;; `claude-agent-acp` lives under nvm's node install, which isn't on
  ;; Emacs's PATH (nvm only adds it to PATH when a shell lazily loads it).
  ;; Point straight at the binary...
  (agent-shell-anthropic-claude-acp-command
   (list (expand-file-name "~/.nvm/versions/node/v24.15.0/bin/claude-agent-acp")))
  ;; skip permission prompts for edits/commands --- otherwise the default
  ;; mode ("Manual") denies anything not pre-approved
  (agent-shell-anthropic-default-session-mode-id "bypassPermissions")
  :config
  ;; ...and since the script itself starts with `#!/usr/bin/env node`, also
  ;; put that same directory on the *subprocess's* PATH, or node can't be found.
  ;; (Needs `:config', not `:custom': `agent-shell-make-environment-variables'
  ;; is only defined once agent-shell itself has fully loaded.)
  (setq agent-shell-anthropic-claude-environment
        (agent-shell-make-environment-variables
         :inherit-env t
         "PATH" (concat (expand-file-name "~/.nvm/versions/node/v24.15.0/bin") ":"
                         (getenv "PATH"))))
  ;; By default agent-shell writes each project's transcripts and
  ;; screenshots into <project>/.agent-shell/, cluttering every project's
  ;; checkout. Redirect those to one central location instead, keeping the
  ;; same <project>/.agent-shell/<subdir> shape (so agent-recall's
  ;; per-project grouping below still works) just rooted elsewhere.
  ;; "worktrees" is left alone: it's an actual git worktree you create
  ;; deliberately via `agent-shell-new-worktree-shell', not auto-generated
  ;; clutter, and its path is always shown/editable when creating one.
  (defun ab/agent-shell-dot-subdir (subdir)
    (if (equal subdir "worktrees")
        (agent-shell--dot-subdir-in-repo subdir)
      (expand-file-name
       (file-name-concat
        (file-name-nondirectory (directory-file-name (agent-shell-cwd)))
        ".agent-shell" subdir)
       (locate-user-emacs-file "agent/shells/"))))
  (setq agent-shell-dot-subdir-function #'ab/agent-shell-dot-subdir))

;; Tabulated-list view of all open agent-shell buffers (status, mode, model,
;; pending permission requests) with kill/restart/create actions.
;; Not on MELPA, so install straight from the source repo.
(use-package agent-shell-manager
  :vc (:url "https://github.com/jethrokuan/agent-shell-manager" :rev :newest)
  :after agent-shell)

;; Search, browse, and resume agent-shell transcripts. Indexes the
;; centralized transcripts directory configured above.
(use-package agent-recall
  :ensure t
  :after agent-shell
  :hook (agent-shell-mode . agent-recall-track-sessions)
  :config
  (setq agent-recall-search-paths (list (locate-user-emacs-file "agent/shells/"))))
