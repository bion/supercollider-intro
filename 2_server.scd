// the server
Server.default;
Server;
s == Server.default;
s == Server.local;
s.makeWindow;

n = Server.new("my special server"); // probably never necessary

s.queryAllNodes;
s.sampleRate;
s.actualSampleRate;
s.nextNodeID;
