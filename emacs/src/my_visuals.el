;; visuals.el

;;; Code:
(load "src/my_theme")

;; tiny face
(set-face-attribute 'default nil :font "Ubuntu Mono 18" :height 125)

(set-face-attribute 'default nil :font "InputMonoNarrow ExLight" :height 115)
(setq-default line-spacing 8)

;; (set-face-attribute 'default nil :font "InputMonoNarrow ExLight" :height 120)
;; (setq-default line-spacing 8)

;; (set-face-attribute 'default nil :font "InputMonoNarrow ExLight" :height 125)
;; (setq-default line-spacing 8)

;; (set-face-attribute 'default nil :font "InputMonoNarrow ExLight" :height 130)
;; (setq-default line-spacing 9)

;; (set-face-attribute 'default nil :font "InputMonoNarrow ExLight" :height 140)
;; (setq-default line-spacing 10)

;; (set-face-attribute 'default nil :font "InputMonoNarrow ExLight" :height 150)
;; (setq-default line-spacing 11)

;; laptop face
;; (set-face-attribute 'default nil :font "Ubuntu Mono 18" :height 140)

;; home face
;; (set-face-attribute 'default nil :font "Ubuntu Mono 18" :height 155)

;; work face
;; (set-face-attribute 'default nil :font "Ubuntu Mono 18" :height 180)

;; pairing face
;; (set-face-attribute 'default nil :font "Ubuntu Mono 18" :height 195)

;; hangout face
;; (set-face-attribute 'default nil :font "Ubuntu Mono 18" :height 275)

;; (defun window-width-to-font-size (window-width)
  ;; (+ 140 (floor (* window-width 0.135)))
;; )

;; (add-to-list
 ;; 'window-size-change-functions
 ;; (lambda (frame)
   ;; (dolist (window (window-list frame))
     ;; (set-face-attribute
      ;; 'default nil
      ;; :height (window-width-to-font-size (window-body-width window))))))


;; nyan nyan
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

;; minor characters and rainbows
(defun pretty-minor-characters ()
  (set-face-foreground 'rainbow-delimiters-depth-1-face "#6b5c51")
  (set-face-foreground 'rainbow-delimiters-depth-2-face "#796c63")
  (set-face-foreground 'rainbow-delimiters-depth-3-face "#85786e")
  (set-face-foreground 'rainbow-delimiters-depth-4-face "#a69689")
  (set-face-foreground 'rainbow-delimiters-depth-5-face "#b9aa9d")
  (set-face-foreground 'rainbow-delimiters-depth-6-face "#ccbeb3")
  (set-face-foreground 'rainbow-delimiters-depth-7-face "#e3d9d2")


  (font-lock-add-keywords nil '(("\\(\\]\\)"           1 '(:foreground "#6d5e52") t)))
  (font-lock-add-keywords nil '(("\\(\\[\\)"           1 '(:foreground "#6d5e52") t)))
  (font-lock-add-keywords nil '(("\\(}\\)"           1 '(:foreground "#6d5e52") t)))
  (font-lock-add-keywords nil '(("\\({\\)"           1 '(:foreground "#6d5e52") t)))
  (font-lock-add-keywords nil '(("\\(:\\)"           1 '(:foreground "#6d5e52") t)))
  (font-lock-add-keywords nil '(("\\(;\\)"           1 '(:foreground "#6d5e52") t)))

  ;; why don:t these ones work???
  ;; (font-lock-add-keywords nil '(("\\('\\)"           1 '(:foreground "#6d5e52") t)))
  ;; (font-lock-add-keywords nil '(("\\(;\\)"           1 '(:foreground "#6d5e52") t)))
  ;; (font-lock-add-keywords nil '(("\\(,\\)"           1 '(:foreground "#6d5e52") t)))
  ;; (font-lock-add-keywords nil '(("\\(\\.\\)"         1 '(:foreground "#6d5e52") t)))
)

;; (add-hook 'js2-mode-hook 'pretty-minor-characters)
(add-hook 'css-mode-hook 'pretty-minor-characters)
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'sass-mode-hook 'rainbow-mode)

;; whitespace
(require 'whitespace)
(custom-set-faces
 '(whitespace-tab ((t (:background "#2e2827" :foreground "#2e2827"))))
 '(sp-pair-overlay-face ((t (:background "#2e2827"))))
 '(sp-wrap-overlay-face ((t (:background "#2e2827"))))
 '(sp-wrap-tag-overlay-face ((t (:background "#2e2827"))))
 '(sp-show-pair-match-face ((t (:background "#2e2827"))))
 '(sp-show-pair-mismatch-face ((t (:background "#2e2827"))))
)
(setq whitespace-style (quote
   (face tabs tab-mark)))
(global-whitespace-mode t)

(add-hook 'prog-mode-hook 'whitespace-mode)
(global-git-gutter+-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; git gutter
(set-face-foreground 'git-gutter+-modified "#473e3d")
(set-face-foreground 'git-gutter+-added "#473e3d")
(set-face-foreground 'git-gutter+-deleted "#473e3d")

(custom-set-variables
 '(git-gutter:window-width 1)
 '(git-gutter:modified-sign "+")
 '(git-gutter:added-sign "!")
 '(git-gutter:deleted-sign "-"))
