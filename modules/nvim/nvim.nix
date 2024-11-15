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
        ${builtins.readFile ./plugin/cmp.lua}
       ${builtins.readFile ./plugin/telescope.lua}
     ${builtins.readFile ./plugin/lsp.lua}
     ${builtins.readFile ./plugin/treesitter.lua}
      '';
      extraPackages = with pkgs; [
        nixd
        lua-language-server
        wl-clipboard
        fd
      ];
      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
         nvim-cmp
        telescope-nvim
        telescope-fzf-native-nvim
        neodev-nvim
        telescope-ui-select-nvim
        plenary-nvim
        cmp_luasnip
        cmp-nvim-lsp
        cmp-path
        luasnip
        friendly-snippets
       which-key-nvim
        mini-pairs
        mini-surround
        mini-comment
        mini-bracketed

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
        }
      ];
    };
}
