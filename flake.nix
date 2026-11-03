{
  description = "ESP32-E3 AUTH-USB";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
	let
	  system = "x86_64-linux";
	  pkgs = nixpkgs.legacyPackages.${system};
	  fsh = pkgs.buildFHSEnv {
	    name = "fsh-env";
	    targetPkgs = pkgs: with pkgs; [
	      rustup
	      
	      usbutils	
	      udev	

              python3
	    ];
	    profile = ''
		  export ESPUP_HOME="$PWD/.espup"
		  export RUSTUP_HOME="$PWD/.rustup"
		  export CARGO_HOME="$PWD/.cargo"
		  export PATH="$PWD/.cargo/bin:$PATH"
		  source “$PWD/export-esp.sh”
		  echo "Hi there! (Flake develop-env is activated)"
		  echo "FSH is already activated"
	    '';
	  };  
	in {
	  devShells.${system}.default = fsh.env;
	};
}
