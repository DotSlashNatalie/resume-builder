{
  description = "Resume Builder";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let

      oldpkgs = import
        (builtins.fetchTarball {
          url = "https://github.com/NixOS/nixpkgs/archive/b459c8475c58f7c8d529ebeadcbebbfe00ddf6eb.tar.gz";
          sha256 = "sha256:1cx10xzavcqn42w6amfslf6szmmja5by4rbiqdxamz5vy95p986w";
        })
        { inherit system; };

      pkgs = import nixpkgs { inherit system; };

      resume-dev = pkgs.stdenv.mkDerivation {
        system = "x86-64";
        name = "Resume Builder";
        version = "1.0.0";
        buildInputs = [ pkgs.gnumake oldpkgs.pandoc pkgs.texlive.combined.scheme-context ];
        src = ./.;
        unpackPhase = "true";
        buildPhase = ''
          cp -rHT $src .
          make pdf
        '';
        installPhase = ''
          mkdir -p $out
          cp resume.pdf $out/resume.pdf
        '';
      };
    in
    {
      packages.default = resume-dev;
    }
  );
}
