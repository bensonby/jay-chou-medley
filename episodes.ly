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
  title = "Jay Chou Medley - episodes"
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
  r8 g g c, c4 d8 e

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
  <a, e'> c' c c
  <f,, c'> a' a a
  % a,8 c g' c,
  % f,8 g16 a g'8 c,
  % c, g' g' c,
  % c, g'' b,, g''
}

upper-episode-one = \relative c''' {
  d16 e, g d' c d, e c' b d, e b' c d, e c'
  d e, g d' c e, g c b d, e b' c d, e c'
  e fis, a e' d fis, a d c fis, a c d fis, a d
  e f, aes e' d f, aes d <c f> f, aes <c f> <c e> f, g e'

  d16 e, g d' c d, e c' b d, e b' c d, e c'
  d e, g d' c e, g c b d, e b' c d, e c'
  % e fis, a e' d fis, a d c fis, a c d fis, a d
  % e f, aes e' d f, aes d <c f> f, aes <c f> <c e> f, g e'
  e fis, a e' d fis, g d' b e, g b c d, e c'
  e f, aes e' d f, aes d <c f> f, aes <c f> <c e> f, g e'
  r8 a,,16 b b b b g r8 g16 g g g8 c16
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
  a,16 e' a b c4
  e,,16 b' d e g4
}

upper-episode-two = \relative c'' {
  << {
    r8 g\( c d e g a c d4.\)
  } \\ {
    e,,4 d a' g
    f'4.\( e16 d f4. f16 g
    a4. g16 f a4~\) a16
    fis\( g a
    bes4. c16 a bes4 \tuplet 3/2 { c8 d f }
    \makeOctaves -1 { ees8 bes' a f ees bes' a g
    g2 fis\) }
  } >>
  b,,4 b8 b b c d d~ d g4. r2
}

lower-episode-two = \relative c {
  c1 bes f2. fis4 g2 ees f f d1
  g2 a b a
}

upper-midi = \relative c' {
  \set Staff.pedalSustainStyle = #'bracket
  \key c \major
  \clef treble
  \tempo 4 = 72
  \time 4/4
  \upper-intro
  R1
  \upper-episode-one
  R1
  \upper-episode-two
  \bar "|."
}

upper-print = \relative c' {
  \set Staff.pedalSustainStyle = #'bracket
  \key c \major
  \clef treble
  \tempo 4 = 72
  \time 4/4
  \upper-intro
  R1
  \upper-episode-one
  R1
  \upper-episode-two
  \bar "|."
}

lower-midi = \relative c {
  \set Staff.pedalSustainStyle = #'bracket
  \key c \major
  \clef bass
  \time 4/4
  \lower-intro
  R1
  \lower-episode-one
  R1
  \lower-episode-two
  \bar "|."
}

lower-print = \relative c {
  \set Staff.pedalSustainStyle = #'bracket
  \key c \major
  \clef bass
  \time 4/4
  \lower-intro
  R1
  \lower-episode-one
  R1
  \lower-episode-two
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
