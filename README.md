# My Home Setup


- fresh install
```sh
nix build .#homeConfigurations.rudhi.activationPackage
```

- switch
```sh
home-manager switch --flake .#rudhi
```