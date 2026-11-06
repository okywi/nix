{
  lib,
  appimageTools,
  fetchurl,
  nix-update-script,
}:

let
  pname = "limusic";
  version = "1.3.0";

  src = fetchurl {
    url = "https://github.com/SimoHypers/limusic/releases/download/v${version}/limusic_${version}_amd64.AppImage";
    hash = "sha256-skhW7OeTMN06Y/WvI5Tm+Dja50rtxh42d0Q96Qwrc4c=";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=limusic-app' 'Exec=${pname}'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  passthru.updateScript = nix-update-script {
    extraArgs = [ "--version-regex=v([\\d.]+)" ];
  };

  meta = with lib; {
    description = "Limusic music player packaged from AppImage";
    homepage = "https://github.com/SimoHypers/limusic";
    downloadPage = "https://github.com/SimoHypers/limusic/releases";
    license = licenses.unfree;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
  };
}
