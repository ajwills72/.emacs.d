;; Auto-added
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (andy)))
 '(custom-safe-themes
   (quote
    ("a16732011dcb5a3b50a5007d4c41b444761545e286ee58839931972c4455fe57" "84890723510d225c45aaff941a7e201606a48b973f0121cb9bcb0b9399be8cba" default)))
 '(org-agenda-files (quote ("~/svn/notes-andy/todo-new.org")))
 '(package-selected-packages
   (quote
    (quarto-mode yaml-mode ## poly-R polymode auctex fireplace notmuch ess elpy)))
 '(tool-bar-mode nil))

;; I should install the following packages from MELPA
;; M-x package-list-packages
;; ess, auctex, polymode, poly-R, elpy, markdown-mode

;; Defaults across modes: GUI
(tool-bar-mode -1) ;; No toolbar
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; Defaults across modes: Text editing
(setq-default fill-column 79) ;; GNU standard width
(setq column-number-mode t) ;; Show column number

;; Package manager  
(package-initialize)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Alphabetical list of modes starts below

;; AUCTeX (LaTeX mode)
(require 'reftex)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'turn-on-visual-line-mode)

;;Elpy (Python mode)
(elpy-enable)
(setq python-shell-completion-native-enable nil)
(setq elpy-rpc-python-command "python3")
;; C-RET does not work in a remote terminal session, add M-RET as an alternative
(eval-after-load "elpy"
  '(progn
     (define-key elpy-mode-map [(control return)] nil)
     (define-key elpy-mode-map (kbd "<M-RET>") 'elpy-shell-send-statement-and-step)
     )
  )

;; Also manually install these packages:
;; pip install rope jedi importmagic autopep8 flake8

;; HTML mode
(defun my-html-mode-hook ()
  (auto-fill-mode 1)
  (visual-line-mode -1)
  )
(add-hook 'html-mode-hook 'my-html-mode-hook)

;; Markdown mode
(add-hook 'markdown-mode-hook 'turn-on-visual-line-mode)

;; Mutt (email client integration)
(server-start)
(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))
;; use C-k to close buffer.
(defun my-mail-mode-hook ()
   ;;(auto-fill-mode 1)
   (abbrev-mode 1)
   (local-set-key "\C-Xk" 'server-edit))
   (add-hook 'mail-mode-hook 'my-mail-mode-hook)

;; notmuch (email search integration)
(autoload 'notmuch "notmuch" "notmuch mail" t)

;; Octave mode
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))

;; Org mode
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-font-lock-mode 1)
(eval-after-load "org"
  '(require 'ox-md nil t))
(add-hook 'org-mode-hook 'turn-on-visual-line-mode)
(setq org-startup-with-inline-images t)

;; Text mode
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 143 :width normal))))
 '(term-color-blue ((t (:background "blue2" :foreground "deep sky blue"))))
 '(term-color-red ((t (:background "red3" :foreground "tomato")))))

;;Yaml mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; Save workspace
(desktop-save-mode 1)

;; Region highlight colour
(set-face-attribute 'region nil :background "#400000")

;; load the library
(require 'quarto-mode)
