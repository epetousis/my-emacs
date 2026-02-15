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
      overlay = final: prev: {
        emacs-lsp-booster = final.callPackage ./default.nix { };
        evans-emacs = final.callPackage ./package.nix {};
      };
      supportedSystems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system:
        import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        });
    in {
      overlays.default = overlay;

      packages = forAllSystems (system: rec {
        default = evans-emacs;
        evans-emacs = nixpkgsFor.${system}.evans-emacs;
      });
    };
}
