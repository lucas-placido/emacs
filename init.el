; Remover boas vindas					;
(setq inhibit-startup-message t)

; Remover menu
(tool-bar-mode -1)
(menu-bar-mode -1)

; Remover scroll bar
(scroll-bar-mode -1)

; Inserir numero das linhas
(global-display-line-numbers-mode 1)

;; Tamanho da fonte
(set-face-attribute 'default nil :height 120)
