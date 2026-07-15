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
                         (getenv "PATH")))))
