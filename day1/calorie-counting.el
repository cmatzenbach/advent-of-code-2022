;;; calorie-counting.el --- AoC Day 1 Challenge      -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Chris Matzenbach

;; Author: Chris Matzenbach <matzy@proton.me>

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

;;

;;; Code:
(load-file "../utils/file-to-string.el")

(defvar *total-cals* (file-to-string "./data.el"))

(defun get-cals-per-elf-numerical-list (cals-list)
    (mapcar #'(lambda (elf)
                  (mapcar #'string-to-number (split-string elf "\n")))
        (split-string cals-list "\n\n")))

(defun set-top-3-cals (top-3-list elf-list)
    (let ((lowest (car (setq top-3-list (sort top-3-list '<))))
          (elf-sum (apply '+ elf-list)))
        (if (> elf-sum lowest)
            (progn
                (setq top-3-list (delete lowest top-3-list))
                (setq top-3-list (push elf-sum top-3-list))))))

(set-top-3-cals '(15 4 9) '(6 1 10))
(set-top-3-cals '(44 15 5) '(6 1 10 1 1 1))

(defun separate-calories-per-elf (input)
    (let ((most-cals 0))
        (setq cals-list (get-cals-per-elf-numerical-list input))
        (dolist (cals-elf cals-list)
            (if (> (apply '+ cals-elf) most-cals)
                (setq most-cals (apply '+ cals-elf))))
        (print most-cals)))

(defun calories-per-top-3-elves (input)
    (let ((most-cals 0)
          (top-3 '(1 2 3)))
        (setq elf-cals-list (get-cals-per-elf-numerical-list input))
        (dolist (cals-elf elf-cals-list)
            (setq top-3 (set-top-3-cals top-3 cals-elf))
            ;; (print cals-elf)
            )
        top-3
        ))

(set-top-3-cals '(1 3 2) '(10062 15651 1271 14355 7220))

(setq test-elves "2
2
2

4
4
4

6
6
6

8
8
8")
(calories-per-top-3-elves test-elves)

(separate-calories-per-elf *total-cals*)

(calories-per-top-3-elves *total-cals*)

(calories-per-top-3-elves
    "10
10
10

20
20
20

30
30
30")



(provide 'calorie-counting)
;;; calorie-counting.el ends here
