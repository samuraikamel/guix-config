(define-module (systems base-system)
  #:use-module (gnu)
  #:use-module (guix)
  #:export (base-system))

(use-service-modules networking ssh)

(define base-system
    (operating-system
        (host-name "base-system")
        (locale "en_US.utf8")
        (timezone "America/Los_Angeles")
        (keyboard-layout (keyboard-layout "us"))



        (firmware '())

        (bootloader (bootloader-configuration
                     (bootloader grub-bootloader)
                     (targets '("/dev/vda"))
                     (terminal-outputs '(console))))

        (file-systems (cons (file-system
                              (mount-point "/")
                              (device "/dev/vda1")
                              (type "ext4"))
                            %base-file-systems))

        (users (cons (user-account
                        (name "samuraikamel")
                        (comment "samuraikamel")
                        (group "users")
                        (home-directory "/home/samuraikamel")
                        (supplementary-groups '("wheel" "netdev" "audio" "video")))
                      %base-user-accounts))))
