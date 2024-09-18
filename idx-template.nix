{pkgs, example ? "flutter_counter", ...}: {
    packages = [
        pkgs.curl
        pkgs.gnutar
        pkgs.xz
        pkgs.git
        pkgs.busybox
    ];
    bootstrap = ''
        mkdir "$out"/.idx
        # cp -r ${./example}/* "$out"
        ${
            if example == "flutter_counter" then "cp -r ${./examples/flutter_counter}/* \"$out\""
            else "cp -r ${./examples/flutter_counter}/* \"$out\""
        }
        cp ${./dev.nix} "$out"/.idx/dev.nix
        install --mode u+rw ${./dev.nix} "$out"/.idx/dev.nix
    '';
}