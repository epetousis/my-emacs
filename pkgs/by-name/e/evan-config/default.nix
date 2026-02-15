{
  trivialBuild,
  callPackage,

  breadcrumb,
  csv-mode,
  delight,
  dired-preview,
  dired-sidebar,
  dtrt-indent,
  editorconfig,
  ef-themes,
  eglot,
  envrc,
  evil,
  fireplace,
  htmlize,
  magit,
  markdown-mode,
  nix-mode,
  ox-slack,
  rust-mode,
  treesit-grammars,
  vterm,
  web-mode
}:
trivialBuild {
  pname = "evan-config";
  version = "1970-01-01";
  src = ./default.el;
  packageRequires = [
    breadcrumb
    csv-mode
    delight
    dired-preview
    dired-sidebar
    dtrt-indent
    editorconfig
    ef-themes
    eglot
    envrc
    evil
    fireplace
    htmlize
    magit
    markdown-mode
    nix-mode
    ox-slack
    rust-mode
    (callPackage ../../s/simple-html {})
    treesit-grammars.with-all-grammars
    vterm
    web-mode
  ];
}
