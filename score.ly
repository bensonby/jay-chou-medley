\version "2.18.2"
#(set-global-staff-size 15)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  http://lsr.di.unimi.it/LSR/Item?id=445

%LSR by Jay Anderson.
%modyfied by Simon Albrecht on March 2014.
%=> http://lilypond.1069038.n5.nabble.com/LSR-445-error-td160662.html

#(define (octave-up m t)
 (let* ((octave (1- t))
      (new-note (ly:music-deep-copy m))
      (new-pitch (ly:make-pitch
        octave
        (ly:pitch-notename (ly:music-property m 'pitch))
        (ly:pitch-alteration (ly:music-property m 'pitch)))))
  (set! (ly:music-property new-note 'pitch) new-pitch)
  new-note))

#(define (octavize-chord elements t)
 (cond ((null? elements) elements)
     ((eq? (ly:music-property (car elements) 'name) 'NoteEvent)
       (cons (car elements)
             (cons (octave-up (car elements) t)
                   (octavize-chord (cdr elements) t))))
     (else (cons (car elements) (octavize-chord (cdr elements ) t)))))

#(define (octavize music t)
 (if (eq? (ly:music-property music 'name) 'EventChord)
       (ly:music-set-property! music 'elements (octavize-chord
(ly:music-property music 'elements) t)))
 music)

makeOctaves = #(define-music-function (parser location arg mus) (integer? ly:music?)
 (music-map (lambda (x) (octavize x arg)) (event-chord-wrap! mus)))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\header {
  title = "Jay Chou Medley"
  subtitle = "For female voice and piano accompaniment"
  arranger = "Arranged by Benson"
}

upper-intro = \relative c'' {
  R1
  r2 e8\( g c e
  e4. f8 d2\)
  % d4\( g8 b, c2\)
  R1
  <g,, e'>4 q8 <a f'>~ q e' c d16 e~ e4
  % <g, e'>8 <a f'>~ q e' c d16 d %~ d2 r2
  r4 r2
  \makeOctaves 1 { e4 d e f d c d e }

  % a,8 c g' c,
  % f,8 g16 a g'8 c,
  % c, g' g' c,
  % c, g'' b,, g''

  % R1
}

lower-intro = \relative c {
  <c g'>8 c' c c
  q b b b
  q c c c
  q d d d
  <a, e'> c' c c
  q b b b
  q c c c
  q d d d
  <f,, c'> c'' c c
  q b b b
  q c c c
  q d d d
  % a,8 c g' c,
  % f,8 g16 a g'8 c,
  % c, g' g' c,
  % c, g'' b,, g''
  % <g, d'> c' c c
  <g,, d'> c' c c
  q b b b
  q c c c
  <gis, e'> d'' d d
  % <a, e'> c' c c
  % <f,, c'> a' a a
  % a,8 c g' c,
  % f,8 g16 a g'8 c,
  % c, g' g' c,
  % c, g'' b,, g''
}

upper-episode-one = \relative c''' {
  d16 e, g d' c d, e c' b d, e b' c d, e c'
  d e, g d' c e, g c b d, e b' c d, e c'
  e fis, a e' d fis, a d c fis, a c d fis, a d
  \tempo 4= 73
  e f, aes e'
  \tempo 4 = 69
  d f, aes d
  \tempo 4 = 63
  <c f> f, aes <c f>
  \tempo 4 = 56
  <c e> f, g e'

  \tempo 4 = 66
  d16 e, g d' c d, e c' b d, e b' c d, e c'
  d e, g d' c e, g c b d, e b' c d, e c'
  % e fis, a e' d fis, a d c fis, a c d fis, a d
  % e f, aes e' d f, aes d <c f> f, aes <c f> <c e> f, g e'
  e fis, a e' d fis, g d' b e, g b c d, e c'
  e f, aes e' d f, aes d <c f> f, aes <c f> <c e> f, g e'
}

lower-episode-one = \relative c' {
  << {
    c8 g' c, f~ f e4.
    c8 g' c, f~ f e4.
  } \\ {
    c,1 a
  } >>
  fis8 d' a' d, fis, d' a' d,
  f, c' aes' c, g aes' g, g'
  << {
    r8 g16 a c8 e d d16 e d8 c
    r8 g16 a c8 g' e16 e32 e e16 g e d c8
    r4 r8 b16 a g8 d' c e,16 f~ f4~ f16 aes g' f e4 d
  } \\ {
    <c, g'>1
    <a e'>
    % <fis d'>
    % <f c'>
    <fis d'>2 e
    <d a'>2 g'
  } >>
  % a,16 e' a b c4
  % e,,16 b' d e g4
}

upper-episode-two = \relative c'' {
  << {
    r8 g\( c d
    \tempo 4 = 63 e
    \tempo 4 = 60 g
    \tempo 4 = 56 a
    \tempo 4 = 50 b
    \tempo 4 = 74 cis4.\)
  } \\ {
    e,,4 d a' g
    e'4.\( dis16 cis e4. e16 fis
    gis4. fis16 e gis4~\) gis16
    eis\( fis gis
    a4. b16 gis a4 \tuplet 3/2 { b8 cis e }
    \makeOctaves -1 { d8 a' gis e d a' gis fis
    fis2 eis\) }
  } >>
}

lower-episode-two = \relative c {
  c1 bes f2. fis4 g2 ees f f d1
}
lower-episode-two = \transpose bes a { \lower-episode-two }

lower-one = \relative c {
  a2 f c c4 b a'2 f c c
  a2 b c1 a2 b c1
  a2 b c d4 e f2 <f aes> <g c d>2 <g b d>
  c1 b2. gis4 a1 <g e'> f2 <f d' g> e2 a d <d aes' c f> <g, c d> g
  c1 b a <g c> f e2 a d1 <g, c f>2 <g aes' c f>4 <g d' f>
  c1 a f2 <g c> c1 e2 gis a g f d g g
  c1 c a a f e d <g c d>
}

lower-two = \relative c {
  a2 e f g a e f g4 gis
  a2 g f e a g f e
  d1 a d g
  c2 b a g f e d g
  c2 b a <g b e> f e d g
  c2 b a <g b e> f e d g
}

lower-three = \relative c {
  \key g \major
  g2 a b a g b e d
  c <c d fis a> b e a, a d d
  g fis e d c b a d
  e b c b a d g, g c, d
  g f e4. ees8~ ees2 d d g <g f'>
  c,2 <c d fis a> b e a b e d
  c <c d fis a> b e a, d r4 r r r
  c2 c b e a, d g, <g f'>
  c2 c b e a, d g, <g f'>
  c2 c b e a, d g,4
}

lower-ending = \relative c {
  r4 r2
  \key aes \major
  des2 <des ees g bes> c f
  bes, ees aes <aes ges'>
  des, des c f bes, ees aes,1
}

melody-one = \relative c'' {
  r8 g g c, c4 d8 e
  r8 g g c, c8 d16 e d8 g,
  r8 g' g c, c4 d8 e
  r8 e8 r e8 f16 e d f e8 c

  e8 d c g' e d c c c r r4 r2
  e8 d c g' e d c c c r r4 r2
  e8 d c g' e d c a'16 a~ a8 g16 g~ g8 a16 g~ g f e8~ e8
  
  e8 f e f e~ e d c g'~ g2 r2

  % chorus
  r8 g, c b c d e c d g4 g8
  r8 d c b c c c b c d e f~ f e4.

  r8 e g b a b b a a b b a a a a g
  r8 g g e g g g e g g g e e d c d
  r4 a8 b c c c c d d e e

  r8 g, e' f g f e g
  r8 g, e'  f g f e c d d d e~ e c4.
  r8 g' g c, c b c c
  r8 g' g c, c b c c
  r8 f f e e d d c
  r8 f f e e d d c

  e8 d f e r c g' b c b g c,
  r8 c a' a r a g g r g f e d e f e~ e4 r4
  e8 fis gis e r fis gis b d b

  r8 c a g a g~ g f f e f g a a~ a g r
  c,8 c' b c c~ c g g g g4 f8 f~ f e r
  c8 c' b c c~ c g g g g4 d'8 d~ d c r
  c,8 c' b c b~ b a r c, b' a b a~ a g r
  c,8 a' g a g~ g f f e f g a a~( a g) r
  f8 e4 g,8 d'
  % TODO
  
}
melody-two = \relative c' {
  r8 a16 b b b b g r8 g16 g g g8 c16
  r8 c16 c c c c r b b b c d c b8
  r8 a16 b b b b g r8 g16 g g g8 c16
  r8 c16 c c d c e e8 d16 c e8 c 

  a16 b' b b b a a r
  b16 b b b b c a r
  a16 a a g g e32( d) e16 r
  g16 g g e e d32( c) d16 r
  a16 b' b b b a a r
  b16 b b b b c a r
  a16 a a g g e32( d) e16 g~( g8. e16 f8 e32 d c16)
  c8 b16 c

  a16 c a c~ c8 a16 c~ c8 d16 c
  r4 a16 c a c~ c8 a16 c~ c8 e16 c
  r4 e8 e e a g e16 e~ e d8. r4 r8 r16

  g,16 e' e e d d8 c c16 d e8 d r16
  g,16 e' e e d d8 c c16 a d8 c r16
  e16 e f e d c8 c16 a c a e'8 g,
  g8 g16 a d8 c c16 c c c c d d8 r16

  g,16 d'8 e16 e~ e8 d16 e~ e8 g16 a~ a g8.
  c,8 d e a g e16 g~ g4 r8
  g16 a c4 a8 g e g16 e~ e r
  c16 d e8 c16 a~ a e'8. d8 r16

  g16 f8 e16 e~ e8 r16 g f8 e16 e~ e8 r16
  d16 e8 g16 c~ c8. c16 b8 a16 a~ a g r
  g16 c,8 d16 e~ e8. g16 e8 c16 d~ d c r
  c16 b8 c16 f~ f e e d d r c f f e e d d r c c

}
melody-three = \relative c' {
  \key g \major
  b4 b8 b b c d d~ d g4. r4
  g,8 a b b b b b e fis a~ a g4. r2
  e4 e8 e e fis g a~ a d,4. r4
  g8 a b b b a a g b a~ a2 r2

  b,4 b8 a b4 r b8 d b a b4 r
  g4 g8 a b d b4 a4 a8 g a4 r
  b4. d8 e d4 r8 e d d b d4 r
  b4 a8 b d4 b8 a a( g4.) r2

  r2 r4
  g8 a c8 b16 b~ b4 r4 b16 c d8 c b g a'~( a g4) r8
  c,8 b16 g'~ g8 r b,8 a16 g'~ g8 fis16 g~ g4 r r8

  d8 d a' a8. g16~ g16 r b8 b a fis e e8. d16~ d8 r r
  d8 d g g c, r g' fis fis g a a8. b16~ b8 r r

  b,8 d a' g c, c b16 b~ b a8.
  fis'8 g a a a fis16 a~ a g8.
  e8 fis g fis16 g~ g8 r16 fis e8 fis g r
  % r4 \transpose c des \relative c' { d'
  r4 \tempo 4 = 68 d' d b
  a16 b e,8 g16 a d b a8 r r16
  d16 d b a b d,8 a'16 b d a g8 r16

  g16 g fis e g~ g8 r16 g g fis e g~ g8 r16
  g16 g fis g a c8 b16 b~ b a g b

  % b8 a g b b4. c8 a4. r8
  % a4 d8 fis, g4. r8
  % b8 c d g, g4 a8 b16 b~ b4 r
  % b,8 d g b~
  % b8 r b16 a g b~ b8 r
  % a16 g fis a~ a g fis a~ a d d a~ a g8. r4
  e8 d b16( a) g8 b4. c8 a4. r8
  e'8 d4 fis,8 g4. r8
  b8 c d g, g4 a8 b16 b~ b8 r



  \tuplet 3/2 4 { g8 a b c b c } d8 g,
  b16 b b b~ b b b b~ b c b a r
  fis16 g d'~ d d d d~ d d d a~ a b a g r
  d16 e g d' c c b b a a g b( a) r d,16
  % b'8 a16 a~ a8 g16 } r
  b'8 a16 a~ a8 g16 r
}

melody-ending = \relative c' {
  c16. c32~ c16 ees ees16. ees32~ ees16 aes
  aes16. aes32~ aes16 bes
  \key aes \major
  c8 c16 c~ c8 bes16 bes~ bes8 r
  g8 aes bes g16 ees~ ees8 bes'16 bes~ bes aes8. r4
  c8 des ees aes, aes4 bes8 c16 c~ c4 r
  c,8 ees aes c c4. des8 bes4. r8
  bes4 ees8 g, aes4 r
  c8 des ees aes, aes4 bes aes r r2
}

lower-three = \transpose aes g { \lower-three }
lower-ending = \transpose aes g { \lower-ending }
melody-three = \transpose aes g { \melody-three }
melody-ending = \transpose aes g { \melody-ending }

drum-bass = \drummode { bd4. bd8 bd2 }
drum-snare = \drummode { hh8 hh sn hh hh hh sn hh }

upper-midi = \relative c' {
  \set Staff.pedalSustainStyle = #'bracket
  \key c \major
  \clef treble
  \tempo 4 = 76
  \time 4/4
  \upper-intro
  \melody-one
  \upper-episode-one
  \melody-two
  \upper-episode-two
  \melody-three
  \melody-ending
  \bar "|."
}

upper-print = \relative c' {
  \set Staff.pedalSustainStyle = #'bracket
  \key c \major
  \clef treble
  \tempo 4 = 76
  \time 4/4
  \upper-intro
  \melody-one
  \upper-episode-one
  \melody-two
  \upper-episode-two
  \melody-three
  \melody-ending
  \bar "|."
}

lower-midi = \relative c {
  \set Staff.pedalSustainStyle = #'bracket
  \key c \major
  \clef bass
  \time 4/4
  \lower-intro
  \lower-one
  \lower-episode-one
  \lower-two
  \lower-episode-two
  \lower-three
  \lower-ending
  \bar "|."
}

lower-print = \relative c {
  \set Staff.pedalSustainStyle = #'bracket
  \key c \major
  \clef bass
  \time 4/4
  \lower-intro
  \lower-one
  \lower-episode-one
  \lower-two
  \lower-episode-two
  \lower-three
  \lower-ending
  \bar "|."
}

dynamics = {
}

guitarchords = \chordmode {
}

\score {
  <<
    % \new ChordNames {
      % \guitarchords
    % }
    \new PianoStaff <<
      \set Staff.midiInstrument = #"acoustic grand"
      \set Staff.instrumentName = #"Piano"
      \new Staff = "right" {
        \set Staff.midiMinimumVolume = #0.5
        \set Staff.midiMaximumVolume = #0.6
        \upper-midi
      }
      \new Staff = "left" {
        \set Staff.midiMinimumVolume = #0.5
        \set Staff.midiMaximumVolume = #0.6
        \lower-midi
      }
    >>
    \new DrumStaff <<
      \new DrumVoice { \repeat unfold 138 \drum-bass }
      \new DrumVoice { \repeat unfold 138 \drum-snare }
    >>
  >>
  \midi {
    \context {
      \ChordNameVoice \remove Note_performer
    }
  }
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      % \guitarchords
    }
    \new PianoStaff <<
      \set PianoStaff.connectArpeggios = ##t
      \set Staff.midiInstrument = #"acoustic grand"
      \set Staff.instrumentName = #"Piano"
      \new Staff = "right" { \upper-print }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" { \lower-print }
    >>
  >>
  \layout {
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      \Staff \RemoveEmptyStaves
    }
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      \Dynamics \RemoveEmptyStaves
    }
    \context {
      \Score
      % Remove all-rest staves also in the first system
      \override VerticalAxisGroup.remove-first = ##t
      % If only one non-empty staff in a system exists, still print the starting bar
      \override SystemStartBar.collapse-height = #1
    }
    \context {
      \ChordNames
      \override ChordName #'font-size = #-3
    }
  }
}
