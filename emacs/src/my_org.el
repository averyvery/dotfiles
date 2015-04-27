;; org.el
(global-visual-line-mode t)

;;; Code
(evil-leader/set-key "o l" 'org-insert-link)
(evil-leader/set-key "o s" 'org-store-link)
(evil-leader/set-key "o" (lambda () (interactive)(find-file "~/.emacs.d/org/index.org")))


;; (add-hook 'org-mode-hook
;; 	(lambda ()
;; 		(define-key evil-normal-state-map (kbd "RET") 'org-open-at-point)
;; 		(define-key yas/keymap [tab] 'yas/next-field-group)))
