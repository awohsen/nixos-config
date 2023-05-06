# Do not use this file! Just generate it by ‘nixos-generate-config’
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/e06ce54d-b9e1-4661-8c7d-9706690231a6";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7E7B-D9A5";
      fsType = "vfat";
    };

  fileSystems."/media/ssd" =
    { device = "/dev/disk/by-uuid/965AC5C95AC5A5F9";
      fsType = "ntfs3";
      options = [ "rw" "uid=1000" "gid=1000" "dmask=007" "fmask=117"];
    };

  swapDevices =
    [
       { device = "/dev/disk/by-uuid/d1f91cdf-c9fa-47e4-a205-112de179517d"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
