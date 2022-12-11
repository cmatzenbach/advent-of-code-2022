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

;; first-col
;; A - Rock
;; B - Paper
;; C - Scissors

;; second-col
;; X - Rock
;; Y - Paper
;; Z - Scissors

;; second-col round 2
;; X - lose
;; Y - draw
;; Z - win

;; score-per-round
;; 1 - Rock
;; 2 - Paper
;; 3 - Scissors
;; plus (+)
;; 0 - loss
;; 3 - draw
;; 6 - win

;; *t-strategy-guide*
;; A Y
;; B X
;; C Z

;;; Code:
(load-file "../utils/file-to-string.el")

(defvar *strategy-guide* (file-to-string "./data.el"))
(defvar *t-strategy-guide* (file-to-string "./test-data.el"))
(defvar *player-score* 0)
(defvar *opponent-score* 0)

(defun reset-scores ()
    (progn
        (setq *player-score* 0)
        (setq *opponent-score* 0)))

(defun separate-round-data-to-lists (data)
    (remq nil (mapcar #'(lambda (round)
                     (if (not (string-empty-p round))
                         (list (substring round 0 1) (substring round 2 3))))
           (split-string data "\n"))))

(defun check-choice-pts (choice)
    (cond
        ((or (string-equal "A" choice) (string-equal "X" choice)) 1)
        ((or (string-equal "B" choice) (string-equal "Y" choice)) 2)
        ((or (string-equal "C" choice) (string-equal "Z" choice)) 3)))

(defun calc-round-winner (opp player)
    (cond
        ((or (and (string-equal "A" opp) (string-equal "Z" player))
             (and (string-equal "B" opp) (string-equal "Y" player))
             (and (string-equal "C" opp) (string-equal "Z" player)))
            (progn
                (setq *player-score* (+ *player-score* 3))
                (setq *opponent-score* (+ *opponent-score* 3))))
        ((or (and (string-equal "A" opp) (string-equal "Y" player))
             (and (string-equal "B" opp) (string-equal "Z" player))
             (and (string-equal "C" opp) (string-equal "X" player)))
            (setq *player-score* (+ *player-score* 6)))
        ((or (and (string-equal "A" opp) (string-equal "Z" player))
             (and (string-equal "B" opp) (string-equal "X" player))
             (and (string-equal "C" opp) (string-equal "Y" player)))
            (setq *opponent-score* (+ *opponent-score* 6)))))

;; for part 2 - calculate needed choice
(defun calc-needed-choice (opp res)
    (cond
        ;; you need to lose - opp win
        ((string-equal res "X")
            (cond
                ;; rock - scissors
                ((string-equal "A" opp) "Z")
                ;; paper - rock
                ((string-equal "B" opp) "X")
                ;; scissors - paper
                ((string-equal "C" opp) "Y")))
        ;; draw
        ((string-equal res "Y")
            (cond
                ((string-equal "A" opp) "X")
                ((string-equal "B" opp) "Y")
                ((string-equal "C" opp) "Z")))
        ;; you need to win - opp lose
        ((string-equal res "Z")
            (cond
                ;; rock - paper
                ((string-equal "A" opp) "Y")
                ;; paper - scissors
                ((string-equal "B" opp) "Z")
                ;; scissors - rock
                ((string-equal "C" opp) "X")))))
(calc-needed-choice "B" "Z")

(defun calculate-scores (rounds-list)
    (dolist (curr-round rounds-list)
        (let ((opp (car curr-round))
                 (player (car (cdr curr-round))))
            (progn
                (setq *opponent-score* (+ *opponent-score* (check-choice-pts opp)))
                (setq *player-score* (+ *player-score* (check-choice-pts player)))
                (calc-round-winner opp player))))
    (list "player:" *player-score* " & " "opponent" *opponent-score*))

(defun calculate-scores-pt-2 (rounds-list)
    (dolist (curr-round rounds-list)
        (let* ((opp (car curr-round))
                  (res (car (cdr curr-round)))
                  (player (calc-needed-choice opp res)))
            (progn
                (setq *opponent-score* (+ *opponent-score* (check-choice-pts opp)))
                (setq *player-score* (+ *player-score* (check-choice-pts player)))
                (calc-round-winner opp player))))
    (list "player:" *player-score* " & " "opponent" *opponent-score*))

(reset-scores)
(calculate-scores (separate-round-data-to-lists *t-strategy-guide*))

(reset-scores)
(calculate-scores-pt-2 (separate-round-data-to-lists *t-strategy-guide*))

(reset-scores)
(calculate-scores (separate-round-data-to-lists *strategy-guide*))

(reset-scores)
(calculate-scores-pt-2 (separate-round-data-to-lists *strategy-guide*))

(provide 'strategy-guide)
;;; strategy-guide.el ends here
