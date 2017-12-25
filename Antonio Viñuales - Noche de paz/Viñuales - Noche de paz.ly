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
  title      = \markup \abs-fontsize #18 \center-column 
                  { \smallCaps "Noche de paz" " " }
  composer   = \markup \right-column { "Franz Xaver Gruber (1787-1863)"  
                                       "Arreglo: Antonio Viñuales (1955-2017)" }
  poet = \markup \left-column { "Letra: Joseph Mohr" 
                                "Traducción: Federico Fliedner" }
  tagline     = \markup \tiny "✣ Coral Oscense 2017 v2 ✣"
  maintainer = \markup \tiny "Alejandro R. Mosteo"
}

global = {
  \time 3/4
  \key c \major
  \autoBeamOff
  %\tempo "Moderato"
}

sopran = \relative c'' {    
    g4. a8 g4 | e2. | g4. a8 g4 | e2. | 
    d'2 d4 | b2. | c2 c4 | g2 r4 | 
    \repeat unfold 2 { a2 a4 | c4. b8 a4 | g4. a8 g4 | e2. }
    d'2 d4 f4. d8 b4 |  c2.( e2.)
    \mark \markup { \musicglyph #"scripts.ufermata" } \bar "||"
    c4. g8 e4 | g4. f8 d4 | c2.~ c 
    \bar ":|."
}

alto = \relative c' {
    \repeat unfold 2 { e4. f8 e4 | c( d c) }
    d4.( e8) f4 | g4.( fis8 f4) | e4.( f8) e4 | e2. | 
    f2 f4 | a4. g8 f4 | e4. f8 e4 | c( b bes) | 
    a4.( c8) f4 | a4. g8 f4 | e4. f8 e4 | c( d c) | 
    d2 d4 | b'4. b8 b4 | a2.( fis) |
    e4. e8 c4 | cis4. d8 b4 | c2.~ | c
}

tenor = \relative c' {
    \repeat unfold 2 { c4. c8 c4 g2. } |
    g2 g4 | g2. | g2 g4 | c2. | 
    c4. d8 c4 | c4. c8 c4 | c4. c8 c4 | g2. | 
    f2 c'4 | c4. d8 dis4 | e4. b8 c4 | g2. | 
    b2 b4 | b4. d8 f4 | e2.( c2.) | 
    g4. g8 g4 | a4. a8 g[ f] | f4.( e8 f4 | e2.)
}

bass = \relative c {
    \repeat unfold 2 { c4. c8 c4 c2. } |
    b4.( c8) b[ a] | g2. | c2 c4 | << c2. { g'2 gis4 }  >> |
    << { f,2 f4 f4. f8 f4 } { a'4. b8 a4 f4. f8 f4 } >>
    c4. c8 c4 c2.
    << { f,2 f4 f4. f8 f4 } { f'2 f4 f4. f8 f4 } >>
    c4. c8 c4 | c( b a) | <g g'>2 q4 | <gis gis'>4. q8 q4
    <a a'>2.( q) |
    c4. c8 c4 | a4. d8 g,4 | c2.~ | c 
}

textI = \lyricmode {
    No -- che de Dios, no -- che de paz,
    cla -- ro sol bri -- lla ya
    y los án -- ge -- les 
    can -- tan -- do~es -- tán.
    Glo -- ria~a Dios, glo -- ria~al Rey E -- ter -- nal.
    Duer -- me~el ni -- ño Je -- sús.
    Duer -- me el ni -- ño Je -- sús.
}

textII = \lyricmode {
    Stil __ _ -- le Nacht, Hei -- li -- ge Nacht,
    Al -- les schläft, ein -- sam wacht
    Nur das trau __ _ -- te hei -- li -- ge Paar.
    Hol -- der Knab' __ _ im loc -- kig -- ten Haar,
    Schla -- fe~in himm -- li -- scher Ruh.
    Schla -- fe in himm -- li -- scher Ruh.
}

textIII = \lyricmode {
    No -- che de paz, no -- che de Dios,
    al por -- tal va~el pas -- tor
    y~en -- tre pa -- jas en -- cuen -- tra~al Se -- ñor,
    es el Ver -- bo que car -- ne to -- mó.    
    Duer -- me~el ni -- ño Je -- sús.
    Duer -- me el ni -- ño Je -- sús.
}

\score {
    \new ChoirStaff <<
      \new Staff \with {
        midiInstrument = "voice oohs"
        instrumentName = \markup \right-column { S A }
      } <<
        \global
        \new Voice = "sopran" { \voiceOne \sopran }        
        \new Voice = "alto" { \voiceTwo \alto }
        \addlyrics { \set stanza = #"1." \textI }
        \addlyrics { \set stanza = #"2." \override LyricText #'font-shape = #'italic 
                                          \textII }
        \addlyrics { \set stanza = #"3." \textIII }
      >>
      \new Staff \with {
        midiInstrument = "voice oohs"
        instrumentName = \markup \right-column { T B }
      } <<
        \global
        \clef bass
        \new Voice = "tenor" { \voiceOne \tenor }
        \new Voice = "bass" { \voiceTwo \bass }
      >>    
  >>
  
  \midi { 
    \tempo 4 = 140
  }
  
  \layout {
      %\context { \Score \override LyricText #'font-name = "Baskerville" }
      %\context { \Score \override LyricText #'font-size = #2 }      
  }
}

\paper {
  % Nicer fonts
  % This would be ideal but breaks things when the chosen font doesn't support e.g. italics
  % So I override manually where necessary
  % Let's hope 2.19 arrives soon and gets rid of these things
  
  % Check available with $ lilypond -dshow-available-fonts x
  % #(define fonts
  %  (make-pango-font-tree "Baskervald ADF Std"
  %                        "Nimbus Sans"
  %                        "Luxi Mono"
  %                        (/ staff-height pt 20))) % Font scaling
  
  %ragged-last-bottom = ##t
  
  last-bottom-spacing = 
    #'((basic-distance . 10)
       (minimum-distance . 10)
       (padding . 1))
    
  markup-system-spacing #'minimum-distance = #20
  system-system-spacing #'minimum-distance = #17
    
  %annotate-spacing = ##t
  %system-count = 5
    
  top-margin   = 1\cm
  left-margin  = 2\cm
  right-margin = 2\cm
}
