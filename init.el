;;; init.el --- Initialization file for Emacs
;;; Commentary: Emacs Startup File --- initialization for Emacs

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
(set-face-attribute 'default nil :height 120)

; Tema
(load-theme 'misterioso)

;;; Pacotes
(require 'package)
(setq package-enable-at-startup nil) ; desativar ativação

; MELPA
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package auto-complete
  :ensure t
  :init (progn
	  (ac-config-default)
	  (global-auto-complete-mode t)))

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package neotree
  :ensure t
  :config (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  :bind (("C-\\" . 'neotree-toggle)))

(use-package ace-window
  :ensure t
  :bind("M-o" . ace-window))

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


;; Python
;; (use-package pyvenv
;;   :ensure t
;;   :init (pyvenv-mode))

;; (use-package blacken
;;   :ensure t
;;   :init (blacken-mode)
;;   :hook (add-hook 'python-mode-hook 'blacken-mode))

;; (use-package py-autopep8
;;   :ensure t
;;   :init (py-autopep8-mode)
;;   :hook (add-hook 'python-mode-hook 'py-autopep8-mode))

;; (use-package py-isort
;;   :ensure t
;;   :hook (add-hook 'before-save-hook 'py-isort-before-save))

;; (use-package pytest
;;   :ensure t)
  

(use-package elpy
  :ensure t
  :init (elpy-enable)
  :config (progn
	    (flymake-mode -1))
  :hook (add-hook 'python-mode-hook 'blaken-mode))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode t))

; inicializa o pacote
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

; Cria prefixo C-z
(define-prefix-command 'C-z-map)
(global-set-key (kbd "C-z") 'C-z-map)

; Cria janelas
(global-set-key (kbd "C-z <right>") 'split-window-right)
(global-set-key (kbd "C-z <down>") 'split-window-below)

; Python
(global-set-key (kbd "<f7>") (kbd "C-u C-c C-c"))

;;; Melpa stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(pytest blacken pyvenv pyenv magit elpy flycheck ace-window all-the-icons neotree which-key try)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
