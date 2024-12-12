;;; ../dotfiles/doom.d/+term.el -*- lexical-binding: t; -*-

;; fish to default shell
'(explicit-shell-file-name "/opt/homebrew/bin/fish")

;; vterm
;; (defvar vterm-compile-dedicated-buffer nil)
;; (defun vterm-compile ()
;;   (interactive)
;;   (let ((vterm-toggle-use-dedicated-buffer t)
;;         (vterm-toggle--vterm-dedicated-buffer vterm-compile-dedicated-buffer))
;;     (with-current-buffer (vterm-toggle-cd)
;;       (setq vterm-compile-dedicated-buffer (current-buffer))
;;       (rename-buffer "term compile")
;;       (compilation-shell-minor-mode 1)
;;       (vterm-send-string compile-command t)
;;       (vterm-send-return))))
;; (use-package! vterm-toggle
;;   :bind (("C-<escape>" . '+vterm/toggle)
;;          ("C-<dead-grave>" . '+vterm/toggle)
;;          ("C-t" . '+vterm/toggle))
;;   :config
;;   (set-popup-rule! "*doom:vterm-popup:*" :size 0.45 :vslot -4 :select t :quit nil :ttl 0)
;;   (add-hook 'vterm-mode-hook  'with-editor-export-editor)
;;   (setq ;; vterm-toggle-reset-window-configration-after-exit t
;;    vterm-shell (executable-find "fish")
;;    vterm-compile-dedicated-buffer t
;;    vterm-max-scrollback 10000))
