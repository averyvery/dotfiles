;; tabs.el

;;; Code
(load "elscreen" "ElScreen" t)
(elscreen-start)
(global-set-key (kbd "H-T") (lambda () (interactive) (elscreen-create) (projectile-switch-project)))
(global-set-key (kbd "H-t") (lambda () (interactive) (elscreen-create)))
(global-set-key (kbd "H-w") 'elscreen-kill)
(global-set-key (kbd "H-5") 'elscreen-previous)
(global-set-key (kbd "H-6") 'elscreen-next)

(evil-leader/set-key "wt" 'windmove-up)
(evil-leader/set-key "wd" 'windmove-down)
(evil-leader/set-key "wn" 'windmove-right)
(evil-leader/set-key "wd" 'windmove-left)

(defun delete-and-balance-window ()
	(delete-window)
	(balance-windows)
)

(defun delete-and-balance-other-windows ()
	(delete-other-windows)
	(balance-windows)
)

(evil-leader/set-key "wc" (lambda () (interactive) (delete-and-balance-window)))
(evil-leader/set-key "wC" (lambda () (interactive) (delete-and-balance-other-windows)))
(evil-leader/set-key "wb" 'balance-windows)
