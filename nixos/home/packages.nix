{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    (writeShellScriptBin "hypr-autostart" ''
		AUTOSTART_SCRIPT="$HOME/.config/hypr-autostart"
		
		if [ -x "$AUTOSTART_SCRIPT" ]; then
		    echo "Running user autostart: $AUTOSTART_SCRIPT"
		    sh "$AUTOSTART_SCRIPT"
		else
		    echo "#!/bin/sh" > "$AUTOSTART_SCRIPT"
		    echo "# Add your autostart commands here" >> "$AUTOSTART_SCRIPT"
		    chmod +x "$AUTOSTART_SCRIPT"
		    echo "Created empty autostart file at: $AUTOSTART_SCRIPT"
		fi
    '')
    (writeShellScriptBin "spaste" ''
       ${curl}/bin/curl -X POST --data-binary @- https://p.seanbehan.ca
    '')
    (writeShellScriptBin "codew" ''
      ${vscode}/bin/code --ozone-platform-hint=auto $*
    '')
    (writeShellScriptBin "almighty-push" ''
      ${git}/bin/git add .
      ${git}/bin/git commit -m "$2"
      ${git}/bin/git push -u origin $1 $3
    '')
    (writeShellScriptBin "batp" ''
      POWER_PATH="/sys/class/power_supply"

      for device in "$POWER_PATH"/*; do
        name=$(basename "$device")
        
        # Check if capacity and status files exist
        if [ -f "$device/capacity" ] && [ -f "$device/status" ]; then
          capacity=$(cat "$device/capacity")
          status=$(cat "$device/status")
          echo "$name: $capacity% ($status)"
        fi
      done
    '')
    (writeShellScriptBin "dl" ''
      url=$1
      ddirname=""

      if [[ $url == *.iso ]];
      then
        ddirname="Archives/iso"
      elif [[ $url == *.tar.* ]]; then
        ddirname="Archives/tar"
      elif [[ $url == *.rar ]]; then
        ddirname="Archives/rar"
      elif [[ $url == *.zip ]]; then
        ddirname="Archives/zip"
      else
        ddirname="Misc"
      fi

      maindir=~/Downloads

      if [[ $2 ]];
      then
        maindir=$2
      fi

      echo Downloading $url at $ddirname

      ${curl}/bin/curl -L -O --output-dir $maindir/$ddirname --retry 999 --retry-max-time 0 -C - $url

    '')
    (writeShellScriptBin "srch" ''
      exclude_folders=""
      verbose=false

      while getopts ":i:v" opt; do
          case $opt in
              i)
                  exclude_folders="$OPTARG"
                  ;;
              v)
                  verbose=true
                  ;;
              \?)
                  echo "Invalid option: -$OPTARG"
                  exit 1
                  ;;
          esac
      done
      shift $((OPTIND - 1))

      if [ $# -ne 3 ]; then
          echo "Usage: $0 [-i <exclude_folders>] [-v] <name|content> <search_string> <folder_path>"
          exit 1
      fi

      mode="$1"
      search_string="$2"
      folder_path="$3"

      if [ "$mode" = "name" ]; then
          if [ "$verbose" = true ]; then
            echo "Verbose is on"
              find "$folder_path" -type f \( ! -path "*/$exclude_folders/*" \) -name "$search_string"
          else
              find "$folder_path" -type f \( ! -path "*/$exclude_folders/*" \) -name "$search_string" -print0 | xargs -0 echo
          fi
      elif [ "$mode" = "content" ]; then
          if [ "$verbose" = true ]; then
            echo "Verbose is on"
              grep -rl "$search_string" "$folder_path" $(printf -- '--exclude-dir=%s ' $(echo "$exclude_folders" | tr ',' ' '))
          else
              grep -rl "$search_string" "$folder_path" $(printf -- '--exclude-dir=%s ' $(echo "$exclude_folders" | tr ',' ' ')) | xargs -I {} echo "Results: {}"
          fi
      else
          echo "Invalid mode. Use 'name' or 'content'."
      fi

    '')
    (writeShellScriptBin "repeat-0" ''
      if [ $# -eq 0 ]; then
        echo "Usage: $0 <command>"
        exit 1
      fi

      # Command to run
      COMMAND="$@"

      # Infinite loop
      while :
      do
        # Run the command
        $COMMAND
        
        # Check the exit status
        if [ $? -eq 0 ]; then
          # If the exit status is 0 (success), break out of the loop
          echo "Command succeeded. Exiting loop."
          break
        else
          # If the exit status is non-zero (failure), print a message and continue the loop
          echo "Command failed. Retrying..."
        fi

        # Add a delay before retrying (adjust as needed)
        sleep 1
      done

    '')
    (writeShellScriptBin "nvimdiff" ''
      nvim -d $@
    '')
    (writeShellScriptBin "dirmap" ''
      
      generate_dirmap() {
          local dir="$1"
          local indent="$2"
          local basename=$(basename "$dir")
          
          echo "$\{indent}$\{basename}/"
          
          if [[ "$dir" =~ (node_modules|\.git) ]]; then
              return
          fi
          
          for file in "$dir"/*; do
              if [[ -d "$file" ]]; then
                  if [[ ! "$file" =~ (\.git|node_modules) ]]; then
                      generate_dirmap "$file" "$\{indent}    "
                  fi
              elif [[ -f "$file" ]]; then
                  echo "$\{indent}    $(basename "$file")"
              fi
          done
      }

      create_structure() {
          local line
          local current_indent=0
          local current_dir="$PWD"
          local parent_dirs=()
          
          while IFS= read -r line; do
              if [[ -z "$\{line// }" ]]; then
                  continue
              fi
              
              # Calculate indentation level
              indent_count=$(echo "$line" | awk -F'[^ ]' '{print length($1)}')
              name=$(echo "$line" | sed 's/^[ ]*//')
              
              # Remove trailing slash if present
              is_dir=0
              if [[ "$name" == */ ]]; then
                  is_dir=1
                  name=$\{name%/}
              fi
              
              # Handle indentation changes
              while [[ $\{#parent_dirs[@]} -gt 0 && $indent_count -le $current_indent ]]; do
                  current_dir="$\{parent_dirs[-1]}"
                  unset 'parent_dirs[-1]'
                  ((current_indent-=4))
              done
              
              if [[ $is_dir -eq 1 ]]; then
                  mkdir -p "$current_dir/$name"
                  parent_dirs+=("$current_dir")
                  current_dir="$current_dir/$name"
                  current_indent=$indent_count
              else
                  touch "$current_dir/$name"
              fi
          done
      }

      write_dirmap() {
          local dir="$1"
          local map="$2"
          echo "$map" > "$dir/.dirmap"
      }

      find_dirmap() {
          local dir="$1"
          local execute="$2"
          
          if [[ -f "$dir/.dirmap" ]]; then
              if [[ "$execute" == "true" ]]; then
                  create_structure < "$dir/.dirmap"
              else
                  cat "$dir/.dirmap"
              fi
          fi
      }

      recursive_write() {
          local path="$1"
          
          if [[ "$path" == */ ]]; then
              mkdir -p "$\{path%/}"
          else
              mkdir -p "$(dirname "$path")"
              touch "$path"
          fi
      }

      # Main logic
      if [[ "$1" == "update" ]]; then
          dirmap_content=$(find_dirmap "$PWD")
          first_line=$(echo "$dirmap_content" | head -n1 | cut -d'/' -f1)
          write_dirmap "$PWD" "$(generate_dirmap "$PWD/$first_line")"
      elif [[ $# -gt 0 ]]; then
          for path in "$@"; do
              resolved_path=$(realpath "$path")
              dirmap_content=$(find_dirmap "$PWD")
              first_line=$(echo "$dirmap_content" | head -n1 | cut -d'/' -f1)
              
              if [[ -e "$resolved_path" ]]; then
                  write_dirmap "$PWD" "$(generate_dirmap "$PWD/$first_line")"
                  continue
              fi
              
              recursive_write "$resolved_path"
              write_dirmap "$PWD" "$(generate_dirmap "$PWD/$first_line")"
          done
      else
          find_dirmap "$PWD" "true"
      fi
    '')
    (pass.withExtensions (subpkgs: with subpkgs; [
      pass-audit
      pass-otp
      pass-genphrase
    ]))
    aerc
    bat
    clang-tools
    pkg-config
    ctags
    efm-langserver
    eza
    inter
    grim
    jdt-language-server
    nodejs
    nodePackages.bash-language-server
    nodePackages.svelte-language-server
    nodePackages.typescript-language-server
    nodePackages.prettier
    pylint
    pyright
    python3
    rcm
    ripgrep
    slurp
    vscode-langservers-extracted
    weechat
    gsettings-desktop-schemas
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}
