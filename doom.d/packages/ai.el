;;; packages/ai.el -*- lexical-binding: t; -*-

(package! copilot
  :recipe (:host github :repo "copilot-emacs/copilot.el" :files ("*.el")))
(package! copilot-chat)
(package! gptel)
