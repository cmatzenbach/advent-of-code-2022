;;; item-priorities.el --- AoC Day 3 Solutions       -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Chris Matzenbach

;; Author: Chris Matzenbach <matzy@proton.me>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:



;;; Code:
(load-file "../utils/file-to-string.el")
(load-file "./letter-mappings.el")

(defvar *rucksack* (file-to-string "./data.el"))
(defvar *t-rucksack* (file-to-string "./test-data.el"))

(defvar *letter-weights* (make-hash-table :test 'equal))
(defun complete-weight-hash-table ()
    (dolist (letter-map *letter-mappings*)
        (puthash (car letter-map) (car (cdr letter-map)) *letter-weights*)))
(complete-weight-hash-table)

;; first split strings in half
(defun split-str-half (str)
    (let ((len (length str)))
        (list (substring str 0 (/ len 2)) (substring str (/ len 2) len))))

;; find matches between strings
(defun )


(provide 'item-priorities)
;;; item-priorities.el ends here
