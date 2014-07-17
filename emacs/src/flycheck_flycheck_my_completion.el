;; completion.el

;;; Code

;; snippets
(require 'yasnippet)
(yas-global-mode 1)
(setq yas/indent-line 'fixed)
(global-set-key (kbd "<S-tab>") 'yas-expand)

;; emmet
(require 'emmet-mode)
(add-hook 'css-mode-hook (lambda () (emmet-mode)))
(add-hook 'html-mode-hook (lambda () (emmet-mode)))
(global-set-key (kbd "<C-tab>") 'emmet-expand-line)
(setq emmet-preview-default nil)

;; howdoi
(require 'howdoi)
(evil-leader/set-key "h" 'howdoi)

;; auto-complete
(require 'auto-complete-config)
(ac-config-default)
