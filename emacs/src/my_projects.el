;; projects.el

;;; Code
;; directory
(setq default-directory "~/Sites")

(projectile-global-mode)
(evil-leader/set-key "F" 'projectile-find-file)
(evil-leader/set-key "f" 'projectile-recentf)
(evil-leader/set-key "p" 'projectile-switch-project)
(evil-leader/set-key "g" 'projectile-grep)
(evil-leader/set-key "G" 'find-grep-dired)
(global-set-key (kbd "H-o") 'find-file)
(evil-leader/set-key "b" 'buffer-menu)


(defun sudo-edit (&optional arg)
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun sudo-edit-on-etc-files ()
  (when (string= (substring (file-name-directory buffer-file-name) 1 4) "etc")
    (print "Foo")
    (sudo-edit)))

(add-hook 'find-file-hook 'sudo-edit-on-etc-files)

;; buffers
(require 'uniquify)
(setq
  uniquify-buffer-name-style 'forward
  uniquify-separator ":")


;; (define-key ido-completion-map (kbd "C-h") 'ido-next-match)
;; (define-key ido-completion-map (kbd "C-t") 'ido-prev-match)

(add-hook 'ido-setup-hook '(lambda ()
  (define-key ido-completion-map (kbd "C-h") 'ido-next-match)
  (define-key ido-completion-map (kbd "<down>") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-t") 'ido-prev-match)
  (define-key ido-completion-map (kbd "<up>") 'ido-prev-match)
  (define-key ido-completion-map (kbd "C-j") 'ido-select-text)
  ;; (define-key ido-completion-map (kbd "ESC") 'ido-exit-minibuffer)
))

(defun delete-current-file (&optional φno-backup-p)
  "Delete the file associated with the current buffer.

Also close the current buffer.  If no file is associated, just close buffer.

A backup file is created with filename appended “~‹date time stamp›~”. Existing file of the same name is overwritten. If the file is not associated with buffer, the backup file name starts with “xx_”.

When called with `universal-argument', don't create backup."
  (interactive "P")
  (let* (
         (fName (buffer-file-name))
         (bufferIsFile-p (if (null fName) nil t ))
         (backupName (concat fName "~" (format-time-string "%Y%m%d_%H%M%S") "~")))
    (if bufferIsFile-p
        (progn
          (save-buffer fName)
          (if φno-backup-p
              nil
            (copy-file fName backupName t))
          (delete-file fName)
          (message "deleted and backup created at 「%s」." backupName))
      (progn
        (if φno-backup-p
            nil
          (write-region (point-min) (point-max) (concat "xx_~" (format-time-string "%Y%m%d_%H%M%S") "~")))))
    (kill-buffer (current-buffer))))
