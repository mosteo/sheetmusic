\version "2.18.2"

%\include "../merge-rests-morley.ily"

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
  title = \markup \abs-fontsize #18 \smallCaps "Levaysme amor d'aquesta terra"
  composer = \markup \abs-fontsize #12 "Luis Milán (c. 1500 -- c. 1561)"
  subsubtitle = "Del libro de Vihuela de mano, 1535"
  tagline = \markup \tiny "✣ A. Mosteo ~ Abril 2017 ✣"
}

global = {
  \time 2/2
  \key a \major
  \tempo "Moderato"
}

voice = \relative c'' {  
  \partial 2 
  \autoBeamOff
  a2 a4 a b2 cis e cis a b4 a b2 cis % Levaysme...
  r4 a cis2 a4 a b2 gis a fis gis4 fis gis2 fis2. r4 | % que non ...
  
  cis'2 b4 a b2 cis cis b4 a~ a gis a2 | % Levaysme al isla
  cis2 b4 a b2 cis4 cis~ cis b b a a gis a2 |  % levaysme con vos .. vida
  
  r2 a a4 a b2 cis e cis a b4 a b2 cis2 % Quel corpo
  r4 a cis2 a4 a b2 gis a fis gis4 fis gis2 fis2. r4 % que non fare
  \bar"|." 
}

rh = \relative c' { 
  \partial 2
  % 1st verse
  <cis e>2\p | <cis fis>4 q <d gis>2 | <e a> <e b'> | <e a> <fis a> | 
  <d fis>4 <cis fis> <d gis>2 | <cis e a>
  
  % 2nd verse
  r4 <a d fis> | <a cis e>2 <a d fis>4 q | <b d b'>2 <eis gis b>4 <cis eis gis> | <a cis fis>2 <d fis> |
  << { gis4 fis~ fis eis } \\ { d4 } >> <cis fis>2. r4 |
  
  % 3rd
  << { a'1~ a2 a4 g fis2. fis4 } \\ 
     { e2\p d4 cis d2 e~ e2 d4 cis } >> 
  <b e>2^~ e |
  
  % 4th
  << { a2 gis4 fis gis fis eis e } \\ 
     { cis2 b b cis } >>
  <e g>4 <d fis>2 <cis fis>4 <b e>2 <cis e> |
  
  % 5th
  r2 <cis e>\p <cis fis>4 q <d fis>2 | <e a> <e b'> <e a> <fis a> | <d fis>4 <cis fis> <d gis>2 | <cis e a>
  
  % 6th
  r4 <cis fis> |
  << { gis'2 fis   | fis e     | e d     | d4 fis~ fis eis  | fis2. } \\
     { cis2 d4 cis | b2 cis4 b | a2 b4 a | b2 cis           | cis2.  } >> r4
  
}

lh = \relative c' {
  \partial 2
  r2 R1*29
}

text = \lyricmode {
  Le -- vays -- me a -- mor d'a -- ques -- ta ter -- _ _ ra
  que non fa -- re mai vi -- da en e -- _ _ lla.
  
  Le -- vays -- me~a -- mor al is -- la per -- di -- da, 
  le -- vays -- me con __ _ vos pos soys min -- ya vi -- da.
  
  Quel cor -- po sin al -- ma non vi -- ve~en la ter -- ra
  que non fa -- re mai vi -- da en e __ _ _ lla.
}

\score {
  <<    
    \new Staff \with { midiInstrument = #"voice oohs" }
    <<
      \new Voice = "voice" { \global \voice }
      \addlyrics { \text }
    >>
    
    \new PianoStaff <<
      \new Voice = "rh" { \global \clef G    \rh }
      \new Voice = "lh" { \global \clef bass \lh }
    >>
  >>
  
  \midi { 
    \tempo 4 = 140
  }
  
  \layout {
      \context { 
        %\Score \override TextScript #'font-size = #5
      }
  }
}

\paper {
  % Nicer fonts
  #(define fonts
    (make-pango-font-tree "Baskerville"
                          "Nimbus Sans"
                          "Luxi Mono"
                          (/ staff-height pt 20))) % Font scaling
  
  top-margin   = 1\cm
  left-margin  = 2\cm
  right-margin = 2\cm
}
