;; -*- mode: Common-Lisp -*-

(in-package :cl-binary-location)

;;
;; Linux
;;

#+linux
(progn
  (require 'sb-posix)

  (defun location ()
    (truename #p"/proc/self/exe")))

;;
;; Windows
;;

#+windows
(progn

  (eval-when (:compile-toplevel :load-toplevel :execute)
    (cffi:use-foreign-library "kernel32.dll"))

  (cffi:defcfun (get-module-file-name "GetModuleFileNameA") :uint32
    (hmodule :pointer)
    (filename :pointer)
    (size :uint32))

  (defun location ()
    (cffi:with-foreign-object (location :char 256)
      (when (/= 0 (get-module-file-name (cffi:null-pointer) location 256))
        (cffi:foreign-string-to-lisp location)))))

;;
;; Darwin
;;

#+darwin
(progn

  (cffi:defcfun (ns-get-executable-path "_NSGetExecutablePath") :int
    (buf :pointer)
    (bufsize :pointer))

  (defun location ()
    (cffi:with-foreign-objects ((location :char 1024) (size :uint32))
      (setf (cffi:mem-ref size :uint32) 1024)
      (when (= 0 (ns-get-executable-path location size))
        (cffi:foreign-string-to-lisp location)))))

;; error

#-(or linux windows darwin)
(error "Unsupported platform/implementation.")
