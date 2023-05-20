;;; ../dotfiles/doom.d/+clojure.el -*- lexical-binding: t; -*-
(use-package! clojure-mode
  :config
  (setq clojure-indent-style 'align-arguments
        clojure-align-forms-automatically t
          ;; evaluate expressions in comment as top level
        clojure-toplevel-inside-comment-form t))

(use-package! cider
  :after clojure-mode
  :config
  (setq cider-show-error-buffer t               ; show stacktrace buffer
        cider-print-fn 'puget                   ; pretty printing with sorted keys / set values
        cider-result-overlay-position 'at-point ; results shown right after expression
        cider-overlays-use-font-lock t

        ;; LSP features over Cider features
        cider-font-lock-dynamically nil         ; use lsp semantic tokens
        cider-eldoc-display-for-symbol-at-point nil ; use lsp
        cider-use-xref nil                      ; cider xref to find definitions

        ;; minimise the repl buffer activity
        cider-repl-buffer-size-limit 100        ; limit lines shown in REPL buffer
        cider-repl-display-help-banner nil      ; disable help banner
        cider-repl-history-size 10              ; limit command history
        cider-repl-history-file nil             ; write repl buffer commands to file DOOMDIR/.local/cider-repl-history
        cider-repl-history-highlight-current-entry nil   ; cider default
        cider-repl-history-highlight-inserted-item nil   ; cider default
        cider-repl-history-quit-action 'quit-window ; restores previous emacs window config (cider default )
        cider-repl-pop-to-buffer-on-connect nil ; REPL buffer shown at starup (nil does not show buffer)
        cider-repl-use-clojure-font-lock nil
        cider-repl-use-pretty-printing nil
        cider-repl-wrap-history t)
  (set-lookup-handlers! '(cider-mode cider-repl-mode) nil) ; use lsp
  (set-popup-rule! "*cider-test-report*" :side 'right :width 0.4)
  (set-popup-rule! "^\\*cider-repl" :side 'bottom :quit nil)
  (add-hook 'cider-mode-hook 'eldoc-mode)
  ;; use lsp completion
  (add-hook 'cider-mode-hook (lambda () (remove-hook 'completion-at-point-functions #'cider-complete-at-point))))

(use-package! flycheck-clj-kondo
  :after (clojure-mode))

(use-package! clj-refactor
  :after (clojure-mode))

(use-package! rainbow-delimiters
  :after (clojure-mode)
  :config
  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode))

(use-package! paredit
  :after (clojure-mode)
  :config
  (add-hook 'clojure-mode-hook 'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'cider-repl-mode-hook 'enable-paredit-mode))
