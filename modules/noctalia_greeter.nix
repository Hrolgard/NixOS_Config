{pkgs, inputs, ...}: {

    imports = [
            inputs.noctalia-greeter.nixosModules.default
        ];

    programs.noctalia-greeter = {
        enable = true;
        settings = {
            cursor = {
            theme = "Bibata-Modern-Ice";
            size = 24;
            path = "${pkgs.bibata-cursors}/share/icons";
            };
        };
    };
}

# !-- IMPORTANT --!
# When using this greeter, set services.displayManager.sddm.enable = false; in configuration.nix
# When NOT using this greeter, set services.displayManager.sddm.enable = true; in configuration.nix so you use the plasma greeter instead.
