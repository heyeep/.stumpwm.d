;; -*-list-*-

;; Initiate
(in-package :stumpwm)
(setf *data-dir* "~/.stumpwm.d/")
(setf *module-dir* "modules/")

;; Focusing
(setf *mouse-focus-policy* :click)

;;; Theme
;; Window Appearance
(setf *normal-border-width* 1
      *transient-border-width* 1
      *maxsize-border-width* 0
      *window-border-style* :thin) ; :thick :thin :tight :none

;; Windows
(setf *startup-message* "StumpWM"
      *timeout-wait* 10
      *message-window-gravity* :center
      *message-window-padding* 16
      *input-window-gravity* :center)
(set-focus-color "#fdf6e3")
(set-unfocus-color "#073642")
(set-win-bg-color "#002b36")
(set-msg-border-width 2)

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
(define-key *root-map* (kbd "b") "firefox")
(define-key *root-map* (kbd "f") "conkeror")
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

(defcommand conkeror () ()
  "Start/Switch to Chromium"
  (run-or-raise "conkeror" '(:class "exec conkeror")))

(defcommand !reload () ()
  "Reload StumpWM using 'loadrc'"
  (run-commands "reload" "loadrc"))

(defcommand !restart () ()
  "Restart StumpWM"
  (run-commands "restart-hard"))

(defcommand search-variable (&optional (initial "")) (:rest)
  (let ((cmd (read-one-line (current-screen) "SEARCH: " :initial-input initial)))
    (when cmd
      (echo-string (current-screen) cmd))))

;;(define-key *root-map* (kbd "f") "search-variable")

;;(defcommand zf (string) ()
 ;; "Printout the valof a variable"
  ;;(echo-string (current-screen) "Cake."))
;;; WIP Workplace
;; |0    |1     |
;; |     |      |
;; |     |------|
;; |     |2     |
;; |     |      |
(defcommand start-workspace () ()
  "Set up workplace"
  (run-commands "grename Default")
  (restore-from-file "~/.stumpwm.d/workplaces/default.desktop")
  (restore-window-placement-rules "~/.stumpwm.d/workplaces/default.windows")
  (define-frame-preference "Default"
    (0 t t :class "Firefox")
    (2 t t :class "Emacs")
    (1 t t :title "urxvt"))
  (run-commands "firefox"
                "exec urxvt"
                "Emacs"))
;;; Modeline
;; (if (not (head-mode-line (current-head)))
;;     (toggle-mode-line (current-screen) (current-head)))

;;; Modules
;; TODO: Power
;; (load-module "power")
;; (power:start-laptop-lid-watcher)

;; Gaps
(load-module "swm-gaps")
(setf swm-gaps:*inner-gaps-size* 4)
(setf swm-gaps:*outer-gaps-size* 8)
(run-commands "toggle-gaps")

;; Apple Keys
;; Sound
(define-key *top-map* (kbd "XF86AudioRaiseVolume") "exec amixer set Master playback 5%+")
(define-key *top-map* (kbd "XF86AudioLowerVolume") "exec amixer set Master playback 5%-")
(define-key *top-map* (kbd "XF86AudioMute") "exec pactl set-sink-mute 0 toggle")

;; System
;; TODO: Doesn't properly suspend
;; (define-key *top-map* (kbd "XF86Eject") "exec systemctl suspend")

;; Keyboard Dimming
;; TODO: Currently not working
(define-key *top-map* (kbd "XF86KbdBrightnessDown") "exec kbdlight down")
(define-key *top-map* (kbd "XF86KbdBrightnessUp") "exec kbdlight up")

(run-commands "start-workspace")
