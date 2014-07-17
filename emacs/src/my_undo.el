;; undo.el

;;; Code
(require 'undo-tree)
(global-undo-tree-mode)
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist '((".*" . "~/.emacs.d/undo-list")))
(setq undo-tree-mode-lighter "")

;; backups
(setq backup-directory-alist
  `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
  `((".*" ,temporary-file-directory t)))
(setq delete-by-moving-to-trash t)
