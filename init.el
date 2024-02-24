;;; package --- Summary
;;; Commentary:
;;; Emacs Startup File --- initialization for Emacs


;;; Code:
;;; Configurações nativas
; Remover boas vindas
(setq inhibit-startup-message t)

; Full Screen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

; Remover menu
(tool-bar-mode -1)
(menu-bar-mode -1)

; Tamanho da janela
(set-frame-parameter nil 'fullscreen 'fullheight)

; Remover scroll bar
(scroll-bar-mode -1)

; Inserir numero das linhas
(global-display-line-numbers-mode 1)

; Tamanho da fonte
(set-face-attribute 'default nil :height 100 :family "JetBrains Mono Medium") ; (font-family-list) C-j

; Tema
;; (load-theme 'misterioso)

; Escape
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

; Auto complete
(electric-pair-mode t)

; Create folder to save backups
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))

; Tira o som da notificação
(setq visible-bell t)

(delete-selection-mode 1)

;;; Pacotes
(require 'package)
(setq package-enable-at-startup nil) ; desativar ativação

; MELPA
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

; Cria prefixo C-z
(define-prefix-command 'C-z-map)
(global-set-key (kbd "C-z") 'C-z-map)


;; Utilizade
(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package auto-complete
  :ensure t
  :init (progn
	  (ac-config-default)
	  (global-auto-complete-mode t)))

(use-package dired-hide-dotfiles
  :ensure t
  :config (dired-hide-dotfiles-mode t))

(use-package neotree
  :ensure t
  :config (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  :bind (("C-\\" . 'neotree-toggle)))

(use-package ace-window
  :ensure t
  :bind("C-<tab>" . ace-window))

(use-package magit
  :ensure t)

(use-package multiple-cursors
  :ensure t
  :config (progn
	    (global-set-key (kbd "C-c <down>") 'set-rectangular-region-anchor)
	    (global-set-key (kbd "C-c <up>") 'set-rectangular-region-anchor)
	    (global-set-key (kbd "C-.") 'mc/mark-next-like-this)
	    (global-set-key (kbd "C-,") 'mc/mark-previous-like-this)
	    (global-set-key (kbd "C-c C-.") 'mc/mark-all-like-this)))

;; (use-package projectile
;;     :ensure t
;;     :init (projectile-mode t)
;;     :config (progn
;; 	      (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; 	      (setq projectile-enable-caching t)))

(use-package ivy
  :ensure t
  :init (ivy-mode)
  :config (progn
	    (setq ivy-use-virtual-buffers t)
            (setq enable-recursive-minibuffers t)
	    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
	    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
	    (global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
	    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
	    (global-set-key (kbd "M-x") 'counsel-M-x)
	    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
	    (global-set-key "\C-s" 'swiper) ; Alternative to isearch
	    (setq ivy-use-selectable-prompt t)
            (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)))

(use-package counsel-projectile
  :ensure t
  :config (counsel-projectile-mode t))

;; Visual
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))
(setq neo-theme (if (display-graphic-p) 'icons 'icons))

(use-package all-the-icons-dired
  :ensure t
  :hook (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(use-package nerd-icons
  :ensure t)

(use-package doom-themes
  :ensure t
  :config (load-theme 'doom-one t))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config (progn
	    (setq doom-modeline-env-version t)
	    (setq doom-modeline-total-line-number t)
	    (if (facep 'mode-line-active)
		(set-face-attribute 'mode-line-active nil :family "Segoe UI Black" :height 110)
	      (set-face-attribute 'mode-line nil :family "Segoe UI Black" :height 100)))
  :defines auto-revert-check-vc-info)

(use-package all-the-icons-ivy-rich
  :ensure t
  :after counsel-projectile
  :init (all-the-icons-ivy-rich-mode +1)
  :config (setq all-the-icons-ivy-rich-icon t))

(use-package ivy-rich
  :ensure t
  :after all-the-icons-ivy-rich
  :init (ivy-rich-mode +1))

;; Python
;; (use-package flycheck
;;   :ensure t
;;   :init (global-flycheck-mode t))

;; (use-package elpy
;;   :ensure t
;;   :init (elpy-enable))
;; (when (load "flycheck" t t)
;;   (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;   (add-hook 'elpy-mode-hook 'flycheck-mode))

;; (add-hook 'elpy-mode-hook (lambda ()
;;                             (add-hook 'before-save-hook
;;                                       'elpy-black-fix-code nil t)))

;; (use-package py-autopep8
;;   :ensure t
;;   :hook ((python-mode) . py-autopep8-mode))

;; (use-package ein)
;; (use-package ein-notebook)

;; Use IPython for REPL
;; (setq python-shell-interpreter "jupyter"
;;       python-shell-interpreter-args "console --simple-prompt"
;;       python-shell-prompt-detect-failure-warning nil)
;; (add-to-list 'python-shell-completion-native-disabled-interpreters
;;              "jupyter")


;; (use-package eshell-toggle
;;   :custom
;;   (eshell-toggle-size-fraction 3)
;;   (eshell-toggle-use-projectile-root t)
;;   (eshell-toggle-run-command nil)
;;   (eshell-toggle-init-function #'eshell-toggle-init-ansi-term)
;;   :bind ("C-z s" . eshell-toggle))

;; (defun shell-other-window ()
;;   "Open a `shell' in a new window."
;;   (interactive)
;;   (let ((buf (shell)))
;;     (switch-to-buffer (other-buffer buf))
;;     (switch-to-buffer-other-window buf)))

;; (global-set-key (kbd "C-z n") 'shell-other-window)


;; (use-package eshell-syntax-highlighting
;;   :after esh-mode
;;   :config
;;   (eshell-syntax-highlighting-global-mode +1))

;; inicializa o pacote
(when (< emacs-major-version 27)
  (package-initialize))


(package-refresh-contents)

;;; Atalhos personalizados
; Configura tamanho das janelas
(global-set-key (kbd "M-<down>") 'enlarge-window)
(global-set-key (kbd "M-<up>") 'shrink-window)
(global-set-key (kbd "M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-<left>") 'shrink-window-horizontally)

(global-set-key (kbd "C-x k") 'kill-this-buffer) ; deleta o buffer sem prompt
(global-set-key (kbd "C-<delete>") 'delete-window) ; deleta janela
(global-set-key "\C-x\C-b" 'buffer-menu) ; abre o menu de buffer na janela atual

(global-set-key (kbd "C-e") 'kill-ring-save) ; copy
(global-set-key (kbd "C-;") 'comment-line) ; comenta a linha

;; Python mode
 ;; (define-key python-mode-map (kbd "TAB") #'indent-region)

; Undo all
(defun undo-all ()
  "Undo all edits."
  (interactive)
  (when (listp pending-undo-list)
    (undo))
  (while (listp pending-undo-list)
    (undo-more 1))
  (message "Buffer was completely undone"))

;; (global-set-key (kbd "C-z") 'undo)
;; (global-set-key (kbd "C-M-z") 'undo-all)


; Python
(global-set-key (kbd "<f7>") (kbd "C-u C-c C-c")) ; elpy shortcut



(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(eshell-syntax-highlighting eshell-toggle which-key py-autopep8 neotree multiple-cursors magit flycheck elpy ein doom-themes doom-modeline dired-hide-dotfiles counsel-projectile auto-complete all-the-icons-ivy-rich all-the-icons-dired ace-window)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
