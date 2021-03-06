;; backup

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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
 '(cperl-indent-parens-as-block t)
 '(custom-safe-themes
   (quote
    ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(frame-background-mode (quote dark))
 '(magit-auto-revert-mode nil)
 '(menu-bar-mode nil)
 '(nxml-child-indent 2)
 '(org-src-fontify-natively t)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (2048-game toml-mode perl6-mode ssh-config-mode ack-menu go-mode rust-mode ssh yaml-mode magit color-theme-solarized ada-mode ack)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(transient-mark-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#002b36" :foreground "#839496" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 180 :width normal :foundry "PfEd" :family "DejaVu Sans Mono")))))

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
(setenv "PAGER" "cat")
(setenv "DEBIAN_FRONTEND" "Readline")

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
(global-set-key (kbd "C-/") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c o") 'browse-url-at-point)
(global-set-key (kbd "C-c f") 'find-file-at-point)
(global-set-key (kbd "C-c t") 'toggle-truncate-lines)

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

(defun sudo-find-file (file-name)
  "Like find file, but opens the file as root."
  (interactive "FSudo Find File: ")
  (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
    (find-file tramp-file-name)))

(global-set-key (kbd "C-x C-r") 'sudo-find-file)

(require 'sql)
(add-hook 'sql-mode-hook
          (lambda ()
            (modify-syntax-entry ?\\ "\\" sql-mode-syntax-table)))

(defun align-sql-create ()
  "Aligns SQL create table statements"
  (interactive)
  (align-regexp (region-beginning) (region-end) "\\(\s\s*\\)\\(\\bbigint\\b\\|\\bbigserial\\b\\|\\bbit\\b\\|\\bbool\\b\\|\\bboolean\\b\\|\\bbox\\b\\|\\bbytea\\b\\|\\bchar\\b\\|\\bcharacter\\b\\|\\bcidr\\b\\|\\bcircle\\b\\|\\bdate\\b\\|\\bdatetime\\b\\|\\bdecimal\\b\\|\\bdouble\\b\\|\\bfloat4\\b\\|\\bfloat8\\b\\|\\binet\\b\\|\\bint\\b\\|\\bint2\\b\\|\\bint4\\b\\|\\bint8\\b\\|\\binteger\\b\\|\\binterval\\b\\|\\bjson\\b\\|\\bjsonb\\b\\|\\bline\\b\\|\\blseg\\b\\|\\bmacaddr\\b\\|\\bmoney\\b\\|\\bnumeric\\b\\|\\bpath\\b\\|\\bpg_lsn\\b\\|\\bpoint\\b\\|\\bpolygon\\b\\|\\breal\\b\\|\\bserial\\b\\|\\bserial2\\b\\|\\bserial4\\b\\|\\bserial8\\b\\|\\bsmallint\\b\\|\\bsmallserial\\b\\|\\btext\\b\\|\\btime\\b\\|\\btimestamp\\b\\|\\btimestamptz\\b\\|\\btimetz\\b\\|\\btsquery\\b\\|\\btsvector\\b\\|\\btxid_snapshot\\b\\|\\buuid\\b\\|\\bvarbit\\b\\|\\bvarchar\\b\\|\\bxml\\b\\|\\bnumber\\b\\|\\bvarchar2\\b\\|\\bclob\\b\\)")
  (align-regexp (region-beginning) (region-end) "\\(\s\s*\\)\\(NOT NULL\\|NULL\\)")
  (align-regexp (region-beginning) (region-end) "\\(\s\s*\\)NULL"))

(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

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

; (add-to-list 'custom-theme-load-path "~/.emacs.d/lisp/emacs-color-theme-solarized")
(load-theme 'solarized)

(server-start)

(put 'upcase-region 'disabled nil)

(add-hook 'js-mode-hook (lambda() (setq compile-command (concat "eslint --format unix " (file-name-nondirectory buffer-file-name)))))
; (add-hook 'js-mode-hook (lambda() (setq compile-command (concat "eslint --format unix " (file-name-nondirectory buffer-file-name)))))

(autoload 'forth-mode "gforth.el")
(autoload 'forth-block-mode "gforth.el")

(defun ora-apt-progress-message (progress)
  (message
   (replace-regexp-in-string
    "%" "%%"
    (ansi-color-apply progress))))

(defun ora-ansi-color-apply-on-region (begin end)
  "Fix progress bars for e.g. apt(8).
Display progress in the mode line instead."
  (let ((end-marker (copy-marker end))
        mb)
    (save-excursion
      (goto-char (copy-marker begin))
      (while (re-search-forward "\0337" end-marker t)
        (setq mb (match-beginning 0))
        (when (re-search-forward "\0338" end-marker t)
          (ora-apt-progress-message
           (substring-no-properties
            (delete-and-extract-region mb (point))
            2 -2)))))))

(advice-add
 'ansi-color-apply-on-region
 :before 'ora-ansi-color-apply-on-region)
(put 'dired-find-alternate-file 'disabled nil)


(require 'ssh)
(add-hook 'ssh-mode-hook
          (lambda ()
            (setq ssh-directory-tracking-mode t)
            (shell-dirtrack-mode t)
            (setq dirtrackp t)))
