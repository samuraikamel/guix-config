(define-module (systems nekoro)
    ; [TODO] clean up which modules are actually needed.
    #:use-module (gnu)
    #:use-module (guix)
    #:use-module (nongnu packages linux)
    #:use-module (nongnu packages nvidia)
    #:use-module (nongnu system linux-initrd)
    #:use-module (nongnu services nvidia)
    #:use-module (systems base-system))


(use-service-modules cups desktop networking ssh xorg)


(operating-system
 (inherit base-system)
 (host-name "nekoro")
 (keyboard-layout (keyboard-layout "us"))

 (kernel-arguments '("modprobe.blacklist=nouveau"))
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))

 (packages (append (list (specification->package "nss-certs"))
                   %base-packages))


 (services
  (append (list (service nvidia-service-type)
                (service xfce-desktop-service-type)
                (set-xorg-configuration
                 (xorg-configuration (keyboard-layout keyboard-layout)
           (modules (cons nvda %default-xorg-modules))
           (drivers '("nvidia"))
                                     )))

          ;; This is the default list of services we
          ;; are appending to.
          %desktop-services))


 (bootloader (bootloader-configuration
               (bootloader grub-efi-removable-bootloader)
               (targets (list "/boot/efi"))
               (keyboard-layout keyboard-layout)))

 (file-systems (cons* (file-system
                        (mount-point "/")
                        (device (uuid
                                 "a981e193-d38d-41aa-aab8-dea93f914222"
                                 'ext4))
                        (type "ext4"))
                      (file-system
                        (mount-point "/boot/efi")
                        (device (uuid "9F49-9D6C"
                                      'fat32))
                        (type "vfat")) %base-file-systems)))
