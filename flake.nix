{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      platforms = [ "x86_64-linux" ];
      packages = builtins.listToAttrs
        (
          builtins.map
            (e:
              let
                pkgs = import nixpkgs { system = e; };
              in
              {
                name = e;
                value = {
                  default = pkgs.callPackage ./. { };
                };
              })
            platforms
        );
    in
    {
      inherit packages;
    };
}