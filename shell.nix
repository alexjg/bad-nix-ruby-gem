{ pkgs ? import <nixpkgs> {}}:
let 
  gems = pkgs.bundlerEnv rec {
    name = "my-package";
    gemdir = ./.;
  };
in 
  pkgs.mkShell {
    nativeBuildInputs = [ 
      gems
      gems.ruby
    ];
}
