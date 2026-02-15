{
  description = "Evan's Emacs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    emacs-lsp-booster.url = "github:slotThe/emacs-lsp-booster-flake";
    emacs-lsp-booster.inputs.nixpkgs.follows = "nixpkgs";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = {
    self,
      nixpkgs,
      emacs-lsp-booster,
      emacs-overlay,
      ...
  }@inputs:
    let
      supportedSystems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
    in {
      packages = nixpkgs.lib.genAttrs supportedSystems (system: let
        pkgs = import nixpkgs { inherit system; };
      in rec {
        default = evans-emacs;
        evans-emacs = pkgs.callPackage ./package.nix {};
      });
    };
}
