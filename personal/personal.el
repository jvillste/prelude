(prelude-require-packages '(highlight-symbol
                            hideshow
                            iedit
                            paredit
                            ;midje-mode
                            ;paredit-menu
                            ;auto-complete
                            ;ac-nrepl
                            ))

;; ac-nrepl

;(require 'ac-nrepl)
;; (add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
;; (add-hook 'cider-mode-hook 'ac-nrepl-setup)
;; (eval-after-load "auto-complete"
;;   '(add-to-list 'ac-modes 'cider-repl-mode))

;(defun set-auto-complete-as-completion-at-point-function ()
;  (setq completion-at-point-functions '(auto-complete)))
;(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)

;(add-hook 'cider-repl-mode-hook 'set-auto-complete-as-completion-at-point-function)




;(eval-after-load "cider"
;  '(define-key cider-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc))



;;; ---------  (add-hook 'cider-mode-hook (lambda () (add-to-list completion-at-point-functions ')))


(set-face-font 'default "-*-fixed-regular-r-*-*-13-*-*-*-*-*-*")

(defun open-personal ()
  (interactive)
  (find-file "~/.emacs.d/personal/personal.el"))
(global-set-key [f7] 'open-personal)

(require 'cider)
(require 'hideshow)
(require 'auto-complete)
;;enable arrow keys
(setq prelude-guru nil)

;; disable current line highlighting
(global-hl-line-mode -1)

(define-key cider-mode-map (kbd "TAB") 'cider-repl-indent-and-complete-symbol)
(define-key cider-mode-map (kbd "C-c j") 'ace-jump-mode)
(define-key cider-mode-map (kbd "C-c C-y") 'iedit-mode)
(define-key cider-mode-map (kbd "C-c C-ö") (lambda ()
                                             (interactive)
                                             (switch-to-buffer "*cider-error*")))


(defun my-prog-mode-defaults ()
  (smartparens-mode -1))
(add-hook 'prelude-prog-mode-hook 'my-prog-mode-defaults t)

(defun my-clojure-mode-defaults ()
  (paredit-mode +1)
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
(define-key clojure-mode-map [(control f3)] 'highlight-symbol-mode)
(define-key clojure-mode-map [f3] 'highlight-symbol-next)
(define-key clojure-mode-map [(shift f3)] 'highlight-symbol-prev)


;; hideshow-mode
(add-hook 'clojure-mode-hook 'hs-minor-mode)
(define-key clojure-mode-map (kbd "C-c C-u") 'hs-hide-all)
(define-key clojure-mode-map (kbd "C-c C-o") 'hs-show-all)


(set 'whitespace-line-column 200)
