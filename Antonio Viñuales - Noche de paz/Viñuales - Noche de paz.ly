\version "2.18.2"

\include "../definitions.ily"

#(ly:set-option 'midi-extension "mid")
#(set-default-paper-size "a4")
#(set-global-staff-size 20)
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
  title       = \markup \override #'(font-name . "Baskerville") \abs-fontsize #18 \smallCaps "Noche de paz"
  composer    = \markup \override #'(font-name . "Baskerville") \abs-fontsize #12 "Franz Xaver Gruber (1787-1863)"
  arranger = \markup \override #'(font-name . "Baskerville") "Arreglo de Antonio Viñuales (1955-2017)"
  poet = \markup \override #'(font-name . "Baskerville") "Letra: Joseph Mohr y Federico Fliedner (traducción)"
  tagline     = \markup \override #'(font-name . "Baskerville") \tiny "✣ Coral Oscense 2017 ✣"
  maintainer = \markup \override #'(font-name . "Baskerville") \tiny "Alejandro R. Mosteo"
}

global = {
  \time 3/4
  \key c \major
  %\tempo "Moderato"
}

sopran = \relative c'' {  
  \autoBeamOff
  a2 a4 a b2 cis e cis a b4 a b2 cis % Levaysme...
  r4 a cis2 a4 a b2 gis a fis gis4 fis gis2 fis2. r4 | % que non ...
  
  cis'2 b4 a b2 cis cis b4 a~ a gis a2 | % Levaysme al isla
  cis2 b4 a b2 cis4 cis~ cis b b a a gis a2 |  % levaysme con vos .. vida
  
  r2 a a4 a b2 cis e cis a b4 a b2 cis2 % Quel corpo
  r4 a cis2 a4 a b2 gis a fis gis4 fis gis2 fis2. r4 % que non fare
  \bar"|." 
}

text = \lyricmode {
  Le -- vays -- me a -- mor d'a -- ques -- ta ter -- _ _ ra
  que non fa -- re mai vi -- da en e -- _ _ lla.
  
  Le -- vays -- me~a -- mor al is -- la per -- di -- da, 
  le -- vays -- me con __ _ vos pos soys min -- ya vi -- da.
  
  Quel cor -- po sin al -- ma non vi -- ve~en la ter -- ra
  que non fa -- re mai vi -- da en e -- _ _ lla.
}

\score {
    \new ChoirStaff <<
      \new Staff \with {
        midiInstrument = "choir aahs"
        instrumentName = \markup \center-column { S A }
      } <<
        \new Voice = "sopran" { \voiceOne \sopran }
        %\addlyrics { \text }
        \new Voice = "alto" { \voiceTwo \sopran }
      >>
      \new Staff \with {
        midiInstrument = "voice oohs"
        instrumentName = \markup \center-column { T B }
      } <<
        \new Voice = "tenor" { \voiceOne \sopran }
        \new Voice = "bass" { \voiceTwo \sopran }
      >>    
  >>
  
  \midi { 
    \tempo 4 = 140
  }
  
  \layout {
      \context { \Score \override LyricText #'font-name = "Baskerville" }
      %\context { \Score \override TextScript #'font-size = #5 }
  }
}

\paper {
  % Nicer fonts
  % This would be ideal but breaks things when the chosen font doesn't support e.g. italics
  % So I override manually where necessary
  % Let's hope 2.19 arrives soon and gets rid of these things
  % #(define fonts
  %  (make-pango-font-tree "Baskerville"
  %                        "Nimbus Sans"
  %                        "Luxi Mono"
  %                        (/ staff-height pt 20))) % Font scaling
  
  ragged-last-bottom = ##t
  
  last-bottom-spacing = 
    #'((basic-distance . 10)
       (minimum-distance . 10)
       (padding . 1))
    
  %system-count = 5
  
  top-margin   = 1\cm
  left-margin  = 2.9\cm
  right-margin = 2.9\cm
}
