{
  programs.nixvim.autoCmd = [
    # Vertically center document when entering insert mode
    {
      event = "InsertEnter";
      command = "norm zz";
    }

    # Open help in a vertical split
    {
      event = "FileType";
      pattern = "help";
      command = "wincmd L";
    }

    # Markdown overrides
    {
      event = "FileType";
      pattern = [ "markdown" ];
      command = "setlocal spell spelllang=en wrap linebreak ts=2 sw=2 sts=2";
    }

  ];
}

