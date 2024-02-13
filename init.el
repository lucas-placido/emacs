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
(set-face-attribute 'default nil :height 120 :family "Nimala UI") ; (font-family-list) C-j
(setq custom-safe-themes t)

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

(use-package nerd-icons
  :ensure t)

(use-package doom-themes
  :ensure t
  :config
    (load-theme 'doom-one t))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config (progn
	    (setq doom-modeline-env-version t)
	    (setq auto-revert-check-vc-info t)
	    (setq doom-modeline-total-line-number t)
	    (if (facep 'mode-line-active)
		(set-face-attribute 'mode-line-active nil :family "Segoe UI Black" :height 100)
	      (set-face-attribute 'mode-line nil :family "Segoe UI Black" :height 100)n)))

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
	      (setq projectile-enable-caching t)))             
    
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
 '(custom-enabled-themes '(doom-Iosvkem))
 '(custom-safe-themes
   '("6f96a9ece5fdd0d3e04daea6aa63e13be26b48717820aa7b5889c602764cf23a" "8b148cf8154d34917dfc794b5d0fe65f21e9155977a36a5985f89c09a9669aa0" "456697e914823ee45365b843c89fbc79191fdbaff471b29aad9dcbe0ee1d5641" "6f1f6a1a3cff62cc860ad6e787151b9b8599f4471d40ed746ea2819fcd184e1a" "d6b934330450d9de1112cbb7617eaf929244d192c4ffb1b9e6b63ad574784aad" "4ade6b630ba8cbab10703b27fd05bb43aaf8a3e5ba8c2dc1ea4a2de5f8d45882" "4e2e42e9306813763e2e62f115da71b485458a36e8b4c24e17a2168c45c9cf9d" "dccf4a8f1aaf5f24d2ab63af1aa75fd9d535c83377f8e26380162e888be0c6a9" "b5fd9c7429d52190235f2383e47d340d7ff769f141cd8f9e7a4629a81abc6b19" "014cb63097fc7dbda3edf53eb09802237961cbb4c9e9abd705f23b86511b0a69" default))
 '(package-selected-packages
   '(doom-modeline all-the-icons-dired dired-hide-dotfiles dired doom-themes ivy projectile auto-virtualenv pytest blacken pyvenv pyenv magit elpy flycheck ace-window all-the-icons neotree which-key try))
 '(safe-local-variable-values '((eval venv-workon "elpy/rpc-venv/"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
