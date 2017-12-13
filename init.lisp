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

;; Swank
(require :swank)
(swank-loader:init)
(swank:create-server :port 4004
                     :style swank:*communication-style*
                     :dont-close t)
