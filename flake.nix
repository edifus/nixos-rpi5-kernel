{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";

  outputs = { nixpkgs, ... }: {
    legacyPackages.aarch64-linux = with nixpkgs.legacyPackages.aarch64-linux; rec {
      linux_rpi5 = callPackage ./linux-rpi.nix {
        kernelPatches = with kernelPatches; [
          bridge_stp_helper
          request_key_helper
        ];
        rpiVersion = 5;
      };

      linuxPackages_rpi5 = linuxPackagesFor linux_rpi5;
    };
  };
}
