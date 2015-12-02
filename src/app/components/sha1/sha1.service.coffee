angular.module 'jkbs'
  .factory 'Sha1', () ->
    'ngInject'

    hash = `function(msg) {
      msg = msg.utf8Encode();

      var K = [0x5a827999, 0x6ed9eba1, 0x8f1bbcdc, 0xca62c1d6];

      msg += String.fromCharCode(0x80);

      var l = msg.length / 4 + 2;
      var N = Math.ceil(l / 16);
      var M = new Array(N);

      for (var i = 0; i < N; i++) {
        M[i] = new Array(16);
        for (var j = 0; j < 16; j++) {
          M[i][j] = (msg.charCodeAt(i * 64 + j * 4) << 24) | (msg.charCodeAt(i * 64 + j * 4 + 1) << 16) |
            (msg.charCodeAt(i * 64 + j * 4 + 2) << 8) | (msg.charCodeAt(i * 64 + j * 4 + 3));
        } // note running off the end of msg is ok 'cos bitwise ops on NaN return 0
      }
      M[N - 1][14] = ((msg.length - 1) * 8) / Math.pow(2, 32);
      M[N - 1][14] = Math.floor(M[N - 1][14]);
      M[N - 1][15] = ((msg.length - 1) * 8) & 0xffffffff;

      var H0 = 0x67452301;
      var H1 = 0xefcdab89;
      var H2 = 0x98badcfe;
      var H3 = 0x10325476;
      var H4 = 0xc3d2e1f0;


      var W = new Array(80);
      var a, b, c, d, e;
      for (var i = 0; i < N; i++) {

        for (var t = 0; t < 16; t++) W[t] = M[i][t];
        for (var t = 16; t < 80; t++) W[t] = this.ROTL(W[t - 3] ^ W[t - 8] ^ W[t - 14] ^ W[t - 16], 1);

        a = H0;
        b = H1;
        c = H2;
        d = H3;
        e = H4;

        for (var t = 0; t < 80; t++) {
          var s = Math.floor(t / 20); // seq for blocks of 'f' functions and 'K' constants
          var T = (this.ROTL(a, 5) + this.f(s, b, c, d) + e + K[s] + W[t]) & 0xffffffff;
          e = d;
          d = c;
          c = this.ROTL(b, 30);
          b = a;
          a = T;
        }

        H0 = (H0 + a) & 0xffffffff;
        H1 = (H1 + b) & 0xffffffff;
        H2 = (H2 + c) & 0xffffffff;
        H3 = (H3 + d) & 0xffffffff;
        H4 = (H4 + e) & 0xffffffff;
      }

      return this.toHexStr(H0) + this.toHexStr(H1) + this.toHexStr(H2) +
        this.toHexStr(H3) + this.toHexStr(H4);
    }`

    f = `function(s, x, y, z) {
      switch (s) {
        case 0:
          return (x & y) ^ (~x & z); // Ch()
        case 1:
          return x ^ y ^ z; // Parity()
        case 2:
          return (x & y) ^ (x & z) ^ (y & z); // Maj()
        case 3:
          return x ^ y ^ z; // Parity()
      }
    }`
    ROTL = `function(x, n) {
      return (x << n) | (x >>> (32 - n));
    }`
    toHexStr = `function (n) {
      var s = "",
        v;
      for (var i = 7; i >= 0; i--) {
        v = (n >>> (i * 4)) & 0xf;
        s += v.toString(16);
      }
      return s;
    }`

    if typeof String.prototype.utf8Encode == 'undefined'
      String.prototype.utf8Encode = ->
        unescape(encodeURIComponent(this))

    if typeof String.prototype.utf8Decode == 'undefined'
      String.prototype.utf8Decode = ->
        try
          return decodeURIComponent(escape(this))
        catch e
          return this # invalid UTF-8? return as-is

    service =
      hash: hash
      f: f
      ROTL: ROTL
      toHexStr: toHexStr
