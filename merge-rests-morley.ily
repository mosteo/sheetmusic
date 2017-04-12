%
%  Based on http://lsr.dsi.unimi.it/LSR/Snippet?id=336
%  
%  Merges rests and multi-measure rests that occur on the same moment inside a
%  staff with two voices.
%  
%  Usage:
%  
%  \include "merge-rests"
%  
%  \layout {
%    \mergeRests
%  }
%  
%  or inside the music:
%  
%  \new Staff <<
%    \relative c' {
%      \mergeRestsOn	%% in one of the voices is sufficient
%      c4 d e f g r r2
%    }
%    \\
%    \relative c' {
%      a4 b c d e r r2
%    }
%  >>

#(define (rest-score r)
  (let ((score 0)
	(yoff (ly:grob-property-data r 'Y-offset))
	(sp (ly:grob-property-data r 'staff-position)))
    (if (number? yoff)
	(set! score (+ score 2))
	(if (eq? yoff 'calculation-in-progress)
	    (set! score (- score 3))))
    (and (number? sp)
	 (<= 0 2 sp)
	 (set! score (+ score 2))
	 (set! score (- score (abs (- 1 sp)))))
    score))

#(define (merge-rests-on-positioning grob)
  (let* ((can-merge #f)
	 (elts (ly:grob-object grob 'elements))
	 (num-elts (and (ly:grob-array? elts)
			(ly:grob-array-length elts)))
	 (two-voice? (= num-elts 2)))
    (if two-voice?
	(let* ((v1-grob (ly:grob-array-ref elts 0))
	       (v2-grob (ly:grob-array-ref elts 1))
	       (v1-rest (ly:grob-object v1-grob 'rest))
	       (v2-rest (ly:grob-object v2-grob 'rest)))
	  (and
	   (ly:grob? v1-rest)
	   (ly:grob? v2-rest)
	   (let* ((v1-duration-log (ly:grob-property v1-rest 'duration-log))
		  (v2-duration-log (ly:grob-property v2-rest 'duration-log))
		  (v1-dot (ly:grob-object v1-rest 'dot))
		  (v2-dot (ly:grob-object v2-rest 'dot))
		  (v1-dot-count (and (ly:grob? v1-dot)
				     (ly:grob-property v1-dot 'dot-count -1)))
		  (v2-dot-count (and (ly:grob? v2-dot)
				     (ly:grob-property v2-dot 'dot-count -1))))
	     (set! can-merge
		   (and
		    (number? v1-duration-log)
		    (number? v2-duration-log)
		    (= v1-duration-log v2-duration-log)
		    (eq? v1-dot-count v2-dot-count)))
	     (if can-merge
		 ;; keep the rest that looks best:
		 (let* ((keep-v1? (>= (rest-score v1-rest)
				      (rest-score v2-rest)))
			(rest-to-keep (if keep-v1? v1-rest v2-rest))
			(dot-to-kill (if keep-v1? v2-dot v1-dot)))
		   ;; uncomment if you're curious of which rest was chosen:
		   ;;(ly:grob-set-property! v1-rest 'color green)
		   ;;(ly:grob-set-property! v2-rest 'color blue)
		   (ly:grob-suicide! (if keep-v1? v2-rest v1-rest))
		   (if (ly:grob? dot-to-kill)
		       (ly:grob-suicide! dot-to-kill))
		   (ly:grob-set-property! rest-to-keep 'direction 0)
		   (ly:rest::y-offset-callback rest-to-keep)))))))
    (if can-merge
	#t
	(ly:rest-collision::calc-positioning-done grob))))

#(define merge-multi-measure-rest-on-Y-offset
  ;; Call this to get the 'Y-offset of a MultiMeasureRest.
  ;; It keeps track of other MultiMeasureRests in the same NonMusicalPaperColumn
  ;; and StaffSymbol. If two are found, make transparent one and return 1 for Y-offset of
  ;; the other one.
  (let ((table (make-weak-key-hash-table)))
    (lambda (grob)
      (let* ((ssymb (ly:grob-object grob 'staff-symbol))
             (nmcol (ly:grob-parent grob X))
             (ssymb-hash (begin
               (if (not (hash-ref table ssymb))
                   (hash-set! table ssymb (make-hash-table 1)))
               (hash-ref table ssymb)))
             (othergrob (hash-ref ssymb-hash nmcol))
             (measure-count (if (ly:grob? grob) 
             	 	(ly:grob-property grob 'measure-count)
             	 	0)))

            (if (ly:grob? othergrob)
              (begin 
                ;; Make merged rest transparent instead of suiciding
                ;; in case it supports text/counter
                    
                (set! (ly:grob-property othergrob 'transparent) #t)
                (hash-remove! ssymb-hash nmcol)
                (if (<= (string->number (cadr (string-split (lilypond-version) #\.))) 14)
                    0
                    (if (< 1 measure-count)
                        0
                        1))
                )
              (begin
                ;; Just save this grob and return the default value
                (hash-set! ssymb-hash nmcol grob)
                (ly:staff-symbol-referencer::callback grob)))
                ))))

mergeRestsOn = {
  \override Staff.RestCollision #'positioning-done = #merge-rests-on-positioning
  \override Staff.MultiMeasureRest #'Y-offset = #merge-multi-measure-rest-on-Y-offset
}

mergeRestsOff = {
  \revert Staff.RestCollision #'positioning-done
  \revert Staff.MultiMeasureRest #'Y-offset
}

mergeRests = \with {
  \override RestCollision #'positioning-done = #merge-rests-on-positioning
  \override MultiMeasureRest #'Y-offset = #merge-multi-measure-rest-on-Y-offset
}

mmrtr =  \override Voice.MultiMeasureRestNumber #'transparent = ##t
