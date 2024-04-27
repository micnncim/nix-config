{ config, lib, pkgs, ... }:

{
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        indent_style = "space";
        indent_size = 2;
        max_line_length = 80;
        trim_trailing_whitespace = true;
        insert_final_newline = true;
      };
      "*.cue" = {
        indent_style = "tab";
        indent_size = 4;
      };
      "*.go" = {
        indent_style = "tab";
        indent_size = 4;
      };
      "*.md" = {
        trim_trailing_whitespace = false;
      };
      "*.py" = {
        indent_size = 4;
        max_line_length = 79;
      };
      "*.swift" = {
        indent_size = 4;
      };
      "*.rs" = {
        indent_size = 4;
      };
      "go.mod" = {
        indent_style = "tab";
        indent_size = 4;
      };
      "{Dockerfile,*.dockerfile}" = {
        indent_style = "tab";
        indent_size = 4;
      };
      "{Makefile,*.mk}" = {
        indent_style = "tab";
        indent_size = 4;
      };
    };
  };
}
