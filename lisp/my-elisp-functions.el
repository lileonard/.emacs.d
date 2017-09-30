;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;auto formalize when copying
(dolist (command '(yank yank-pop))
  (eval
   `(defadvice ,command (after indent-region activate)
      (and (not current-prefix-arg)
           (member major-mode
                   '(matlab-mode log-edit-mode org-mode text-mode haml-mode 
                                 sass-mode yaml-mode csv-mode espresso-mode 
                                 html-mode nxml-mode sh-mode smarty-mode 
                                 lisp-mode textile-mode markdown-mode 
                                 js3-mode css-mode less-css-mode sql-mode
                                 emacs-lisp-mode scheme-mode ruby-mode
                                 rspec-mode python-mode haskell-mode
                                 cc-mode c++-mode objc-mode cmake-mode
                                 latex-mode js-mode clojure-mode
                                 plain-tex-mode tuareg-mode))
           (let ((mark-even-if-inactive transient-mark-mode))
             (indent-region (region-beginning) (region-end) nil))))))

(setq auto-insert t)
(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-directory "~/.emacs.insert/")
(define-auto-insert '("\\.\\([Hh]\\|hh\\|hpp\\)\\'" . "C / C++ header") "sample.h")
(define-auto-insert '("\\.\\([Cc]\\|cc\\|cpp\\)\\'" . "C / C++ program") "sample.cpp")
(define-auto-insert '("\\.sh\\'" . "Shell-Script") "sample.sh")

(defun my-insert-time ()
  "Insert the current time"
  (interactive)
  (insert (format-time-string "Time: %X")))

(defun my-insert-date ()
  "Insert the current time"
  (interactive)
  (insert (format-time-string "%h %d, %G")))

(defun my-insert-text%letter ()
  "text the use of letters after %"
  (interactive)
  (insert (format-time-string
"%a-%A-%b-%B-%c-%C
%d-%D-%e-%E-%f-%F
%g-%G-%h-%H-%i-%I
%j-%J-%k-%K-%l-%L
%m-%M-%n-%N-%o-%O
%p-%P-%q-%Q-%r-%R
%s-%S-%t-%T-%u-%U
%v-%V-%w-%V-%x-%X
%y-%Y-%z-%Z
")))

;;auto insert main
(defun my-insert-main ()
  (interactive)
  (insert "
/*
,---------[ Main ]---------------------------
| This is the main function of program <>
| just basic data I/O 
| 
| Author                 | Leonard                  |
| Email                  | liyuanheng.leo@gmail.com |
| Creation time          | ")
(insert (format-time-string "%F "))
 (insert "              |
`--------------------------------------------
*/



int main(int argc, char *argv[])
{
    
    
    return 0;
}\n"
))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;auto insert cout
(defun my-insert-cout ()
    "Insert the cout"
    (interactive)
    (insert (format-time-string "std::cout << <<std::endl;")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-insert-fftmain ()
  (interactive)
  (insert 
   "
/*
,---------[ Main ]------------------------
| This is the main function of program <>
| basic data I/O and FFTW paraments setting
| 
| Author                 | Leonard                  |
| Email                  | liyuanheng.leo@gmail.com |
| Creation time          | ")
  (insert (format-time-string "%F "))
  (insert "              |
`-------------------------------------------
*/

#include <fftw3.h>

fftw_plan fftForward, fftBackward;
using namespace std;
int main(int argc, char *argv[])
{
    const double Pi = 3.1415926535897932384626433832795028841971;
    
//lenthN is the record lenth using in fft
//2^lenthQ = lenthN
    int lenthN = 1;
    int lenthQ = 0;
    while (lenthN < /*recordN*/)
    {
        lenthN *= 2;
        ++lenthQ;
    }
// some paraments used in fftw 
    fftw_complex *fftTime = (fftw_complex*) fftw_malloc(sizeof(fftw_complex)*lenthN);
    fftw_complex *fftFreq = (fftw_complex*) fftw_malloc(sizeof(fftw_complex)*lenthN);
// fftTime suould alwaye store Time domain data,
// the two global structures indicate the flag of FFT(fftForward) and IFFT(fftBackward)

    fftForward  = fftw_plan_dft_1d(lenthN, fftTime, fftFreq, FFTW_FORWARD, FFTW_ESTIMATE);
    fftBackward = fftw_plan_dft_1d(lenthN, fftFreq, fftTime, FFTW_BACKWARD, FFTW_ESTIMATE);
// the two global structures indicate the flag of FFT(fftForward) and IFFT(fftBackward)

    for (int i=0; i</*recordN*/; ++i)
    {
//may be record data here
        fftTime[i][0] = 0.0;
        fftTime[i][1] = 0.0;
        fftFreq[i][0] = 0.0;   
        fftFreq[i][1] = 0.0;   
    }
    for (int i=recordN; i<lenthN; ++i)
    {
//put zero at last
        fftTime[i][0] = 0.0;
        fftTime[i][1] = 0.0;
        fftFreq[i][0] = 0.0;   
        fftFreq[i][1] = 0.0;  
    }
 
    fftw_execute(fftForward);
    fftw_execute(fftBackward);
//noticed that fftw did not uniformize the data like fftTime[i][0]/lenthN

    fftw_destroy_plan(fftForward);
    fftw_destroy_plan(fftBackward);
    fftw_free(fftTime);
    fftw_free(fftFreq);
    fftTime = 0;
    fftFreq = 0;
}\n"
   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto insert a MPI Init introduction
(defun my-insert-MPI_Init ()
  (interactive)
  (insert 
   "
    MPI_Init(&argc, &argv);
    int mpiProcessId = 0;
    int mpiAofProcess = 0;
    MPI_Comm_rank(MPI_COMM_WORLD, &mpiProcessId);
    MPI_Comm_size(MPI_COMM_WORLD, &mpiAofProcess);
    MPI_Status mpiStatus;



    MPI_Finalize();
    "
   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto insert a MPI Init introduction
(defun my-insert-notes ()
  (interactive)
  (insert 
"** paper title
   * properties: 
   * custom ID: 
   * paper links: 
   * bib link: 
   * cite: 
   * notes:
"
   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto insert a for Cpp introduction
(defun my-insert-function-intrduction ()
  (interactive)
  (insert 
   "/*
,---------[ Introduction ]------------------------
| This is the function of program {}
|
|  
|
| Author                 | Leonard                  |
| Email                  | liyuanheng.leo@gmail.com |
| Creation time          | ")
  (insert (format-time-string "%F "))
  (insert "              |
--------------------------------------------------
*/
\n\n\n\n\n\n"
   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;good C language notes
(defun language-note-cdb (title begin end)
  "Note the region with a great C note style
The result is like this:

//**********[ Title ]***************
This is the selected region
//******* Title ends here *********/

it is very good to ues this note-style during debug, however a warning occurred
if a perfect compile is needed at release version, delete them all

if the first / in first line is deleted
the hole text in the region would be noted 
This style will lead to a warnning using <gcc -Wall> so delete useless code in release version

modified from: Survive Under Emacs, Pluskid, 2007
Lyh 2012 <liyuanheng.leo@gmil.com>
"
  (interactive "sTitle: \nr")
  (setq end (copy-marker end t))
  (save-excursion
    (goto-char begin)
    (unless (looking-back "^")
      (insert "\n"))
    (insert "//********** ")
    (insert title)
    (insert " **********************\n")
    (goto-char end)
    (unless (looking-back "^")
      (insert "\n"))
    (insert "//******* ")
    (insert title)
    (insert " ends here****************/\n")))

(defun language-note-c (title begin end)
  "C note
/********** Title ***************/

modified from: Survive Under Emacs, Pluskid, 2007
Lyh 2012 <liyuanheng.leo@gmil.com>
"
  (interactive "sTitle: \nr")
  (insert "\n//********** ")
  (insert title)
  (insert " **********************"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;insert a cool box to selected text 
(defun cool-box (title begin end)
  "Wrap the region with a cool box.
The result is like this:
/*
,----------[ Title ]--------------
| This is the marked region
| that will be boxed
`---------------------------------
*/
"
  (interactive "sTitle: \nr")
  (setq end (copy-marker end t))
  (save-excursion
    (goto-char begin)
    (unless (looking-back "^")
      (insert "\n"))
    (insert "/*\n  ,---------[ ")
    (insert title)
    (insert " ]------------------------\n")
    (while (< (point) end)
      (insert "  | ")
      (next-line)
      (beginning-of-line))
    (goto-char end)
    (unless (looking-back "^")
      (insert "\n"))
    (insert "  | Email : liyuanheng.leo@gmail.com\n")
    (insert (format-time-string "  | Date  : %B %d. %Y\n"))
    (insert "  `-------------------------------------------\n*/\n")))

;;Turn on warn highlighting for characters outside of the 'width' char limit
(defun font-lock-width-keyword (width)
  `((,(format "^%s\\(.+\\)" (make-string width ?.))
     (1 font-lock-warning-face t))))
(font-lock-add-keywords 'c++-mode (font-lock-width-keyword 115))
(font-lock-add-keywords 'c-mode   (font-lock-width-keyword 115))
(font-lock-add-keywords 'emacs-lisp-mode   (font-lock-width-keyword 115))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://www.cppblog.com/tangxinfa/archive/2008/05/23/50705.html
;; c/c++ header include guard
(defun my-insert-include-guard ()
  "insert include guard for c and c++ header file.
for file filename.ext will generate:
#ifndef FILENAME_EXT_
#define FILENAME_EXT_

original buffer content

#endif//FILENAME_EXT_
"
  (interactive)
  (setq file-macro
        (concat
         (replace-regexp-in-string
          "\\." "_"
          (upcase
           (file-name-nondirectory buffer-file-name))) "_"))
  (setq guard-begin (concat "#ifndef " file-macro "\n"
                "#define " file-macro "\n\n"))
  (setq guard-end
    (concat "\n\n#endif//" file-macro "\n"))
  (setq position (point))
  (goto-char (point-min))
  (insert guard-begin)
  (goto-char (point-max))
  (insert guard-end)
  (goto-char (+ position (length guard-begin))))
(global-set-key (kbd "<C-f6>")  'my-insert-include-guard)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Alt+-Note selested words(if selected) or current line(if unselected)
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and we are not at the end of the line,
then comment current line.
Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'qiang-comment-dwim-line)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; from internet
;; (defun smooth-scroll (increment)
;;   (scroll-up increment) (sit-for 0.01)
;;   (scroll-up increment) (sit-for 0.01)
;;   (scroll-up increment) (sit-for 0.01)
;;   (scroll-up increment) (sit-for 0.01)
;;   (scroll-up increment))
;; (global-set-key [(mouse-5)] '(lambda () (interactive) (smooth-scroll 1)))
;; (global-set-key [(mouse-4)] '(lambda () (interactive) (smooth-scroll -1)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-elisp-functions)
