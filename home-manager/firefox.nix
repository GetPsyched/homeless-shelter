{ inputs, pkgs, ... }:
let
  system = "x86_64-linux";
  ff-addons = inputs.ff-addons.packages.${system};
  nksss-gh-url = "https://github.com/NIT-KKR-Student-Support-System";
  dpy-docs-url = "https://discordpy.readthedocs.io/en/latest";
in {
  programs.firefox = {
    enable = true;

    # profiles = {
    #   personal = {
    #     bookmarks = [
    #       {
    #         name = "profiles";
    #         bookmarks = [
    #           { name = "GitHub"; url = "https://github.com/GetPsyched"; }
    #           { name = "LeetCode"; url = "https://leetcode.com/GetPsyched"; }
    #           { name = "LinkedIn"; url = "https://www.linkedin.com/in/priyanshutr"; }
    #         ];
    #       }
    #       {
    #         name = "nksss";
    #         bookmarks = [
    #           { name = "gh-main"; url = ${nksss-gh-url}; }
    #           { name = "gh-atlas"; url = ${nksss-gh-url}/atlas; }
    #           { name = "gh-breadboard"; url = ${nksss-gh-url}/breadboard; }
    #           { name = "gh-project-hyperlink"; url = ${nksss-gh-url}/project-hyperlink; }
    #           { name = "gh-website"; url = ${nksss-gh-url}/website; }
    #           {}
    #           { name = "nkss-drive"; url = "https://drive.google.com/drive/folders/1U2taK5kEhOiUJi70ZkU2aBWY83uVuMmD"; }
    #           { name = "railway"; url = "https://railway.app/project/69531a0b-78b7-4a71-9df4-3a8db9703b69"; }
    #           { name = "design"; url = "https://www.figma.com/file/RbT3UiwKwbN71GwU8Zz5HS/NKSSS?node-id=321%3A154"; }
    #         ];
    #       }
    #       {
    #         name = "discord.py";
    #         bookmarks = [
    #           { name = "main"; url = "${dpy-docs-url}/api.html"; }
    #           { name = "interactions"; url = "${dpy-docs-url}/interactions/api.html"; }
    #           { name = "ext/commands"; url = "${dpy-docs-url}/ext/commands/api.html"; }
    #           { name = "ext/tasks"; url = "${dpy-docs-url}/ext/tasks/index.html"; }
    #           {}
    #           { name = "repo"; url = "https://github.com/Rapptz/discord.py"; }
    #           { name = "bot"; url = "https://github.com/Rapptz/RoboDanny"; }
    #         ];
    #       }
    #       {
    #         name = "image-utils";
    #         bookmarks = [
    #           { name = "color-picker"; url = "https://imagecolorpicker.com"; }
    #           { name = "free-svgs"; url = "https://www.svgrepo.com"; }
    #           { name = "palette"; url = "https://www.hexcolortool.com"; }
    #         ];
    #       }
    #     ];
    #   }
    # };
  };
}
