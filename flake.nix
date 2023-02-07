{
  description = "Home Manager configuration of Rudhi Mediastara";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.rudhi = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ({ pkgs, ...  }:{
            home.username = "rudhi";
            home.homeDirectory = "/home/rudhi";
            home.stateVersion = "22.11";
            
            programs.home-manager.enable = true;
            home.packages = with pkgs; [ 
              nodejs nodePackages.pnpm
              nodePackages.vscode-langservers-extracted
              nodePackages.prettier 
              nodePackages.svelte-language-server 
              nodePackages.typescript-language-server
              nodePackages.wrangler
              netlify-cli
              nil
              rnix-lsp
              gh
              ripgrep
              fd
              fira-code
            ];

           
           
            programs.git = {
              enable = true;
              extraConfig = {
                init = {  defaultBranch = "main";  };
                user = { name = "Rudhi Mediastara"; email = "rudhi.mediastara@gmail.com"; };
              };
            };

           
            

            /*
            programs.zsh = {
              enable = false;
              enableVteIntegration = true;
            };
            */

            
            programs.fish = {
               enable = true;
            };
            

            
            programs.tmux = {
              enable = true;
              extraConfig = "set -g mouse on"; 
              plugins = with pkgs; [
                { plugin = tmuxPlugins.power-theme; extraConfig ="set -g @tmux_power_theme 'snow'";  }
              ];
              
            };
            
            /*
            programs.bat.enable = true;
            */

            
            programs.starship = {
                enable = true;
                enableBashIntegration = true;
                enableZshIntegration = true;
                enableFishIntegration = true;
                settings = {
                  container = {
                   format =  "[$symbol]($style) ";
                  };
                };
            };
            
            
           
            programs.direnv = {
              enable = true;
              enableBashIntegration = true;
              enableZshIntegration = true;
              nix-direnv.enable = true;
            };
            
            
            programs.helix = {
               enable = true;
               settings = {
                 theme = "nord";
                 editor = { 
                   line-number = "relative"; 
                 };
                 editor.cursor-shape = {
                   insert = "bar";
                 }; 
               };
            };
            

            
            programs.neovim = {
              enable = true;
              plugins = with pkgs.vimPlugins; [
                packer-nvim
              ];
              defaultEditor = true;
            };

            fonts.fontconfig.enable = true;
            
          })
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
