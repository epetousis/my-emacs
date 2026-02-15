{ pkgs, lib, ... }:

let
  # Customise the app bundle with a new icon
  emacsPlusWithIcon = pkgs.callPackage ./lib/icon-override.nix {
    # Disable native compilation on Darwin for the time being while Nixpkgs issue 395169 is fixed.
    pkg = pkgs.emacs30-pgtk.override { withNativeCompilation = !pkgs.stdenv.hostPlatform.isDarwin; };
    iconPath = ./res/elrumo2.icns;
  };
  # On Linux, we use the pure GTK build to enable full Wayland support.
  appropriateEmacs = if pkgs.stdenv.hostPlatform.isDarwin then emacsPlusWithIcon else pkgs.emacs30-pgtk;
  # Finally, provide our customised emacs with our preferred packages.
  # (This should come as late as possible in the process.)
in

(pkgs.emacsPackagesFor appropriateEmacs).emacsWithPackages (epkgs: [
  (epkgs.callPackage ./pkgs/by-name/e/evan-config {})
])
