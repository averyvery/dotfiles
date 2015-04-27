(setq css-indent-offset 2)

(defun sass-indent-p ()
  "Return t if the current line can have lines nested beneath it."
  (unless (or (looking-at "^.* :.*$")
              (looking-at "^.*: .*$"))
    (loop for opener in sass-non-block-openers
          if (looking-at opener) return nil
          finally return t)))

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; indentation & tabs
(setq-default js2-indent-level 2)
(setq-default js2-basic-offset 2)
(setq-default js2-bounce-indent-p t)
(setq-default tab-width 2)

(defun tabs ()
  (setq tab-width 2)
  (setq indent-tabs-mode t)
  )

(defun coffee-tabs ()
  (setq coffee-indent-tabs-mode nil)
  (setq indent-tabs-mode nil)
  (setq coffee-tab-width 2)
  )
(add-hook 'coffee-mode-hook 'coffee-tabs)

(defun sass-tweaks ()
  (auto-complete-mode)
  (yas-minor-mode)
  )
(add-hook 'sass-mode-hook 'sass-tweaks)
(add-hook 'scss-mode-hook 'sass-tweaks)

(defun indent-whole-buffer ()
  "indent whole buffer and untabify it"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

;; unused
(defun indent-file-when-save ()
  "indent file when save."
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook
            (lambda ()
              (if (buffer-file-name)
                  (indent-whole-buffer))
              (save-buffer))))

(defun indent-file-when-visit ()
  "indent file when visit."
  (make-local-variable 'find-file-hook)
  (add-hook 'find-file-hook
            (lambda ()
              (if (buffer-file-name)
                  (indent-whole-buffer))
              (save-buffer))))

(evil-leader/set-key "I" 'indent-whole-buffer)
