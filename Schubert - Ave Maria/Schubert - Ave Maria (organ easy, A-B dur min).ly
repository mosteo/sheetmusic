\version "2.18.2"

%\include "merge-rests-morley.ily"

#(set-default-paper-size "a4")
#(set-global-staff-size 22.45)
% See http://lilypond.org/doc/v2.19/Documentation/notation/setting-the-staff-size
% feta11		11.22	3.9	pocket scores
% feta13		12.60	4.4	
% feta14		14.14	5.0	
% feta16		15.87	5.6	
% feta18		17.82	6.3	song books
% feta20		20	7.0	standard parts
% feta23		22.45	7.9	
% feta26		25.2	8.9

global = {
  \time 4/4
  \key bes \major
  \compressFullBarRests
  \set PianoStaff.connectArpeggios = ##t
  \set Score.markFormatter = #format-mark-box-letters
}

\header {
    tagline = "✣ @dreamgravings Jun 2017 ✣"
}

arranger="Arranger: A.R. Mosteo upon improvisations of C. Betrán"

%%%%%%%%%%%%%%%%%%%%%%% MUSIC %%%%%%%%%%%%%%%%%%%%%%%%%%%

rhvI=\relative c'' {  
  % Intro
  bes4.^"Sehr langsam" a16 bes d4.. c16 |
  % Singer
  \repeat volta 2 {
    bes4. a16 bes d4.. c16 |
    bes4 r c bes16 a g a |
    bes4 r8 d d8. c32 bes a16 g d' e d4 cis8. r16 c8. bes16 \tuplet 6/4 { a c d es c a }
    bes4. d16 c c8. a16 \tuplet 6/4 { g b d f d b } c4~ \tuplet 6/4 { c16 g a bes a16 g }
    f4 \teeny es \normalsize c'4 c16. b32 c16. d32 c16. d32 bes8 r4 |
    c4 \tuplet 6/4 { c16 b c es d c } bes4 r |
    c4 d4 f8 es r4 |
    d8 c \tuplet 6/4 { bes16 a bes des c bes } c4. r8
  }
  
  bes4. a16 bes d4.. c16 | <d, f bes>1\fermata \bar"|." 
}

rhvII=\relative c' {
  <d f>4 <d e> <f bes> <es a>
  
  <d f>4 <d e> <f bes> <es a>
  <d g>2 <es g>4 <es f>
  <d f>2 <d fis>4 <d \parenthesize g>4
  <e g>2 <d a'>2
  <d g>4 <e g> f4 <d g>
  <a' f'> <e g> 
  <a, c>2
  es'4 es16. d32 es16. f32 es16. f32 d8 d4
  es4 \tuplet 6/4 { es16 d es g f es } d4 d
  <f a>4 <fis a> <g c> <es g>
  <es g>4 e <f a> <es a>
  
  <d f>4 <d e> <f bes> <es a>
}

lh=\relative c {
  <bes bes'>4 <g g'> <f f'> q
  
  <bes bes'>4 <g g'> <f f'> q
  <g g'> q <es es'> <f f'>
  <bes bes'> q q q
  <a a'> q <fis fis'> q
  <g g'> q <a a'> <d, d'>
  <c c'> q <f f'> q q q q q 
  q q <g g'> q
  <f f'> <d d'> <c c'> q
  <es es'> <g g'> <f f'> q
  
  <bes bes'>4 <g g'> <f f'> q | <bes bes'>1\fermata
}

%%%%%%%%%%%%%%%%%%%%%%% SCORE %%%%%%%%%%%%%%%%%%%%%%%%%%%

\bookpart {

\header {
  title = "Ave Maria"
  subtitle="A♭ major"
  composer = "Franz Schubert"
  arranger = \arranger
}

  \score
  {       
    \transpose bes aes {
    <<        
      % \set Score.tempoHideNote = ##t
      \new PianoStaff <<        
        \set PianoStaff.instrumentName = #"Organ"
        % UPPER HAND
        \new Staff = "rh" {                 
          \set Staff.midiInstrument = #"church organ"
          \global        
          \clef "treble"
          <<
            \new Voice { \voiceOne \rhvI  }
            \new Voice { \voiceTwo \rhvII }
          >>
        }      
        % LOWER HAND
        \new Staff = "lh" { 
          \set Staff.midiInstrument = #"church organ"
          \global
          \clef "bass"
          \lh
        }
      >>
    >>
    }
    
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

}

\bookpart {
  
  \header {
  title = "Ave Maria"
  subtitle="B♭ major (original key)"
  composer = "Franz Schubert"
  arranger = \arranger
}

\score
{     
  
  <<        
    % \set Score.tempoHideNote = ##t
    \new PianoStaff <<        
      \set PianoStaff.instrumentName = #"Organ"
      % UPPER HAND
      \new Staff = "rh" {                 
        \set Staff.midiInstrument = #"church organ"
        \global        
        \clef "treble"
        <<
          \new Voice { \voiceOne \rhvI  }
          \new Voice { \voiceTwo \rhvII }
        >>
      }      
      % LOWER HAND
      \new Staff = "lh" { 
        \set Staff.midiInstrument = #"church organ"
        \global
        \clef "bass"
        \lh
      }
    >>
  >>  
  
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
  
  ragged-last-bottom = ##f
  
  %system-system-spacing = 
    %#'((basic-distance . 20) (minimum-distance . 0) (padding . 5))
  %top-system-spacing = 
    %#'((basic-distance . 8) (minimum-distance . 0) (padding . 0))
  last-bottom-spacing = 
    #'((basic-distance . 12) (minimum-distance . 0) (padding . 0))
  
  left-margin  = 15\mm
  right-margin = 15\mm
  %system-separator-markup = \slashSeparator
  %annotate-spacing = ##t % Show all vertical spacings

  % Space from headers to 1st system
  markup-system-spacing #'minimum-distance = 20\mm
}