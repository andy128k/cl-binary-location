;; -*- mode: Common-Lisp -*-

(in-package :cl-binary-location)

#+ :sbcl (progn
(require 'sb-posix)

(defparameter *location* (sb-posix:readlink #p"/proc/self/exe")))

#- :sbcl
(error "Unsupported lisp implementation.")

