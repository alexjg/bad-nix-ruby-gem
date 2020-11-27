{ pkgs ? import <nixpkgs> {}}:
let 
  ruby_2_6_6 = pkgs.ruby.overrideAttrs (oldattrs: rec {
    version = "2.6.6";
    src = pkgs.fetchurl {
      url = "https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.6.tar.gz";
      sha256 = "1492x795qzgp3zhpl580kd1sdp50n5hfsmpbfhdsq2rnxwyi8jrn";
    };
  });
  bundler = pkgs.bundler.override { ruby = ruby_2_6_6; };
  gems = pkgs.bundlerEnv rec {
    name = "my-package";
    ruby = ruby_2_6_6;
    gemdir = ./.;
  };
in 
  pkgs.mkShell {
    nativeBuildInputs = [ 
      gems
      gems.ruby
    ];
}
