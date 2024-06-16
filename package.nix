{
  lib,
  buildPackage,
  makeWrapper,
  sonic-pi,
  pipewire,
}:
buildPackage {
  src = ./.;
  nativeBuildInputs = [makeWrapper];
  postInstall = ''
    wrapProgram $out/bin/sonic-pi-tool --set SONIC_PI_DAEMON_DIR ${sonic-pi}/app/server/ruby/bin --prefix PATH : ${lib.makeBinPath [pipewire.jack]}
  '';
}
