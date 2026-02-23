{
  trivialBuild,
  callPackage,
  replaceVars,

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
  fish,
  htmlize,
  hunspell,
  magit,
  markdown-mode,
  nil,
  nix-mode,
  ox-slack,
  rust-mode,
  treesit-grammars,
  vterm,
  vue-language-server,
  web-mode
}:
trivialBuild {
  pname = "evan-config";
  version = "1970-01-01";
  src = replaceVars ./default.el {
    hunspell = hunspell.withDicts (dpkgs: [ dpkgs.en_AU-large ]);
    inherit vue-language-server nil fish;
  };
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
