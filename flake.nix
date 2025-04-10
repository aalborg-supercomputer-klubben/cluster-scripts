{
    inputs.nixpkgs.url = "nixpkgs/nixos-24.11";
    outputs = inputs: let 
        system = "x86_64-linux";
        pkgs = import inputs.nixpkgs { inherit system; };
    in {
        packages.${system}.default = pkgs.stdenv.mkDerivation {
            name = "tmux-matrix";
            src = ./.;
            installPhase = ''
                mkdir -p $out/bin
                cp $src/tmux.sh $out/bin/tmux-matrix
                chmod +x $out/bin/tmux-matrix
            '';
        };
    };
}
