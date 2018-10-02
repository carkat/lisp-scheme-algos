(asdf:defsystem :99lisp
    :description "solving 99 problems of lisp on the wall"
    :version "0.0.1"
    :author "nanthil"
    :licence ""
    :components ((:file "test99"
		  :depends-on "1_20")
		 (:file "1_20")))
