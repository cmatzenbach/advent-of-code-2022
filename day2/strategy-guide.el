;;; strategy-guide.el --- AoC Day 2 Challenge        -*- lexical-binding: t; -*-

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

;;

;;; Code:
(load-file "../utils/file-to-string.el")

(defvar *strategy-guide* (file-to-string "./data.el"))
(defvar *t-strategy-guide* (file-to-string "./test-data.el"))

(defun separate-round-data-to-lists (data)
    (remq nil (mapcar #'(lambda (round)
                     (if (not (string-empty-p round))
                         (list (substring round 0 1) (substring round 2 3))))
           (split-string data "\n"))))

(separate-round-data-to-lists *t-strategy-guide*)

;; first-col
;; A - Rock
;; B - Paper
;; C - Scissors

;; second-col
;; X - Rock
;; Y - Paper
;; Z - Scissors

;; score-per-round
;; 1 - Rock
;; 2 - Paper
;; 3 - Scissors
;; 0 - loss
;; 3 - draw
;; 6 - win

;; *t-strategy-guide*
;; A Y
;; B X
;; C Z



(provide 'strategy-guide)
;;; strategy-guide.el ends here
