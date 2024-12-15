;;; ../dotfiles/doom.d/+ui.el -*- lexical-binding: t; -*-

;; ui
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;; no title bar and round corners
(add-to-list 'default-frame-alist '(undecorated-round . t))

;; check
(use-package! languagetool
  :defer t
  :commands (languagetool-check
             languagetool-clear-suggestions
             languagetool-correct-at-point
             languagetool-correct-buffer
             languagetool-set-language
             languagetool-server-mode
             languagetool-server-start
             languagetool-server-stop)
  :config
  (setq languagetool-api-key (getenv "LANGUAGETOOL_KEY")
        languagetool-username "avelinorun@gmail.com"
        languagetool-java-arguments '("-Dfile.encoding=UTF-8")
        languagetool-console-command "/usr/local/Cellar/languagetool/6.0/libexec/languagetool.jar"
        languagetool-server-command "/usr/local/Cellar/languagetool/6.0/libexec/languagetool-server.jar"))

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

(use-package! company
  :init
  (setq company-require-match nil            ; Don't require match, so you can still move your cursor as expected.
        company-tooltip-align-annotations t  ; Align annotation to the right side.
        company-eclim-auto-save nil          ; Stop eclim auto save.
        company-dabbrev-downcase nil)        ; No downcase when completion.
  :config
  ;; Enable downcase only when completing the completion.
  (defun jcs--company-complete-selection--advice-around (fn)
    "Advice execute around `company-complete-selection' command."
    (let ((company-dabbrev-downcase t))
      (call-interactively fn)))
  (advice-add 'company-complete-selection :around #'jcs--company-complete-selection--advice-around))

;; (use-package! moody
;;   :config
;;   (setq x-underline-at-descent-line t)
;;   (setq-default mode-line-format
;;                 '(" "
;;                   mode-line-front-space
;;                   mode-line-client
;;                   mode-line-frame-identification
;;                   mode-line-buffer-identification " " mode-line-position
;;                   (vc-mode vc-mode)
;;                   (multiple-cursors-mode mc/mode-line)
;;                   " " mode-line-modes
;;                   mode-line-end-spaces)))

(use-package! face-remap
  :bind(("C-+" . text-scale-increase)
        ("C--" . text-scale-decrease)))
