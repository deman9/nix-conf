{
  description = "Deman nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
	formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;      
	nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
	modules = [
	./configuration.nix
	home-manager.nixosModules.home-manager
	{
	    home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.deman = import ./home.nix;
	}
	];
	};
  };
}
