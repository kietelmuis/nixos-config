{ pkgs }:
pkgs.mkShell {
  buildInputs = [
    pkgs.libX11
    pkgs.libICE
    pkgs.libSM
    pkgs.libXext
    pkgs.libXrender
    pkgs.libXcursor
    pkgs.libXfixes
    pkgs.libXi
    pkgs.libXrandr
  ];
  shellHook = ''
    export LD_LIBRARY_PATH="${
      pkgs.lib.makeLibraryPath [
        pkgs.libX11
        pkgs.libICE
        pkgs.libSM
        pkgs.libXext
        pkgs.libXrender
        pkgs.libXcursor
        pkgs.libXfixes
        pkgs.libXi
        pkgs.libXrandr
      ]
    }:$LD_LIBRARY_PATH"
    exec zsh
  '';
}
