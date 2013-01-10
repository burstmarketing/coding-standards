(defun buffer-cleanup()
  (interactive)
  (buffer-cleanup-safe)
  (indent-region (point-min) (point-max)))

(defun buffer-cleanup-safe()
  "Unless its a markdown file, do some cleaning up."
  (interactive)
  (unless (and (buffer-file-name)
               (string-equal (file-name-extension (buffer-file-name)) "md"))
    (whitespace-cleanup)
    (untabify (point-min) (point-max))
    (set-buffer-file-coding-system 'utf-8)))

(global-set-key (kbd "C-c n") 'buffer-cleanup)

(add-hook 'before-save-hook 'buffer-cleanup-safe)

(autoload 'php-mode "php-mode" "Major mode for PHP." t)
(add-to-list 'auto-mode-alist '("\\.\\(php\\|phtml\\)\\'" . php-mode))

(add-hook 'php-mode-hook (lambda()
                           (setq indent-tabs-mode nil)
                           (setq tab-width 2)
                           (setq c-basic-offset 2)))

(require 'flymake)
(add-hook 'php-mode-hook 'flymake-mode-on)

(require 'align)
(add-to-list 'align-rules-list
             `(php-array-keys
               (regexp  . "\\(\\s-*\\)=")
               (justify . nil)
               (repeat  . nil)
               (modes   . '(php-mode))
               (tab-stop)))

(setq-default indent-tabs-mode nil)

(provide 'coding-standards)
