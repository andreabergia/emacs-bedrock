;;; minibuf.el --- Minibuffer completion interface

;; use the minibuffer whilst in the minibuffer
(setopt enable-recursive-minibuffers t)
;; TAB cycles candidates
(setopt completion-cycle-threshold 1)
;; show annotations
(setopt completions-detailed t)
;; when hitting TAB, try to complete, otherwise indent
(setopt tab-always-indent 'complete)
;; different styles to match input to candidates
(setopt completion-styles '(basic initials substring))
;; open completion always; 'lazy' is another option
(setopt completion-auto-help 'always)
;; this is arbitrary
(setopt completions-max-height 20)
(setopt completions-format 'one-column)
(setopt completions-group t)
;; much more eager
(setopt completion-auto-select 'second-tab)

;; TAB acts more like how it does in the shell
(keymap-set minibuffer-mode-map "TAB" 'minibuffer-complete)

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package vertico-directory
  :ensure nil
  :after vertico
  :bind (:map vertico-map
              ("M-DEL" . vertico-directory-delete-word)))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless)))
