{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    # Shell wrapper: `y` starts yazi and cd's into the last directory on exit
    shellWrapperName = "y";

    # Plugins from nixpkgs. `setup = true` generates the
    # require("<name>"):setup() call in init.lua.
    plugins = {
      full-border = {
        package = pkgs.yaziPlugins.full-border;
        setup = true;
      };
      git = {
        package = pkgs.yaziPlugins.git;
        setup = true;
      };
      smart-enter.package = pkgs.yaziPlugins.smart-enter;
      chmod.package = pkgs.yaziPlugins.chmod;
    };

    settings = {
      mgr = {
        ratio = [ 1 3 4 ];
        sort_by = "natural";
        sort_dir_first = true;
        show_hidden = true;
        show_symlink = true;
      };

      # Git status markers in the file list (needs the git plugin)
      plugin.prepend_fetchers = [
        { group = "git"; url = "*"; run = "git"; }
        { group = "git"; url = "*/"; run = "git"; }
      ];
    };

    keymap.mgr.prepend_keymap = [
      {
        on = "l";
        run = "plugin smart-enter";
        desc = "Enter directory or open file";
      }
      {
        on = [ "c" "m" ];
        run = "plugin chmod";
        desc = "Chmod selected files";
      }
    ];
  };
}
