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
  title       = \markup \override #'(font-name . "Baskerville") \abs-fontsize #18 \smallCaps "Levaysme amor d'aquesta terra"
  composer    = \markup \override #'(font-name . "Baskerville") \abs-fontsize #12 "Luis Milán (c. 1500 -- c. 1561)"
  subsubtitle = \markup \override #'(font-name . "Baskerville") "Del libro de Vihuela de mano, 1535"
  tagline     = \markup \override #'(font-name . "Baskerville") \tiny "✣ A. Mosteo ~ 2ª ed. abril 2017 ✣"
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
  <cis e>2 | <cis fis>4 q <d gis>2 | <e a> <e b'> | <e a> <fis a> | 
  <d fis>4 <cis fis> <d gis>2 | <cis e a>
  
  % 2nd verse
  r4 <a d fis> | <a cis e>2 <a d fis>4 q | <b d b'>2 <eis gis b>4 <cis eis gis> | <a cis fis>2 <d fis> |
  << { gis4 fis~ fis eis } \\ { d4 \showStaffSwitch \change Staff="lh" \voiceOne b gis2 } >> <cis fis>2. r4 |
  
  % 3rd
  << { a'1~ a2 a4 g fis2. fis4 } \\ 
     { e2 d4 cis d2 e~ e2 d4 cis } >> 
  <b e>2^~ e |
  
  % 4th
  << { a2 gis4 fis gis fis eis e } \\ 
     { cis2 b b cis } >>
  <e g>4 <d fis>2 <cis fis>4 <b e>2 <cis e> |
  
  % 5th
  r2 <cis e> <cis fis>4 q <d fis>2 | <e a> <e b'> <e a> <fis a> | <d fis>4 <cis fis> <d gis>2 | <cis e a>
  
  % 6th
  r4 <cis fis> |
  << { gis'2 fis   | fis e     | e d     | d4 fis~ fis eis | fis2. } \\
     { cis2 d4 cis | b2 cis4 b | a2 b4 a | b2 cis          | cis2.  } >> r4  
  
}

lh = \relative c' {
  \partial 2
  % 1st
  a2 <fis a>4 q b2 | <a cis> <gis b> <a cis> <d, d'> | <b fis'>4 <fis' a> <b, b'>2 a
  
  % 2nd
  r4 d a2 d gis, cis fis, b | 
  << { s1 a'2. } \\ 
     { b,4 d cis2 fis2. } >> r4
  
  % 3rd & 4th
  << { cis'2 b4 a b2 cis~ | cis b4 a~ | a gis a2| fis gis4 a | eis fis gis a | ais b2 a4~ | a gis a2 } \\
     { a1        |a2 a    | d,1       |  e2 cis | fis d      | d cis       | d1         | e2 a, } >>  
  
  % 5th
  r2 a' <fis a>4 q b2 <a cis>2 <gis b> <a cis> <d, d'> <b fis'>4 <fis' a> <b, b'>2 a2
  
  % 5th
  r4 <fis' a> | 
  << { gis2 a | fis gis | e fis | gis4 fis gis2 | a2.  } \\ 
     { eis2 fis4 e dis2 e4 d cis2 d 4cis b d cis2 | fis,2. } >> r4
}

dynamics = {
  r2\p R1*10
  r1\p R1*7
  r2 r2\p R1*4
  r2. r4\f R1*3
  r2. r4\rit r4\!
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
  <<    
    \new Staff \with { midiInstrument = #"voice oohs" }
    <<
      \new Voice { \global \voice }
      \addlyrics { \text }
    >>    
    \new PianoStaff 
    \with {
      fontSize = -2
      \override StaffSymbol.staff-space = #(magstep -2)
      \override StaffSymbol.thickness   = #(magstep -2)
    }
    <<      
      \new Voice { \global \clef G    \rh }
      \new Dynamics { \dynamics }
      \new Staff = "lh" <<
        \new Voice { \global \clef bass \lh }
      >>
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
