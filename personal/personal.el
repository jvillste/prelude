(prelude-require-packages '(highlight-symbol
                            hideshow
                            iedit
                            paredit
                                        ;cider
                                        ;midje-mode
                                        ;paredit-menu
                            auto-complete
                            ac-nrepl
                            fuzzy))

;; ac-nrepl

(require 'ac-nrepl)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))

(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))
(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)

(add-hook 'cider-repl-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)

(add-hook 'cider-repl-mode-hook 'auto-complete-mode)


;; always split horizontaly

(setq split-height-threshold 0)
(setq split-width-threshold nil)

;; MAC

;;; Set command as meta
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

;; FONT

(set-face-font 'default "-*-fixed-regular-r-*-*-13-*-*-*-*-*-*")


(defun open-personal ()
  (interactive)
  (find-file "~/.emacs.d/personal/personal.el"))
(global-set-key [f7] 'open-personal)

(require 'cider)
(require 'hideshow)
                                        ;(require 'auto-complete)
;;enable arrow keys
(setq prelude-guru nil)

;; disable current line highlighting
(global-hl-line-mode -1)

;; disable whitespace mode
(setq prelude-whitespace nil)


(define-key cider-mode-map (kbd "TAB") 'cider-repl-indent-and-complete-symbol)
(define-key cider-mode-map (kbd "C-c j") 'ace-jump-mode)
(define-key cider-mode-map (kbd "C-c C-y") 'iedit-mode)
(define-key cider-mode-map (kbd "C-c C-ö") (lambda ()
                                             (interactive)
                                             (switch-to-buffer "*cider-error*")))
(define-key cider-mode-map (kbd "C-c C-ä") (lambda ()
                                             (interactive)
                                             (switch-to-buffer "*nrepl-server flow-gl*")))

(define-key cider-mode-map (kbd "M-n") 'cider-jump-to-compilation-error)


;; Magit

(set-variable 'magit-emacsclient-executable "/usr/local/Cellar/emacs/24.3/bin/emacsclient")

(defun magit-commit-and-push-all ()
  (interactive)
  (message "committing and pushing")
  (magit-run-git "commit" "-am" "X")
  (magit-run-git "push")
  (message "ready"))
(global-set-key (kbd "C-c .") 'magit-commit-and-push-all)


(defun my-prog-mode-defaults ()
  (smartparens-mode -1))
(add-hook 'prelude-prog-mode-hook 'my-prog-mode-defaults t)

(defun my-clojure-mode-defaults ()
  (paredit-mode +1)
  (auto-complete-mode +1)
  ;;(midje-mode +1)
  (clojure-test-mode -1)
  (flyspell-mode -1)
  (smartparens-strict-mode -1))
(add-hook 'prelude-clojure-mode-hook 'my-clojure-mode-defaults t)


;; cider refresh
(defun cider-refresh ()
  (interactive)
  (save-buffer)
  (cider-interactive-eval "(require 'midje.repl)(require 'flow-gl.refresh)(flow-gl.refresh/refresh)"))
(global-set-key [f5] 'cider-refresh)

;; cider load-facts
(defun cider-load-facts ()
  (interactive)
  (save-buffer)
  (cider-interactive-eval "(require 'midje.repl)(require 'flow-gl.refresh)(flow-gl.refresh/load-facts)"))
(global-set-key [f4] 'cider-load-facts)

;; cider check-facts
(defun cider-check-facts ()
  (interactive)
  (save-buffer)
  (cider-eval-defun-at-point)
  (cider-interactive-eval "(require 'midje.repl)(midje.repl/check-facts)"))
(global-set-key [f6] 'cider-check-facts)


;; cider check-facts
(defun cider-start ()
  (interactive)
  (cider-repl-set-ns (cider-current-ns))
  (cider-interactive-eval "(start)"))
(global-set-key [f7] 'cider-start)


;; cider restart
(global-set-key [f9] 'cider-restart)

;; save and load buffer
(defun load-cider-buffer ()
  (interactive)
  (save-buffer)
  (cider-load-current-buffer))
(define-key cider-mode-map (kbd "C-c C-k") 'load-cider-buffer)


(defun git-diftool-current-buffer ()
  (interactive)
  (start-process  "git-difftool" "git-difftool" "git" "difftool" "-y" (buffer-file-name)))
(define-key cider-mode-map (kbd "C-c m") 'git-diftool-current-buffer)

;; highlight-symbol-mode
                                        ;(add-hook 'cider-mode-hook 'highlight-symbol-mode)
(set 'highlight-symbol-idle-delay 0.1)
(define-key clojure-mode-map [(meta f3)] 'highlight-symbol-mode)
(define-key clojure-mode-map [f3] 'highlight-symbol-next)
(define-key clojure-mode-map [(shift f3)] 'highlight-symbol-prev)


;; hideshow-mode
(add-hook 'clojure-mode-hook 'hs-minor-mode)
(define-key clojure-mode-map (kbd "C-c C-u") 'hs-hide-all)
(define-key clojure-mode-map (kbd "C-c C-o") 'hs-show-all)


(set 'whitespace-line-column 200)


;; tree text

(setq tree-text-keywords
      '(("\(:li.*?\n.*?\)" . font-lock-function-name-face)
        ("\(\:[:alpha:].*" . font-lock-function-name-face)
        ("\(:ch" . font-lock-function-name-face)))

(define-derived-mode tree-text-mode fundamental-mode
  (setq font-lock-defaults '(tree-text-keywords))
  (setq mode-name "ttxt"))
