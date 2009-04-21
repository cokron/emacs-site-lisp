;; from http://railsexpress.de/downloads/textmate-links.el
;; see http://railsexpress.de/blog/articles/2009/01/23/how-to-open-textmate-links-in-emacs-on-os-x

;;----------------------------------------------------------------------------
;; support for opening textmate urls on OS X
;;----------------------------------------------------------------------------

(defconst textmate-url-regexp
  "^txmt://open\\?url=file://\\(/.*?\\)\\(&line=\\([0-9]+\\)\\)?\\(&column=\\([0-9]+\\)\\)?$")

(defun textmate-url-p (s)
  "Check whether given string is a textmate url."
  (string-match textmate-url-regexp s)
)

(defun textmate-url-open (url)
  "Open a textmate url, which must point to an existing file."
  (if (textmate-url-p url)
    (let* ((file (match-string-no-properties 1 url))
           (line (match-string-no-properties 3 url))
           (col  (match-string-no-properties 5 url)))
      (condition-case err
          (progn
            (find-file-existing file)
            (and line (goto-line (string-to-number line)))
            (and col (move-to-column (max 0 (- (string-to-number col) 1))))
            nil)
        (error (error-message-string err))))))

;; redefine function contained in mac-win.el
(defun mac-ae-get-url (event)
  "Open the URL specified by the Apple event EVENT.
Currently the `mailto' and `txmt' schemes are supported."
  (interactive "e")
  (let* ((ae (mac-event-ae event))
         (ae-text (mac-ae-text ae))
         (parsed-url (url-generic-parse-url ae-text)))
    (cond ((textmate-url-p ae-text)
           (textmate-url-open ae-text))
          ((string= (url-type parsed-url) "mailto")
           (progn
             (url-mailto parsed-url)
             (select-frame-set-input-focus (selected-frame))))
      ('t (mac-resume-apple-event ae t)))))

(provide 'textmate-links)
