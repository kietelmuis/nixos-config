{ pkgs }:
pkgs.mkShell {
  buildInputs = [
    pkgs.protobuf
    pkgs.cmake
    pkgs.boost
    pkgs.openssl
    pkgs.libusb1
    pkgs.rtaudio
    pkgs.qt5.qtbase
    pkgs.qt5.qtmultimedia
    pkgs.qt5.qtconnectivity
    pkgs.qt5.qtwayland
    pkgs.gst_all_1.gstreamer
    pkgs.gst_all_1.gst-plugins-base
    pkgs.gst_all_1.gst-plugins-good
  ];
  shellHook = ''
    export QT_QPA_PLATFORM=wayland
    export GST_PLUGIN_SYSTEM_PATH_1_0="${pkgs.gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-good}/lib/gstreamer-1.0"
    exec zsh
  '';
}
