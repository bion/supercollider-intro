/*
  :-)                          :-)
  :-)                          :-)
  :-)          SCLANG          :-)
  :-)                          :-)
  :-)                          :-)
*/

a = 1;
a + 2;
a = a + 2;

anNumber = 1; // not so much

(
var anNumber = 1;

anNumber;
)

Class;
Array;
Synth;

"string";
\symbol;
'symbol';
1; // integer
2.0; // float
[] == Array.new;
{} == Function.new;
() == Event.new;

Dictionary[
  "foo" -> "bar",
  [1, 2, 3] -> "yeah this too"
];

IdentityDictionary[
  \sym -> "bar"
];

().class;

// functionish

10.do({|num|
  num.postln;
});

[\one, \two, \three].do {|sym, i|
  [sym, i].postln;
};

// not really used, AFAIK

a = 10;
while {a < 1000} {
  { SinOsc.ar(a, 0, 0.3) }.play
  a = a + rrand(50, 200);
};

// snooping
Synth.dumpInterface;
Synth.dumpFullInterface;

"ls".unixCmd; // runs in sh, not bash
