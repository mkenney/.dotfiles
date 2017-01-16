;; Slime
(add-to-list 'load-path "/usr/share/emacs/site-lisp/slime")
(require 'slime)
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

;; Optionally, specify the lisp program you are using. Default is "lisp"
(setq inferior-lisp-program "sbcl")

;; Matching paren highlight
(show-paren-mode 1)
(setq show-paren-delay 0)
