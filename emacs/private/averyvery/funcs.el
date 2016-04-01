(defun blank-tab ()
  (split-window-right)
  (balance-windows)
  (windmove-right)
  (find-file "~/Documents/notes.md")
  (windmove-left)
)

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