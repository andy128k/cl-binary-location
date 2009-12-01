;; -*- mode: Common-Lisp -*-

(in-package :common-lisp-user)

(defpackage cl-binary-location-system
  (:use :common-lisp :asdf))

(in-package :cl-binary-location-system)

(defsystem "cl-binary-location"
  :description "Binary location detection"
  :version "0.1"
  :author "Andrey Kutejko <andy128k@gmail.com>"
  :licence "LGPL"
  :depends-on (:cffi)
  :components ((:file "cl-binary-location.package")
               (:file "cl-binary-location.main" :depends-on ("cl-binary-location.package"))))

