;;; doom/+ai.el -*- lexical-binding: t; -*-

(use-package! gptel
  :config
  (setq
   gptel-model 'claude-3-5-sonnet-latest
   gptel-backend (gptel-make-anthropic "Claude"  ; Any name you want
                                       :stream t ; Streaming responses
                                       :key (getenv "CLAUDE_EDITOR_KEY"))))

(use-package! copilot-chat
  :after (request org markdown-mode shell-maker))

(after! (evil copilot)
  ;; Define the custom function that either accepts the completion or does the default behavior
  (defun my/copilot-tab-or-default ()
    (interactive)
    (if (and (bound-and-true-p copilot-mode)
             ;; Add any other conditions to check for active copilot suggestions if necessary
             )
        (copilot-accept-completion)
      (evil-insert 1))) ; Default action to insert a tab. Adjust as needed.

  ;; Bind the custom function to <tab> in Evil's insert state
  (evil-define-key 'insert 'global (kbd "<tab>") 'my/copilot-tab-or-default)

  (use-package! copilot
    :hook (prog-mode . copilot-mode)
    :bind (:map copilot-completion-map
                ("<tab>" . 'copilot-accept-completion)
                ("TAB" . 'copilot-accept-completion)
                ("C-TAB" . 'copilot-accept-completion-by-word)
                ("C-<tab>" . 'copilot-accept-completion-by-word))))
