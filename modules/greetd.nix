{
  pkgs,
  ...
}:
{
  services.greetd = {
    enable = true;
    settings = {
      # default_session.user = "deman";
      default_session.command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          # --theme border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red \
          --cmd sway
      '';
    };
  };

  environment.etc."greetd/environments".text = ''
    sway
  '';
}
