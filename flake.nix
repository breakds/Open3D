{
  description = "A modern library for 3D Data Processing";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

    utils.url = "github:numtide/flake-utils";
    utils.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs: inputs.utils.lib.eachSystem [
    "x86_64-linux"
  ] (system:
    let pkgs = import nixpkgs {
          inherit system;
        };
    in {
      devShells.default = pkgs.mkShell rec {
        # Update the name to something that suites your project.
        name = "my-c++-project";

        packages = with pkgs; [
          # Development Tools
          llvmPackages.clang
          cmake
          cmakeCurses
          ninja

          # Dependencies
          xorg.libxcb.dev
          xorg.libXi.dev
          libGLU.dev
          SDL2.dev
          # libosmesa
        ];

        # Setting up the environment variables you need during
        # development.
        shellHook = let
          icon = "f121";
        in ''
          export PS1="$(echo -e '\u${icon}') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
        '';
      };
    });
}
