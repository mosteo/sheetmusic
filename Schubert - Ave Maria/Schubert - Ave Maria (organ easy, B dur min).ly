\version "2.18.2"

\include "merge-rests-morley.ily"

#(set-default-paper-size "a4")
#(set-global-staff-size 17.82)
% See http://lilypond.org/doc/v2.19/Documentation/notation/setting-the-staff-size
% feta11		11.22	3.9	pocket scores
% feta13		12.60	4.4	
% feta14		14.14	5.0	
% feta16		15.87	5.6	
% feta18		17.82	6.3	song books
% feta20		20	7.0	standard parts
% feta23		22.45	7.9	
% feta26		25.2	8.9

\header {
  title = "Flores del alma"
  subtitle = "Lorem ipsum"
  subsubtitle = "Sit amet"
  composer = "Música: Juan Larenza"
  arranger = "Arreglo: Lalo Schifrin"
  meter = "Transcripción: A. Mosteo"
  dedication = "Para Marta"
  poet = "Letra: Lito Bayardo"
  tagline = "✣ @dreamgraver v1.0 Feb 2017 ✣"
}

global = {
  \time 4/4
  \key c \major
  \compressFullBarRests
  \set PianoStaff.connectArpeggios = ##t
  \set Score.markFormatter = #format-mark-box-letters
}


%%%%%%%%%%%%%%%%%%%%%%% MUSIC %%%%%%%%%%%%%%%%%%%%%%%%%%%

vocalMarta = \relative c'' {
  c
}

vocalAlex = \relative c' {
  c
}

letra = \lyricmode { }

%%%%%%%%%%%%%%%%%%%%%%% SCORE %%%%%%%%%%%%%%%%%%%%%%%%%%%
\score
{     
  <<        
    % \set Score.tempoHideNote = ##t
    % VOICES
    \new Staff = "Voz" 
      \with { instrumentName = #"Canto" } 
    {     
      \tempo 8 = 180
      <<
        \new Voice = "Marta" 
        \with { midiInstrument = #"voice oohs" }
        {
          \global      
          \voiceOne 
          \vocalMarta
        }      
        \new Voice = "Alex" {
          \set Staff.midiInstrument = #"voice oohs"
          \global      
          \voiceTwo \vocalAlex
        }
      >>
    }    
    \new Lyrics \lyricsto "Marta" {
      \letra
    }
    \new Lyrics \lyricsto "Alex" {
      \letra
    }
    
    \new PianoStaff <<        
      \set PianoStaff.instrumentName = #"Piano"
      % UPPER HAND
      \new Staff = "rh" {                 
        \set Staff.midiInstrument = #"acoustic grand"
        \global        
        \clef "treble"
      }      
      % LOWER HAND
      \new Staff = "lh" { 
        \set Staff.midiInstrument = #"acoustic grand"
        \global
        \clef "bass"
      }
    >>
  >>
  
  \midi {}
  
  \layout {
    % Hide empty staves as needed
    \context { \RemoveEmptyStaffContext }
    
    %{
    \context {
      \Score
      \override SpacingSpanner
                #'common-shortest-duration = #(ly:make-moment 1 8)
    }
    %} % TYPICAL, MORE COMMON NOTE, FOR BASE SPACING. THE LARGER THE WHITER
    % See also \newSpacingSection
    
    % Even first one, if desired
    %\context { \Score \override VerticalAxisGroup #'remove-first = ##t }
  }
}
 
\paper {
  % Nicer fonts
  #(define fonts
    (make-pango-font-tree "Baskerville"
                          "Nimbus Sans"
                          "Luxi Mono"
                          (/ staff-height pt 20))) % Font scaling
  
  %evenHeaderMarkup=\markup  \fill-line { \fromproperty #'page:page-number-string \htitle \hcomposer }
  %oddHeaderMarkup= \markup  \fill-line { \on-the-fly #not-first-page \hcomposer \on-the-fly #not-first-page \htitle \on-the-fly #not-first-page \fromproperty #'page:page-number-string }
  
  %ragged-last-bottom = ##f
  
  %system-system-spacing = 
    %#'((basic-distance . 20) (minimum-distance . 0) (padding . 5))
  %top-system-spacing = 
    %#'((basic-distance . 8) (minimum-distance . 0) (padding . 0))
  %last-bottom-spacing = 
    %#'((basic-distance . 12) (minimum-distance . 0) (padding . 0))
  
  %left-margin  = 12\mm
  %right-margin = 12\mm
  %system-separator-markup = \slashSeparator
  %annotate-spacing = ##t % Show all vertical spacings

  % Space from headers to 1st system
  % markup-system-spacing #'minimum-distance = 25\mm
}