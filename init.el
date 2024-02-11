;;; init.el --- Initialization file for Emacs
;;; Commentary: Emacs Startup File --- initialization for Emacs

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

; Pacotes
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
  :bind("C-<tab>" . ace-window))

;; (use-package elpy
;;   :ensure t
;;   :init (elpy-enable))

;; (use-package flycheck
;;   :ensure t
;;   :init (global-flycheck-mode t))

;; Python
;; blacken
;; py-autopep8


(package-initialize) ; iniciar pacotes
(package-refresh-contents)

; Atalhos personalizados
(global-set-key (kbd "C-<tab>") 'other-window)

(global-set-key (kbd "M-<down>") 'enlarge-window)
(global-set-key (kbd "M-<up>") 'shrink-window)
(global-set-key (kbd "M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-<left>") 'shrink-window-horizontally)

(global-set-key (kbd "C-<delete>") 'delete-window)
(global-set-key (kbd "C-e") 'kill-ring-save) ; copy
(global-set-key (kbd "C-;") 'comment-line)

; Cria prefixo C-z
(define-prefix-command 'C-z-map)
(global-set-key (kbd "C-z") 'C-z-map)

(global-set-key (kbd "C-z <right>") 'split-window-right)
(global-set-key (kbd "C-z <down>") 'split-window-below)

; Melpa stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(magit elpy flycheck ace-window all-the-icons neotree which-key try)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
