;;这个文件是用来不同的机器上work文件夹的路径不同，直接同步会导致org-agenda等扩展没法用，所以把涉及到路径的内容从.emacs中拆出来放在这里，这个文件夹内容不同步
(provide 'diffdir)
(defun my-find-file ()
  (interactive)
  (let ((default-directory "d:/work"))
    (call-interactively #'find-file)))
 
(setq org-agenda-files '("d:/work/org"
			 "~/.emacs.d/org"))
;;中文与外文字体设置
(defun set-font (english chinese english-size chinese-size)
  (set-face-attribute 'default nil :font
                      (format   "%s:pixelsize=%d"  english english-size))
  (if (window-system)  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset
                      (font-spec :family chinese :size chinese-size)))))
(set-font "CaskaydiaCove NF" "微软雅黑" 26 30);;这里的大小设置是为了在table中对齐，保证两个英文是一个中文的宽度，但是现在英文会比较小
