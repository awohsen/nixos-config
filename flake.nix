{
  description = "Your new cool nixos config!";

  inputs = {
    # Define your preffered nixpkgs branch here
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }: {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        # Replace 'awo' with your hostname here
          awo = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./configuration.nix 
            ];
        };
      };
  };
}
