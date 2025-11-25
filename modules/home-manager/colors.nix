let
  arcBlueberry = {
    background = "#111422";
    foreground = "#BCC1DC";

    normal = {
      black = "#070914";
      blue = "#8EB0E6";
      cyan = "#22ECDB";
      green = "#3CEC85";
      greenAlt = "#64F188";
      magenta = "#F38CEC";
      orange = "#FF955C";
      pink = "#F38CEC";
      purple = "#B78AFF";
      red = "#E35535";
      salmon = "#FF738A";
      turquoize = "#22ECDB";
      white = "#BCC1DC";
      yellow = "#EACD61";
    };

    bright = {
      black = "#1C243A";
      red = "#FF6F4E";
      green = "#59F29F";
      yellow = "#FFE38A";
      blue = "#A7C8FF";
      magenta = "#FF9CF1";
      cyan = "#64FFF2";
      white = "#F7F8FF";
    };
  };

  # Monokai Pro (Filter Ristretto) palette
  monokaiProRistretto = {
    background = "#2D2A2E";
    foreground = "#FCFCFA";
    normal = {
      black = "#2D2A2E";
      red = "#FF6188";
      green = "#A9DC76";
      yellow = "#FFD866";
      blue = "#78DCE8";
      magenta = "#AB9DF2";
      cyan = "#78DCE8";
      white = "#FCFCFA";
    };
    # Bright approximations based on Monokai Pro accents
    bright = {
      black = "#403E41";
      red = "#FF6584";
      green = "#B4E07A";
      yellow = "#FFE073";
      blue = "#8AE1EC";
      magenta = "#B5A3F3";
      cyan = "#8AE1EC";
      white = "#FFFFFF";
    };
  };
in
arcBlueberry // {
  arcBlueberry = arcBlueberry;
  beardedThemeArcBlueberry = arcBlueberry;
  monokaiProRistretto = monokaiProRistretto;
}
