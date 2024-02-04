{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      copilot-vim
      nord-nvim
      nvim-treesitter
      nvim-treesitter-textobjects
      vim-markdown
      {
        plugin = hop-nvim;
        type = "lua";
        config = ''
          require("hop").setup { keys = 'uhetonas' } -- Dvorak
          nmap("<Leader>w", ":HopWord<CR>")
          nmap("<Leader>l", ":HopLine<CR>")
          nmap("<Leader>s", ":HopChar1<CR>")
        '';
      }
      {
        plugin = nvim-surround;
        type = "lua";
        config = ''
          require("nvim-surround").setup()
        '';
      }
    ];
    extraConfig = ''
      colorscheme nord

      set number

      nnoremap <Space> <Nop>
      let g:mapleader = "\<Space>"
    '';
    extraLuaConfig = ''
      local function nmap(shortcut, command, opts)
        vim.keymap.set("n", shortcut, command, opts or { noremap = true, silent = true })
      end
    '';
  };
}
