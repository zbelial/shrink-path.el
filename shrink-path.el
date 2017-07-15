;;; shrink-path.el --- fish-style path -*- lexical-binding: t; -*-

;; Copyright (C) 2017 Benjamin Andresen

;; Author: Benjamin Andresen
;; Version: 0.0.1
;; Keywords: path
;; URL: http://github.com/shrink-path.el/shrink-path.el
;; Package-Requires: ((s "1.6.1") (dash "1.8.0") (f "0.10.0"))

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;; No commentary

;;; Code:
(require 'dash)
(require 's)
(require 'f)

(defun shrink-path (&optional path)
  "Given PATH return fish-styled shrunken down path."
  (let* ((path (or path default-directory))
         (path (f-full path))
         (split (f-split path)))
    (cond
     ((s-equals? (f-short path) "/") "/")
     ((s-equals? (f-short path) "~") "~/")

     ((f-descendant-of? path "~")
      (let ((shrunked (-map (lambda (segment)
                              (s-left (if (s-starts-with? "." segment) 2 1)
                                      segment))
                            (-> split (-slice 3 -1)))))
        (s-concat "~/" (s-join "/" shrunked) "/" (s-join "" (last split)) "/")))
     (t
      (let ((shrunked (-map (lambda (segment)
                              (s-left (if (s-starts-with? "." segment) 2 1)
                                      segment))
                            (-> split (-slice 1 -1)))))
        (s-concat "/" (s-join "/" shrunked) "/" (s-join "" (last split)) "/"))))))


(provide 'shrink-path)
;;; shrink-path.el ends here