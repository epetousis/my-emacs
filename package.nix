{ pkgs, lib, ... }:

let
  baseEmacs = pkgs.emacs31-pgtk;
  # Customise the app bundle with a new icon
  emacsPlusWithIcon = pkgs.callPackage ./lib/icon-override.nix {
    pkg = baseEmacs;
    iconPath = ./res/elrumo2.icns;
  };
  # On Linux, we use the pure GTK build to enable full Wayland support.
  appropriateEmacs = if pkgs.stdenv.hostPlatform.isDarwin then emacsPlusWithIcon else baseEmacs;
  # Finally, provide our customised emacs with our preferred packages.
  # (This should come as late as possible in the process.)
in

(pkgs.emacsPackagesFor appropriateEmacs).emacsWithPackages (epkgs: [
  (epkgs.callPackage ./pkgs/by-name/e/evan-config {})
])
