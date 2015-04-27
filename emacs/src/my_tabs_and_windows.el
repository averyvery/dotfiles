;; tabs.el

;;; Code
(load "elscreen" "ElScreen" t)

(elscreen-start)


(defun blank-tab ()
  (split-window-right)
  (balance-windows)
  (windmove-right)
  (find-file "~/Documents/notes.md")
  (windmove-left)
)

;; (blank-tab)
(global-set-key (kbd "H-T") (lambda () (interactive) (elscreen-clone) (delete-other-windows)))
(global-set-key (kbd "H-t") (lambda () (interactive) (elscreen-clone) (delete-other-windows) (projectile-find-file)))

(evil-leader/set-key "T" (lambda () (interactive) (elscreen-clone) (delete-other-windows)))
(evil-leader/set-key "t" (lambda () (interactive) (elscreen-clone) (delete-other-windows) (projectile-find-file)))

(evil-leader/set-key "s" (lambda () (interactive) (elscreen-create) (blank-tab)))

(evil-leader/set-key "ww" 'elscreen-kill)

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

(defun open-window ()
  (split-window-right)
  (windmove-right)
  (balance-windows)
)

(defun open-window-find ()
  (split-window-right)
  (balance-windows)
  (windmove-right)
  (projectile-recentf)
)

(defun open-horiz-window ()
  (split-window)
  (windmove-right)
  (balance-windows)
)

(defun open-horiz-window-find ()
  (split-window)
  (balance-windows)
  (windmove-right)
  (projectile-recentf)
)

(evil-leader/set-key "v" (lambda () (interactive) (open-window)))
(evil-leader/set-key "V" (lambda () (interactive) (open-window-find)))
(evil-leader/set-key "h" (lambda () (interactive) (open-horiz-window)))
(evil-leader/set-key "H" (lambda () (interactive) (open-horiz-window-find)))
