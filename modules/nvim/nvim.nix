{pkgs,...}:

{
    programs.neovim =   let
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraLuaConfig = ''
        ${builtins.readFile ./options.lua}
      '';
      extraPackages = with pkgs; [
        nixd
        lua-language-server
        wl-clipboard
        fd
      ];
      plugins = with pkgs.vimPlugins; [
        {
          plugin = nvim-lspconfig;
          config = toLuaFile ./plugin/lsp.lua;
        }
        neodev-nvim
        {
          plugin = nvim-cmp;
         config = toLuaFile ./plugin/cmp.lua;
        } 
      {
        plugin = telescope-nvim;
        config = toLuaFile ./plugin/telescope.lua;
      }
        telescope-fzf-native-nvim
        plenary-nvim
        cmp_luasnip
        cmp-nvim-lsp
        luasnip
        friendly-snippets
        which-key-nvim
        mini-align
        mini-jump
        mini-pairs
        mini-surround
        mini-comment
        mini-bracketed
        mini-git
      {
        plugin = mini-icons;
        type = "lua";
        config = "require(\"mini.icons\").setup()";
      }
      {
        plugin = mini-statusline;
        type = "lua";
        config = "require(\"mini.statusline\").setup()";
      }
        vim-nix
  
      {
        plugin = fidget-nvim;
        type = "lua";
        config = "require(\"fidget\").setup()";
      }
       {
          plugin = (nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-python
            p.tree-sitter-json
            p.tree-sitter-go
            p.tree-sitter-toml
            p.tree-sitter-fish
          ]));
          config =toLuaFile ./plugin/treesitter.lua;
        }
      ];
    };
}
