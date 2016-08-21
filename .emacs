;; backup
(setq make-backup-files nil)

(setq-default
      indent-tabs-mode nil
      js-indent-level 2
      fill-column 90)

;; Settings
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ada-auto-case nil)
 '(ada-case-strict nil)
 '(comint-input-ring-size 1024)
 '(custom-safe-themes
   (quote
    ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(frame-background-mode (quote dark))
 '(menu-bar-mode nil)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("marmalade" . "http://marmalade-repo.org/packages/"))))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(transient-mark-mode nil))

(setq font-lock-maximum-decoration t)
(setq visible-bell t)
(setq require-final-newline t)
(setq column-number-mode t)
(setq-default transient-mark-mode nil)
(blink-cursor-mode 1)
(tool-bar-mode -1)
(tooltip-mode -1)
(line-number-mode 1)
(column-number-mode 1)

(setenv "NODE_NO_READLINE" "1")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Kill the splash screen
(setq inhibit-splash-screen t)

;; Window Movement
(global-set-key [M-left] 'windmove-left)
(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key [M-down] 'windmove-down)
(global-set-key (kbd "C-c <down>") 'windmove-down)

;; cperl-mode is preferred to perl-mode
(defalias 'perl-mode 'cperl-mode)

(defun generate-guid ()
  "Generates a guid in the format of microsoft"
  (interactive)
  (insert (format "{%X%X%X%X%X%X%X%X-%X%X%X%X-%X%X%X%X-%X%X%X%X-%X%X%X%X%X%X%X%X%X%X%X%X}" (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16) (random 16))))

(defun launch-mysql ()
  "Launches a mysql server with the general log output and tailed"
  (interactive)
  (let ((general-log "/var/log/mysql/mysql.log")
        (error-log "/var/log/mysql/error.log"))
    (if (get-buffer "*mysql-log*") (kill-buffer "*mysql-log*"))
    (find-file general-log)
    (rename-buffer "*mysql-log*")
    (auto-revert-tail-mode 1)
    (find-file error-log)
    (if (get-buffer "*mysql-error-log*") (kill-buffer "*mysql-error-log*"))
    (rename-buffer "*mysql-error-log*")
    (auto-revert-tail-mode 1))
  )

(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)
(add-to-list 'comint-output-filter-functions 'comint-strip-ctrl-m)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'shell-mode-hook '(lambda () (setq comint-process-echoes t)))

(add-to-list 'load-path "~/.emacs.d/lisp")
(load "ampl-mode")

(setq auto-mode-alist
      (cons '("\\.mod$" . ampl-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.dat$" . ampl-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.ampl$" . ampl-mode) auto-mode-alist))
(setq interpreter-mode-alist
      (cons '("ampl" . ampl-mode)
            interpreter-mode-alist))

;; Enable syntax coloring
(add-hook 'ampl-mode-hook 'turn-on-font-lock)

(setq ampl-auto-close-parenthesis nil)
(setq ampl-auto-close-brackets nil)
(setq ampl-auto-close-curlies nil)
(setq ampl-auto-close-double-quote nil)
(setq ampl-auto-close-single-quote nil)

(add-to-list 'custom-theme-load-path "~/.emacs.d/lisp/emacs-color-theme-solarized")
(load-theme 'solarized)

(server-start)

(put 'dired-find-alternate-file 'disabled nil)
(put 'upcase-region 'disabled nil)

(add-hook 'js-mode-hook (lambda() (setq compile-command (concat "eslint --format unix " (file-name-nondirectory buffer-file-name)))))

(autoload 'forth-mode "gforth.el")
(autoload 'forth-block-mode "gforth.el")
(add-to-list 'auto-mode-alist '("\\.fs$" . forth-mode))
