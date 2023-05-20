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

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         :map copilot-completion-map
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)))

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
