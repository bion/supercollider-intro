play{Saw.ar};

play{LPF.ar(Saw.ar)};

SynthDef(\tmp_name, {
  Out.ar(0, LPF.ar(Saw.ar));
}).send(s);

a = Synth(\tmp_name);

a.free;

SynthDef(\takes_args, {
  |freq, bus|

  Out.ar(bus, SinOsc.ar(freq, 0, 0.5));
}).send(s);

a = Synth(\takes_args, [\freq, 440, \bus, 1]);

a.set(\freq, 220);
a.get(\freq, {|val|
  ("freq of 'a' is " ++ val).postln;
});

a.free;



~bellSpec = IdentityDictionary[
  \amps -> [0, -30, -6, -36, -9, -44, -18, -76, -24, -66, -36],
  \freqScales -> [1, 2.1, 3.001, 3.9, 5.0, 5.85, 7.01, 8.1, 8.99, 9.9, 11.02],
  \durScales -> [1, 1, 1, 0.9, 1, 0.8, 0.9, 0.5, 0.7, 0.3, 0.1]
];

SynthDef(\bell, {
  |baseFreq|
  var sig;

  sig = SinOsc.ar(baseFreq * ~bellSpec[\freqScales]) *
    EnvGen.kr(Env.perc(0.01, ~bellSpec[\durScales], ~bellSpec[\amps]));

  sig = sig.mean;

  DetectSilence.ar(sig, -60.dbamp, 0.001, 2);

  Out.ar(0, sig * -32.dbamp);
}).send(s);

Synth(\bell, [\baseFreq, 440])




SynthDef(\mod_pulse, {
  arg outbus, freq, amp = 1;
  var detune, sig, mod, pan;

  mod = [
    LFTri.kr(0.2).range(0.1, 0.9),
    SinOsc.kr(0.6).range(0.1, 0.9),
    LFNoise1.kr(1.2).range(0.1, 0.9)
  ];

  sig = Pulse.ar(freq * [1, 0.999823, 1.0011213], mod).mean;
  pan = SinOsc.kr(1).range(-0.5, 0.5);

  Out.ar(outbus, Pan2.ar(sig * amp, pan));
}).send(s);

SynthDef(\rand_moogvcf_stereo, {
  |inbus, outbus|
  var source, filt, mod;

  source = In.ar(inbus, 2);
  mod = LFNoise2.kr(1).range(300, 3000);
  filt = MoogFF.ar(source, mod, 0.4);

  Out.ar(outbus, filt);
}).send(s);

b = Bus.audio(s, 2);
g = Group.new;

a = Synth(\mod_pulse, [\outbus, b, \freq, 80], g);
c = Synth(\rand_moogvcf_stereo, [\inbus, b, \outbus, 0], g, \addToTail)
a.nodeID;
c.nodeID;
s.queryAllNodes;
