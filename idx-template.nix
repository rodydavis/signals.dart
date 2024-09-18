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
        ${
            if example == "animations_example" then "cp -r ${./examples/animations_example}/* \"$out\""
            else if example == "auth_flow" then "cp -r ${./examples/auth_flow}/* \"$out\""
            else if example == "clean_architecture" then "cp -r ${./examples/clean_architecture}/* \"$out\""
            else if example == "crud_dio" then "cp -r ${./examples/crud_dio}/* \"$out\""
            else if example == "dart_examples" then "cp -r ${./examples/dart_examples}/* \"$out\""
            else if example == "dart_mappable_example" then "cp -r ${./examples/dart_mappable_example}/* \"$out\""
            else if example == "drift_example" then "cp -r ${./examples/drift_example}/* \"$out\""
            else if example == "eval_calculator" then "cp -r ${./examples/eval_calculator}/* \"$out\""
            else if example == "flutter_async" then "cp -r ${./examples/flutter_async}/* \"$out\""
            else if example == "flutter_colorband" then "cp -r ${./examples/flutter_colorband}/* \"$out\""
            else if example == "flutter_counter" then "cp -r ${./examples/flutter_counter}/* \"$out\""
            else if example == "get_it_signals" then "cp -r ${./examples/get_it_signals}/* \"$out\""
            else if example == "html_canvas" then "cp -r ${./examples/html_canvas}/* \"$out\""
            else if example == "html_todo" then "cp -r ${./examples/html_todo}/* \"$out\""
            else if example == "infinite_scroll" then "cp -r ${./examples/infinite_scroll}/* \"$out\""
            else if example == "node_based_editor" then "cp -r ${./examples/node_based_editor}/* \"$out\""
            else if example == "persist_shared_preferences" then "cp -r ${./examples/persist_shared_preferences}/* \"$out\""
            else if example == "rxdart" then "cp -r ${./examples/rxdart}/* \"$out\""
            else if example == "shopping_cart" then "cp -r ${./examples/shopping_cart}/* \"$out\""
            else if example == "flutter_counter" then "cp -r ${./examples/flutter_counter}/* \"$out\""
            else "cp -r ${./examples/flutter_counter}/* \"$out\""
        }
        cp ${./dev.nix} "$out"/.idx/dev.nix
        install --mode u+rw ${./dev.nix} "$out"/.idx/dev.nix
    '';
}