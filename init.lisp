;; -*-list-*-

;; Initiate
(in-package :stumpwm)

;;; Scripts ;;;
;; (stumpwm:run-shell-command "xterm")
(stumpwm:run-shell-command "~/.hiepscripts/mapKeys.sh")

;;; Key Bindings ;;;
;; Set prefix to Windows key
;; .xmodmap
;; clear mod4
;; keycode 133 = F20
(set-prefix-key (kbd "F20"))

;;; Defaults ;;;
;; Change Cursor
(stumpwm:run-shell-command "xsetroot -cursor_name left_ptr")
