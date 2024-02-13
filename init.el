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
;; (load-theme 'misterioso)

; Escape
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


; Create folder to save backups
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))

;;; Pacotes
(require 'package)
(setq package-enable-at-startup nil) ; desativar ativação

; MELPA
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

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
  :config (dired-hide-dotfiles-mode))

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))
(setq neo-theme (if (display-graphic-p) 'icons 'icons))

(use-package all-the-icons-dired
  :ensure t
  :hook (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(use-package doom-themes
  :ensure t
  :config
    (load-theme 'doom-one t))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

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

(use-package projectile
    :ensure t
    :init (projectile-global-mode)
    :config (progn
	      (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
	      (setq venv-location "C:/Users/lucas/AppData/Local/Programs/Python/")
	      (setq venv-dirlookup-names '(".venv" "venv" ".env" "env" "pyenv" ".virtual"))
	      (setq projectile-enable-caching t)
	      )
)             
    
(use-package ivy
  :ensure t
  :init (ivy-mode)
  :config (progn
	    (setq ivy-use-virtual-buffers t)
            (setq enable-recursive-minibuffers t)
            (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)))


;; Python
(use-package elpy
  :ensure t
  :init (elpy-enable))
(add-hook 'elpy-mode-hook (lambda ()
                            (add-hook 'before-save-hook
                                      'elpy-black-fix-code nil t)))

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

; Cria prefixo C-z
(define-prefix-command 'C-z-map)
(global-set-key (kbd "C-z") 'C-z-map)

; 

; Python
(global-set-key (kbd "<f7>") (kbd "C-u C-c C-c")) ; elpy shortcut


;;; Melpa stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(doom-modeline all-the-icons-dired dired-hide-dotfiles dired doom-themes ivy projectile auto-virtualenv pytest blacken pyvenv pyenv magit elpy flycheck ace-window all-the-icons neotree which-key try))
 '(safe-local-variable-values '((eval venv-workon "elpy/rpc-venv/"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
