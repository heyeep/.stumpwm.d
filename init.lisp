;; -*-list-*-

;; Initiate
(in-package :stumpwm)

;; Change terminal
(setq *terminal* "urxvt")

;;; Scripts ;;;
(run-shell-command "/.hiepscripts/mapKeys.sh")

;;; Key Bindings ;;;
;; Set prefix to Windows key
;; .xmodmap
;; clear mod4
;; keycode 133 = F20
(set-prefix-key (kbd "F20"))
(define-key *root-map* (kbd "c") "exec urxvt")
(define-key *root-map* (kbd "C-c") "exec urxvt")
(define-key *root-map* (kbd "C-s") "swank")

;;; Defaults ;;;
;; Change Cursor
(stumpwm:run-shell-command "xsetroot -cursor_name left_ptr")

;; Font
(set-font "-adobe-helvetica-medium-r-normal--12*")

;; Swank
(load "~/.emacs.d/site-lisp/slime/swank-loader.lisp")
(swank-loader:init)
(let ((server-running nil))
  (defcommand swank () ()
    "Toggle the SWANK server on/off"
    (if server-running
        (progn
          (swank:stop-server 4004)
          (echo-string
           (current-screen)
           "Stopping SWANK.")
          (setf server-running nil))
        (progn
          (swank:create-server :port 4004
                               :style swank:*communication-style*
                               :dont-close t)
          (echo-string
           (current-screen)
           "Starting SWANK. M-x slime-connect RET RET, then (in-package stumpwm).")
          (setf server-running t)))))
