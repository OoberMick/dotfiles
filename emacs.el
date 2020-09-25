;; Basic fiddly stuff

(package-initialize)

(if window-system
    (tool-bar-mode -1))
(menu-bar-mode -1)
(setq visible-bell t)

;; The macOS visual bell is fugly
(defun sane-visual-bell ()
  "A sane visual bell."
  (invert-face 'mode-line)
  (run-with-timer 0.1 nil 'invert-face 'mode-line))
(setq ring-bell-function 'sane-visual-bell)

(load-theme 'tango-dark)
(setq inhibit-startup-message t)
(column-number-mode 1)
(setq-default show-trailing-whitespace t)

;; C stuff
(setq-default tab-width 4)
(setq c-default-style "bsd"
      c-basic-offset tab-width)

;; Case switch don't indent
(add-hook 'c-mode-common-hook
          (lambda()
            (c-set-offset 'inextern-lang 0)))

;; Set sane diff mode
(setq diff-switches "-u")

;; Functions
(defadvice show-paren-function
  (after show-matching-paren-offscreen activate)
  "If the matching paren is offscreen, show the matching line in the
        echo area. Has no effect if the character before point is not of
        the syntax class ')'."
  (interactive)
  (let* ((cb (char-before (point)))
         (matching-text (and cb
                             (char-equal (char-syntax cb) ?\) )
                             (blink-matching-open))))
    (when matching-text (message matching-text))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(bug-hunter swift-mode typescript-mode magit go-mode plantuml-mode ## dash)))
 '(plantuml-default-exec-mode (quote jar))
 '(plantuml-jar-path "/Applications/plantuml.app/Contents/Java/plantuml.jar"))

;; Magit hacking for MacOS

(add-to-list 'load-path "~/.emacs.d/site-lisp/with-editor")
(add-to-list 'load-path "~/.emacs.d/site-lisp/ghub")
(add-to-list 'load-path "~/.emacs.d/site-lisp/magit-popup")
(add-to-list 'load-path "~/.emacs.d/site-lisp/magit/lisp")
(if (require 'magit nil t)
    (global-set-key (kbd "C-x g") 'magit-status))

(with-eval-after-load 'info
  (info-initialize)
  (add-to-list 'Info-directory-list
               "~/.emacs.d/site-lisp/magit/Documentation/"))

;; Add MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Enable PlantUML mode for .puml files
(add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))
;; (add-hook 'plantuml-mode-hook
;; 	  (lambda ()
;; 	    (setq-local indent-line-function 'indent-relative)
;; 	    (setq-local indent-tabs-mode nil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq ispell-macos-name "/Users/migraham/.homebrew/bin/aspell")

(if (file-exists-p ispell-macos-name)
    (setq ispell-program-name ispell-macos-name))

(setq ispell-dictionary "en_GB")
