# this file contains nix configs and pkgs to be installed !
{ config, pkgs, ... }:

{
  system.Packages = with pkgs; [
    sl
    cmatrix
    wezterm

  ];

}
