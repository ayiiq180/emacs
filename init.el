;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(package-initialize)
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/rc/")
(require 'diffdir)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(add-to-list 'file-coding-system-alist '("\\.org" . utf-8))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (wombat)))
 '(package-selected-packages
   (quote
    (yasnippet evil-nerd-commenter pinyin-search windresize helm-org pdf-tools company helm))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "spring green"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "navajo white"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "light slate blue"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "dark olive green"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "RoyalBlue3"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "DeepPink2")))))
;;(set-default-font "Cascadia Code-11")
;;  ;; 中文字体的设置，同时解决中英文字体宽度不一致的问题（org-mode的表格可以中英文对齐）。
;;   ;; 而且解决了中文字体导致emacs卡的现象。这里有个问题，终端下会出错
;;(if (window-system)  (dolist (charset '(kana han cjk-misc bopomofo))
;;    (set-fontset-font (frame-parameter nil 'font) charset
;;                      (font-spec :family "微软雅黑" :size 26))))
;;20200131,因为几个机器上的放大不一致，导致字体设置出现的大小差异太大，所以都放在diffdir.el里面设置了,下面的部分是代码，这里不用
;;---------------------------------
;;;;中文与外文字体设置
;;(defun set-font (english chinese english-size chinese-size)
;;  (set-face-attribute 'default nil :font
;;                      (format   "%s:pixelsize=%d"  english english-size))
;;  (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;    (set-fontset-font (frame-parameter nil 'font) charset
;;                      (font-spec :family chinese :size chinese-size))))
;;(set-font "Cascadia Code" "微软雅黑" 30 30)
;;---------------------------------
;; 显示设置------------------------------
;;默认打开窗口的大小，不过因为设置了记录desktop，所以就没用了
(if (window-system) (set-frame-width (selected-frame) 140))
(if (window-system) (set-frame-height (selected-frame) 55))
;;默认打开窗口的大小，不过因为设置了记录desktop，所以就没用了

(desktop-save-mode 1);;这里是为了保存emacs的工作状态，下次打开的时候自动打开上次的文件

(setq make-backup-files nil)   ;;关闭自动备份

;;实现每次闪烁光标变化颜色，因为直接设置光标颜色没效果
(defvar blink-cursor-colors (list  "#92c48f" "#6785c5" "#be369c" "#d9ca65")
  "On each blink the cursor will cycle to the next color in this list.")
(setq blink-cursor-count 0)
(defun blink-cursor-timer-function ()
  "Zarza wrote this cyberpunk variant of timer `blink-cursor-timer'. 
Warning: overwrites original version in `frame.el'.

This one changes the cursor color on each blink. Define colors in `blink-cursor-colors'."
  (when (not (internal-show-cursor-p))
    (when (>= blink-cursor-count (length blink-cursor-colors))
      (setq blink-cursor-count 0))
    (set-cursor-color (nth blink-cursor-count blink-cursor-colors))
    (setq blink-cursor-count (+ 1 blink-cursor-count))
    )
  (internal-show-cursor nil (not (internal-show-cursor-p)))
  )
;;实现每次闪烁光标变化颜色，因为直接设置光标颜色没效果
(display-time-mode 1) ;; 常显
(setq display-time-24hr-format t) ;;格式
(setq display-time-day-and-date t) ;;显示时间、星期、日期
(tool-bar-mode 0)
;;(menu-bar-mode 0)
(scroll-bar-mode 0)
(global-hl-line-mode 1)
(set-face-background 'hl-line "#380d31")
(set-face-foreground 'highlight nil)
(global-linum-mode 1);;显示行号,因为和pdf-view冲突，先关闭看看
(setq linum-formart "%d|  ")

;; 显示设置------------------------------
;; 键绑定
(global-set-key (kbd "C-x C-f") 'my-find-file)
(define-key global-map "\C-cf" 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(define-prefix-command 'my-helm-commands)
(define-key global-map "\C-ce" 'my-helm-commands) ;这里绑定一个heml-command-prefix，后面定义命令绑定的时候可以直接用这个前缀，用法类似下面
;; (define-key my-helm-commands "b" 'helm-buffers-list)
;; (define-key my-helm-commands "f" 'helm-find-files)
(define-key my-helm-commands "l" 'helm-locate)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "\C-cm") 'helm-mini);;整合了buffer和最近文件的一个列表
(global-set-key (kbd "\C-cr") 'helm-recentf);;用来列出最近打开过的文件列表
(global-set-key (kbd "\C-cp") 'helm-etags-select);;绑定函数tags跳转命令
;; 键绑定
;; org-mode设置
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)));;这是为了让org-mode自动换行
(add-hook 'org-mode-hook 'org-indent-mode)
(setq org-log-done 'time);;add a timestamp when TODO changed
(global-set-key (kbd "C-c a") 'org-agenda)
;在执行程序的时候，不需要确认
(setq org-confirm-babel-evaluate nil)

;设定文档中需要执行的程序类型
(org-babel-do-load-languages
      'org-babel-load-languages
      '((emacs-lisp . t)
        (C . t)
        (java . t)
        (js . t)
        (ruby . t)
        (ditaa . t)
        (python . t)
        (shell . t)
        (latex . t)
        (plantuml . t)
        (R . t)))
;; 让中文也可以不加空格就使用行内格式  2020-02-18 20:27:57
;; (setcar (nthcdr 0 org-emphasis-regexp-components) " \t('\"{[:nonascii:]")
;; (setcar (nthcdr 1 org-emphasis-regexp-components) "- \t.,:!?;'\")}\\[[:nonascii:]")
(setq org-emphasis-regexp-components '("-[:multibyte:][:space:]('\"{" "-[:multibyte:][:space:].,:!?;'\")}\\[" "[:space:]" "." 1))
(org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
(org-element-update-syntax)
;; 规定上下标必须加 {}，否则中文使用下划线时它会以为是两个连着的下标 2020-02-18 20:27:57
(setq org-use-sub-superscripts "{}")
(setq org-todo-keywords
  '((sequence "TODO(t!)" "PENDING(p!)" "|" "DONE(d!)" "ABORT(a@/!)")
))
(setq org-todo-keyword-faces
  '(("PENDING" .   (:background "red" :foreground "white" :weight bold))
    ("TODO" .      (:background "DarkOrange" :foreground "black" :weight bold))
    ("DONE" .      (:background "green" :foreground "black" :weight bold)) 
    ("ABORT" .     (:background "gray" :foreground "black"))
    ))
;;这里是为了能够在org-mode中对不同的字体修饰显示不同的颜色
(setq org-emphasis-alist
  '(("*" (bold :foreground "Orange" ))
    ("/" (italic :foreground "Greenyellow"))
    ("_" underline)
    ("=" (:background "maroon" :foreground "yellow")) ;代码
    ("~" (:background "deep sky blue" :foreground "MistyRose")) ;逐字，原样导出
    ("+" (:strike-through t :foreground "grey"))))		   ;删除线
(setq org-src-fontify-natively t)
(require 'org-bullets)			;使heading前面的*更好看一些
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq inhibit-compacting-font-caches t)	;显示unicode字符
;;为了限定org-mode里的图片预览的大小，暂时好像没作用
(setq org-image-actual-width nil)
;; 捕捉设置
;; (setq org-default-notes-file (expand-file-name "~/.emacs.d/org/notes.org")) ;默认捕捉位置，设置了下面的模板后就没用了
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      '(("n" "Notes" entry (file "~/.emacs.d/org/notes.org")
               "* %^{heading} %t %^g\n  %?\n")
	("t" "Todo" entry (file+headline "~/.emacs.d/org/gtd.org" "Tasks")
         "* TODO %?\n %i\n %a")
        ("j" "Journal" entry (file+datetree "~/.emacs.d/org/journal.org")
         "* %?\nEntered on %U\n %i\n %a")))
;;设置导出的html格式
(setq org-html-doctype "html5")
(setq org-html-html5-fancy t)
(setq org-html-xml-declaration nil)	;不生成xml头部信息
(setq org-html-postamble nil)		;默认情况下导出的HTML末尾会有几行信息, 例如由org8导出, 作者是谁谁谁,日期多少多少. 我觉得这部分信息比较low, 于是通过这行代码取消postamble的生成.
(setq org-html-head
      "<link rel=\"stylesheet\" href=\"images/style.css\">")
;;导出pdf设置
;; set latex to xelatex
;; use minted to highlight code in latex
;; (require 'ox-latex)
;; (add-to-list 'org-latex-packages-alist '("" "minted"))
;; (setq org-latex-listings 'minted) ;;这里一直出错，添加上就会出现参数错误，无法编译
;; (setq org-latex-pdf-process '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;                               "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
;; 如果要用minted实现代码pdf高亮，就要用参数-shell-escape
(setq org-latex-pdf-process '("xelatex -interaction nonstopmode -output-directory %o %f"
                              "xelatex -interaction nonstopmode -output-directory %o %f"))
;; org-mode设置
;;这里是用来在切换buffer的时候出现一个彩虹条防止看不到光标
;;(load-file "d:/emacs-26.3/share/emacs/site-lisp/beacon.el")
;;(beacon-mode 1)

;; evil设置
(add-to-list 'load-path "~/.emacs.d/lisp/evil")
(require 'evil)
(evil-mode 1)
;;这里试图想搞定C-u直接把单词大写，但还弄不清楚evil的键绑定怎么写ESC,搞定了
(evil-define-key 'insert 'global (kbd "C-u") (kbd "<escape>gUiwea"))
;;绑定evil的leader键到,
;(evil-set-leader 'normal ",") 
;; 快速注释，安装了包 evil-nerd-commenter

(evilnc-default-hotkeys nil t)		;仅evil-mode绑定快捷键
;; evil设置

;; markdown设置
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
(setq markdown-command "pandoc")
;;(setq shell-file-name (executable-find "bash.exe"))
;; markdown设置
(require 'rainbow-delimiters)		;彩虹括号
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(require 'autopair)		     ;括号自动
(autopair-global-mode) ;; enable autopair in all buffers
;; 自动补全
(add-hook 'after-init-hook 'global-company-mode);;Completion will start automatically after you type a few letters. Use M-n and M-p to select, <return> to complete or <tab> to complete the common part. Search through the completions with C-s, C-r and C-o. Press M-(digit) to quickly complete with one of the first 10 candidates.

(require 'powerline)
(powerline-default-theme)
;; helm设置
;;helm-org
;(global-set-key (kbd "\C-ch") 'helm-org-in-buffer-headings);;org文件把heading列到buffer里
(define-key my-helm-commands "h" 'helm-org-in-buffer-headings);;org文件把heading列到buffer里
(global-set-key (kbd "\C-cx") 'helm-org-agenda-files-headings);;org文件把agenda列表里的所有org的heading列到buffer里
(global-set-key [(f6)] 'helm-find)

;; helm设置
;;;windresize

(require 'windresize)
 (global-set-key (kbd "C-c s") 'windresize)
;;;Winner-mode
;;可以使用 Ctrl-c ← （就是向左的箭头键）组合键，退回你的上一个窗口设置。）
;;可以使用 Ctrl-c → （前进一个窗口设置。）
(when (fboundp 'winner-mode) 
  (winner-mode) 
  (windmove-default-keybindings)) 

;;;windmove-mode
(when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings)
    (global-set-key (kbd "C-c j")  'windmove-down)
    (global-set-key (kbd "C-c l") 'windmove-right)
    (global-set-key (kbd "C-c h")    'windmove-left)
    (global-set-key (kbd "C-c k")  'windmove-up))
;;关于dired的部分
(setq dired-recursive-deletes t) ; 可以递归的删除目录
(setq dired-recursive-copies t) ; 可以递归的进行拷贝
(require 'dired-x) ; 有些特殊的功能
(global-set-key "\C-x\C-j" 'dired-jump) ; 通过 C-x C-j 跳转到当前目录的 Dired
;;让dired复用一个buffer，不产生n多个无用的buffer
(put 'dired-find-alternate-file 'disabled nil)
;; 延迟加载
(with-eval-after-load 'dired
    (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))
;; ====================

;; insert date and time

(defvar current-date-time-format (format-time-string "%Y-%m-%d %H:%M:%S")
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defvar current-time-format "%H:%M:%S"
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")

(defun insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
       (interactive)
       (insert " ")
;       (insert (let () (comment-start)))
       (insert (format-time-string current-date-time-format (current-time)))
;       (insert "\n")
       )

(defun insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
       (interactive)
       (insert (format-time-string current-time-format (current-time)))
;       (insert "\n")
       )

(global-set-key "\C-c\C-d" 'insert-current-date-time)
(global-set-key "\C-c\C-t" 'insert-current-time)
;; insert date and time 

;;拼写检查
(dolist (hook '(text-mode-hook))
      (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
      (add-hook hook (lambda () (flyspell-mode -1))))
;; use apsell as ispell backend
(setq-default ispell-program-name "aspell")
;; use American English as ispell default dictionary
(ispell-change-dictionary "american" t)
;;拼写检查 end
(pdf-tools-install)
(setq explicit-shell-file-name "zsh")

;; yas设置
(add-hook 'prog-mode-hook 'yas-minor-mode)
(setq yas-snippet-dirs
'("~/.emacs.d/snippets";;personal snippets
    ))
(yas-global-mode 1)
;; yas设置
