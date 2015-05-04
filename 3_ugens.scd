// Ugens
// ar,   kr,      ir
// audo  kommand  info

SinOsc.ar(440); // A4
Saw;
Pulse.ar(width: 0.5); // square wave
Impulse;

LPF;
RLPF;
HPF;
BPF;
MoogFF;
Resonz;
Compander;

LFNoise2;
LFTri;
LFSaw;

// fewest # of chars needed to make a sound?
// probably this:
play{Saw.ar};

// but this sounds better
play{LPF.ar(Saw.ar)};

// envelopes
n = {
  var env = Env([0, 1, 0], [0.1, 0.3], \sin);
  var sin = SinOsc.ar;
  EnvGen.kr(env) * sin;
};

n.play;
