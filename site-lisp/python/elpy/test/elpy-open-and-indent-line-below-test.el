;; This randomly breaks on Travis for some reason I have not yet
;; understood.

;; (ert-deftest elpy-open-and-indent-line-below ()
;;   (elpy-testcase ()
;;     (elpy-enable)
;;     (python-mode)
;;     (insert "def foo():\n")
;;     (goto-char 2)
;;     (elpy-open-and-indent-line-below)
;;     (should (or (equal (buffer-string)
;;                        "def foo():\n    \n")
;;                 (equal (buffer-string)
;;                        "def foo():\n\n")))
;;     (should (equal (point) (- (point-max)
;;                               1)))))
