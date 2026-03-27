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

;; I can't be typing yes
(setopt use-short-answers t)

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
   '(claude-code company copilot copilot-chat dash go-mode magit
                 markdown-mode monet-mode multiple-cursors
                 plantuml-mode rust-mode smex swift-mode
                 typescript-mode))
 '(package-vc-selected-packages
   '((monet :url "https://github.com/stevemolitor/monet")
     (claude-code :url
                  "https://github.com/stevemolitor/claude-code.el")
     (copilot :url "https://github.com/copilot-emacs/copilot.el"
              :branch "main")))
 '(plantuml-default-exec-mode 'jar)
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
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))

;; Enable PlantUML mode for .puml files
(add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))
;; (add-hook 'plantuml-mode-hook
;;       (lambda ()
;;         (setq-local indent-line-function 'indent-relative)
;;         (setq-local indent-tabs-mode nil)))
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

;; Enable company for everything
(add-hook 'after-init-hook 'global-company-mode)


;; ;; Co-Pilot
;; (use-package copilot
;;   :vc (:url "https://github.com/copilot-emacs/copilot.el"
;;             :rev :newest
;;             :branch "main")
;;   :bind (:map copilot-completion-map
;;          ("M-<tab>" . 'copilot-accept-completion)
;;          ("C-<tab>" . 'copilot-accept-completion-by-word)))
;; (add-hook 'prog-mode-hook 'copilot-mode)

;; ;; Co-Pilot Chat
;; (use-package copilot-chat
;;   :custom
;;   (copilot-chat-backend 'curl))

;; IDO mode
(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)
(setq ido-auto-merge-work-directories-length -1)

;; Smex for M-x
(use-package smex
  :ensure t
  :config
  (smex-initialize))
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; multiple cursors
(use-package multiple-cursors
  :ensure t)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(use-package go-mode
  :ensure t)

;; install required inheritenv dependency:
(use-package inheritenv
  :vc (:url "https://github.com/purcell/inheritenv" :rev :newest))

;; for vterm terminal backend:
(use-package vterm :ensure t)

;; Monet
(use-package monet
  :vc (:url "https://github.com/stevemolitor/monet" :rev :newest))

;; install claude-code.el
(use-package claude-code :ensure t
  :vc (:url "https://github.com/stevemolitor/claude-code.el" :rev :newest)
  :config
  ;; optional IDE integration with Monet
  (add-hook 'claude-code-process-environment-functions #'monet-start-server-function)
  (monet-mode 1)

  (claude-code-mode)
  :bind-keymap ("C-c c" . claude-code-command-map)

  ;; Optionally define a repeat map so that "M" will cycle thru Claude auto-accept/plan/confirm modes after invoking claude-code-cycle-mode / C-c M.
  :bind
  (:repeat-map my-claude-code-map ("M" . claude-code-cycle-mode)))

(setq claude-code-terminal-backend 'vterm)
