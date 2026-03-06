{ pkgs }:
pkgs.mkShell {
  buildInputs = [
    pkgs.protobuf
    pkgs.cmake
    pkgs.boost
    pkgs.openssl
    pkgs.libusb1
    pkgs.libusb1.dev
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
    export LIBUSB_INCLUDE_DIR="${pkgs.libusb1.dev}/include/libusb-1.0"
    export QT5_INCLUDE_DIR="${pkgs.qt5.qtbase.dev}/include"
    export PKG_CONFIG_PATH="${pkgs.protobuf}/lib/pkgconfig:${pkgs.abseil-cpp}/lib/pkgconfig:$PKG_CONFIG_PATH"
    export PROTOBUF_LIB_DIR="${pkgs.protobuf}/lib"
    exec zsh
  '';
}
