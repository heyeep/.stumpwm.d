;; -*-list-*-

;; Initiate
(in-package :stumpwm)

;;; Theme
;; Window Appearance
(setf *normal-border-width* 1
      *maxsize-border-width* 0
      *window-border-style* :thick) ; :thick :thin :tight :none

;; Change Cursor
(stumpwm:run-shell-command "xsetroot -cursor_name left_ptr")

;; Font
(set-font "-adobe-helvetica-medium-r-normal--12*")

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
(define-key *root-map* (kbd "e") "emacs")
(define-key *root-map* (kbd "C-e") "emacs")
(define-key *root-map* (kbd "c") "exec urxvt")
(define-key *root-map* (kbd "C-c") "exec urxvt")
(define-key *root-map* (kbd "C-s") "swank")
(define-key *root-map* (kbd "f") "firefox")
(define-key *root-map* (kbd "g") "chromium")
(define-key *top-map* (kbd "s-g") "toggle-gaps")

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

;;; Commands
(defcommand firefox () ()
  "Start/Switch to FireFox"
  (run-or-raise "firefox" '(:class "Firefox")))

(defcommand emacs () ()
  "Start/Switch to Emacs"
  (run-or-raise "emacs" '(:class "Emacs")))

(defcommand chromium () ()
  "Start/Switch to Chromium"
  (run-or-raise "chromium" '(:class "Chromium")))

;;; Modeline
(if (not (head-mode-line (current-head)))
     (toggle-mode-line (current-screen) (current-head)))

;;; Modules
;; TODO: Power
;;;(load-module "power")
;; (power:start-laptop-lid-watcher)

;; Gaps
(load-module "swm-gaps")
(setf swm-gaps:*inner-gaps-size* 15)
(setf swm-gaps:*outer-gaps-size* 30)
(run-commands "toggle-gaps")

;;; TODO: Startup Applications
;; (defcommand start-applications)
