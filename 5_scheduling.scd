c = TempoClock(120/60); // beats-per-second

SynthDef(\bonk, {
  arg freq;
  var sig, pan, env;

  sig = PinkNoise.ar;
  sig = Resonz.ar(sig, freq * [1, 2, 3.1, 6.4], 0.02).mean * 10;
  env = EnvGen.kr(Env.perc, doneAction: 2);
  pan = Rand(-1, 1);

  Out.ar(0, Pan2.ar(sig * env, pan));
}).send(s);

r = { Synth(\bonk, [\freq, rrand(100, 800)]) };

c.sched(
  c.beats.ceil - c.beats, // next beat
  {
    r.value;
    1; // every beat
  }
);

c.clear;
c.tempo_(360/6);

c.sched(
  c.beats.ceil - c.beats, // next beat
  {
    arg beatsDouble, seconds;
    var beats = beatsDouble.round;

    // polyrhythm, 4/4 over 7/4
    case
    {beats % 4 == 0}
    { Synth(\bonk, [\freq, 5000]) }
    {beats % 4 == 2}
    { Synth(\bonk, [\freq, 4000]) }

    {beats % 7 == 0}
    { Synth(\bonk, [\freq, 600]) }
    {beats % 7 == 2}
    { Synth(\bonk, [\freq, 800]) }
    {beats % 7 == 4}
    { Synth(\bonk, [\freq, 1000]) }; // <= dat semi-colon

    1;
  }
);

// stream-like functions

Routine;

n = [
  622.25396744416,
  391.99543598175,
  523.2511306012,
  466.16376151809
];

r = Routine({
  var count = 0;
  var index;

  index = (count % n.size).round;

  Synth(\bonk, [\freq, n[index]]);
  count = count + 1;
  1.0.yield;

  Synth(\bonk, [\freq, n[index]]);
  count = count + 1;
  1.0.yield;

  Synth(\bonk, [\freq, n[index]]);
  count = count + 1;
  0.25.yield;

  Synth(\bonk, [\freq, n[index]]);
  count = count + 1;
  0.25.yield;

  Synth(\bonk, [\freq, n[index]]);
  count = count + 1;
  0.25.yield;

  Synth(\bonk, [\freq, n[index]]);
  count = count + 1;
  0.25.yield;
});

r.play(c);

r.reset;

r.play(TempoClock(1));
