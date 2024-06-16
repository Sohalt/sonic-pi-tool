{
  inputs = {
    utils.url = "github:numtide/flake-utils";
    naersk.url = "github:nix-community/naersk/master";
  };
  outputs = {
    self,
    nixpkgs,
    utils,
    naersk,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        naersk-lib = pkgs.callPackage naersk {};
      in {
        packages.default = pkgs.callPackage ./package.nix {inherit (naersk-lib) buildPackage;};
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            pipewire.jack
          ];
        };
      }
    );
}
