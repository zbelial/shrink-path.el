;;; test-helper.el --- description -*- lexical-binding: t; -*-

(defvar shrink-path-test/test-path
  (directory-file-name (file-name-directory load-file-name))
  "Path to tests directory.")

(defvar shrink-path-test/root-path
  (directory-file-name (file-name-directory shrink-path-test/test-path))
"Path to root directory.")

(defmacro with-home (home &rest body)
  "Within HOME environment evaluate BODY."
  `(let ((abbreviated-home-dir nil) ; needed for interactive emacs
         (before (getenv "HOME")))
    (setenv "HOME" ,home)
    (let ((result ,@body))
      (setenv "HOME" before)
      result)))

(load (expand-file-name "shrink-path" shrink-path-test/root-path) 'noerror 'nomessage)
