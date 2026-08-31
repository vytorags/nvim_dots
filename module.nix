inputs:
{
  wlib,
  config,
  pkgs,
  lib,
  options,
  ...
}:
{
  imports = [ wlib.wrapperModules.neovim ];
  config.settings.config_directory = lib.generators.mkLuaInline "vim.fn.stdpath('config')";
  config.settings.wrapRc = true;
  config.settings.aliases = [ "vim" ];
  config.hosts.python3.nvim-host.enable = true;
  config.hosts.node.nvim-host.enable = true;
  config.info.have_nerd_font = false;
  config.info.is_nix = true;
  config.specs.general = {
    lazy = false;
    data = with pkgs.vimPlugins; [
      lazy-nvim
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      codesnap-nvim
    ];
    runtimePkgs = with pkgs; [
      stdenv.cc.cc
      typescript
      codesnap
      tree-sitter
      vue-language-server
      tslib
      phpstan
      golangci-lint
      delve
      rust-analyzer
      rustfmt
      clang-tools
      cpplint
      gdb
      cmake
      netcoredbg
      gopls
      astro-language-server
      intelephense
      vtsls
      tailwindcss-language-server
      vscode-langservers-extracted
      eslint
      phpactor
      emmet-ls
      lua-language-server
      stylua
      prettier
      pyright
      black
      roslyn-ls
      nixfmt
      bash-language-server
      shfmt
      nixd
      nil
      marksman
      svelte-language-server
      templ
      luau-lsp
    ];
  };
  config.specMods =
    {
      parentSpec ? null,
      parentOpts ? null,
      parentName ? null,
      config,
      ...
    }:
    {
      options.runtimePkgs = options.runtimePkgs // {
        description = "Maps packages in the PATH specific to a spec";
      };
    };
  config.runtimePkgs = config.specCollect (acc: v: acc ++ (v.runtimePkgs or [ ])) [ ];
}
