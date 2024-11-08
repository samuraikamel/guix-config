(define-module (home home-config)
    #:use-module (gnu)
    #:use-module (gnu home)
    #:use-module (gnu packages vim)
    #:use-module (gnu packages version-control))

(home-environment
    (packages (list git neovim)))
