{pkgs, example ? "flutter_counter", ...}: {
    packages = [
        pkgs.curl
        pkgs.gnutar
        pkgs.xz
        pkgs.git
        pkgs.busybox
    ];
    bootstrap = ''
        mkdir "$out"
        cp -a -rf ${./.}/examples/${example}/. "$WS_NAME"
        chmod -R +w "$WS_NAME"
        mv "$WS_NAME" "$out"
        mkdir "$out"/.idx
        cp ${./dev.nix} "$out"/.idx/dev.nix
        chmod -R u+w "$out"
        install --mode u+rw ${./dev.nix} "$out"/.idx/dev.nix
    '';
}
