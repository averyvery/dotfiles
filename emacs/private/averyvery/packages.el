;;; packages.el --- averyvery Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defvar averyvery-packages
  '(
    elscreen
    emmet-mode
    rainbow-mode
    color-identifiers-mode
    less-css-mode
    scss-mode
    sass-mode
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar averyvery-excluded-packages '()
  "List of packages to exclude.")

(defun averyvery/init-emmet-mode ()
  (use-package emmet-mode
    :init
    (progn
      (define-key evil-insert-state-map [(shift return)] 'emmet-expand-line)
      (add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2)))
      (setq emmet-indentation 2)
      (add-hook 'css-mode-hook  'emmet-mode)
    ))
  )

(defun averyvery/init-rainbow-mode ()
  (use-package emmet-mode
    :init
    (progn
    ))
  )

(defun averyvery/init-less-css-mode ()
  (use-package less-css-mode
    :init
    (progn
      (add-to-list 'auto-mode-alist '("\\.less\\'" . less-css-mode))
      (add-hook 'less-css-mode-hook (lambda () (rainbow-mode 1)))
    ))
  )

(defun averyvery/init-scss-mode ()
  (use-package scss-mode
    :init
    (progn
      (add-to-list 'auto-mode-alist '("\\.scss.css\\'" . scss-mode))
      (add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
      (add-hook 'scss-mode-hook (lambda () (rainbow-mode 1)))
    ))
  )

(defun averyvery/init-sass-mode ()
  (use-package sass-mode
    :init
    (progn
      (add-to-list 'auto-mode-alist '("\\.sass.erb\\'" . sass-mode))
      (add-to-list 'auto-mode-alist '("\\.sass\\'" . sass-mode))
      (add-hook 'sass-mode-hook (lambda () (rainbow-mode 1)))
    ))
  )

(defun averyvery/init-color-identifiers-mode ()
  (use-package color-identifiers-mode
    :init
    (progn
      (add-hook 'prog-mode-hook 'color-identifiers-mode)
    ))
  )

(defun averyvery/init-elscreen ()
  (use-package elscreen
    :init
    (progn
      (elscreen-start)
    )
    )
  )

;; For each package, define a function averyvery/init-<package-averyvery>
;;
;; (defun averyvery/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
