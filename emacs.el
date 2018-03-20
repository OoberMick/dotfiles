;; Basic fiddly stuff

(tool-bar-mode -1)
(menu-bar-mode -1)
(setq visible-bell 1)
(load-theme 'tango-dark)
(setq inhibit-startup-message t)
(column-number-mode 1)
(setq-default show-trailing-whitespace t)

;; C stuff
(setq c-default-style "bsd"
      c-basic-offset 4)

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
