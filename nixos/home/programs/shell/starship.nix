{ config, pkgs, lib, ... }:

{
    # , 󰌽, 
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
   	    "[](#a3aed2)"
   	    "[ ](bg:#a3aed2 fg:#090c0c)"
   	    "[](bg:#769ff0 fg:#a3aed2)"
   	    "$directory"
   	    "[](fg:#769ff0 bg:#394260)"
   	    "$git_branch"
   	    "$git_status"
   	    "[](fg:#394260 bg:#212736)"
   	    "$nodejs"
   	    "$rust"
   	    "$golang"
   	    "$php"
   	    "[](fg:#212736 bg:#1d2230)"
   	    "$time"
   	    "[ ](fg:#1d2230)"
   	    "\n$character"
   	  ];
   	  character = {
   	    success_symbol = "[➜](bold fg:#cba6f7)";
   	    error_symbol = "[➜](bold fg:#f38ba8)";
   	  };
   	  directory = {
   	  	style = "fg:#e3e5e5 bg:#769ff0";
   	  	format = "[ $path ]($style)";
   	  	truncation_length = 3;
   	  	truncation_symbol = "…/";
   	  	substitutions = {
   	  		"Documents" = "󰈙 ";
   	  		"Downloads" = " ";
   	  		"Music" = "󰎇";
   	  		"Pictures" = " ";
   	  		"workspace" = "󰆧";
   	  		"data" = "";
   	  		"Archives" = "";
   	  		"Junk" = "";
   	  	};
   	  };
   	  c = {
   	  	symbol = " ";
   	  	style = "bg:color_blue";
   	  	format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
	  };
   	  git_branch = {
   	  	symbol = "";
   	  	style = "bg:#394260";
   	  	format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
   	  };
   	  git_status = {
   	  	style = "bg:#394260";
   	  	format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
   	  };
   	  nodejs = {
   	  	symbol = "";
   	  	style = "bg:#212736";
   	  	format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
   	  };
   	  rust = {
   	  	symbol = "";
   	  	style = "bg:#212736";
   	  	format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
   	  };
   	  golang = {
   	  	symbol = "";
   	  	style = "bg:#212736";
   	  	format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
   	  };
   	  php = {
   	  	symbol = "";
   	  	style = "bg:#212736";
   	  	format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
   	  };
   	  time = {
   	  	disabled = false;
   	  	time_format = "%R"; # Hour:Minute Format
   	  	style = "bg:#1d2230";
   	  	format = "[[ 󰥔 $time ](fg:#a0a9cb bg:#1d2230)]($style)";
   	  };
    };
  };
}