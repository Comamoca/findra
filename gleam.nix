{
  lib,
  newScope,
  beamPackages,
  buildGleam,
  fetchgit,
}:

let
  inherit (beamPackages) buildMix buildRebar3 fetchHex;
in

lib.makeScope newScope (self: {
  argv = buildGleam {
    name = "argv";
    version = "1.0.2";
    otpApplication = "argv";

    src = fetchHex {
      pkg = "argv";
      version = "1.0.2";
      sha256 = "sha256-uh/wkpUl3roc5nJW5a33enzd/nKePj9Xpb3KoDHe0J0=";
    };
  };

  envoy = buildGleam {
    name = "envoy";
    version = "1.1.0";
    otpApplication = "envoy";

    src = fetchHex {
      pkg = "envoy";
      version = "1.1.0";
      sha256 = "sha256-hQ2p0p0uWYdzWHKitcgQNRRtf+Ge/EhhKeREQNA/2DI=";
    };

    beamDeps = with self; [
      gleam_stdlib
    ];
  };

  filepath = buildGleam {
    name = "filepath";
    version = "1.1.2";
    otpApplication = "filepath";

    src = fetchHex {
      pkg = "filepath";
      version = "1.1.2";
      sha256 = "sha256-sGqa8L8Q5RQB1kuY5LYn8dLkjBVJZ9p69NCRR4Cm1Ao=";
    };

    beamDeps = with self; [
      gleam_stdlib
    ];
  };

  glap = buildGleam {
    name = "glap";
    version = "1.0.19";
    otpApplication = "glap";

    src = fetchHex {
      pkg = "glap";
      version = "1.0.19";
      sha256 = "sha256-I+rv/mWPjdECQ2XfbZD1lqP1aIybqr9sTEjXjpq1tSE=";
    };

    beamDeps = with self; [
      argv
      gleam_stdlib
    ];
  };

  gleam_stdlib = buildGleam {
    name = "gleam_stdlib";
    version = "0.67.1";
    otpApplication = "gleam_stdlib";

    src = fetchHex {
      pkg = "gleam_stdlib";
      version = "0.67.1";
      sha256 = "sha256-bOPkGJqLjsL3OrYaL73knxWdbJxhxJ47MILkOfJg09A=";
    };
  };

  gleeunit = buildGleam {
    name = "gleeunit";
    version = "1.9.0";
    otpApplication = "gleeunit";

    src = fetchHex {
      pkg = "gleeunit";
      version = "1.9.0";
      sha256 = "sha256-2pVTzli2eSSzxjH5b+M3DEnrbW3Gs4TsSGLMSqpxjzw=";
    };

    beamDeps = with self; [
      gleam_stdlib
    ];
  };

  shellout = buildGleam {
    name = "shellout";
    version = "1.7.0";
    otpApplication = "shellout";

    src = fetchHex {
      pkg = "shellout";
      version = "1.7.0";
      sha256 = "sha256-G9wDQ4/rl6avPjlvSr6zK+zyDfJFLsmowKzre933CxQ=";
    };

    beamDeps = with self; [
      gleam_stdlib
    ];
  };

  simplifile = buildGleam {
    name = "simplifile";
    version = "2.3.1";
    otpApplication = "simplifile";

    src = fetchHex {
      pkg = "simplifile";
      version = "2.3.1";
      sha256 = "sha256-lX4OW3WSdlnx0qG3t117m6lvqo0MU+pxxK2c0Ma4SPY=";
    };

    beamDeps = with self; [
      filepath
      gleam_stdlib
    ];
  };

  snag = buildGleam {
    name = "snag";
    version = "1.2.0";
    otpApplication = "snag";

    src = fetchHex {
      pkg = "snag";
      version = "1.2.0";
      sha256 = "sha256-J09B1sPs+Z92hv3OVBgzM+QdLBylo6Zz+aiyx6RAEHc=";
    };

    beamDeps = with self; [
      gleam_stdlib
    ];
  };

  xdgleam = buildGleam {
    name = "xdgleam";
    version = "1.1.1";
    otpApplication = "xdgleam";

    src = fetchHex {
      pkg = "xdgleam";
      version = "1.1.1";
      sha256 = "sha256-lhlsZ4aIwytBKPZqr1ZLvgqFuzlQYDUKOvsk1gyX8vs=";
    };

    beamDeps = with self; [
      envoy
      filepath
      gleam_stdlib
    ];
  };
})
