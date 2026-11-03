
# Table of Contents

1.  [Hardware Used](#org6f6153e)
2.  [Separation of functions by stage](#org9da20cc)
3.  [Technologies & Crates](#org97f48d9)
4.  [Start Working](#orgae38318)
    1.  [NixOS only](#orgd5ec929)
    2.  [Initial Setup](#org63d2fd6)

The goal of the project is to create a custom authentication key based on the Esp32-e3 dongle, which works in conjunction with the LilyGo watch to log into accounts without a password (avoiding the need to enter a password or anything that could be intercepted when entered by a computer).


<a id="org6f6153e"></a>

# Hardware Used

-   LILYGO : T-Dongle S3 (ESP32-S3, 0.96 ISP LCD)
-   LILYGO : T-Watch-S3 (ESP32-S3, 1.54 LCD)

<span class="underline">In general, you can use any combination of two ESP32-E3 chips</span>


<a id="org9da20cc"></a>

# Separation of functions by stage

1.  The dongle acts as an authentication key for the PC
2.  A portion of the secret key is transferred to the watch; for auth, the watch sends its part to the dongle.
    Consequently, neither the watch nor the dongle can be compromised individually, as neither possesses the complete key.
3.  A mobile app is being developed that links the watch to the phone. The watch can receive an authentication request,
    forward it to a dongle along with a portion of the key, receive a response, and pass is back to the phone. This allows
    authentication to work not only on a PC but also on a phone.

**Current Stage = 1**


<a id="org97f48d9"></a>

# Technologies & Crates

-   Espressif Rust fork (espup)
-   Flake and FSHEnv (Only for NixOS users)
-   espflash
-   esp<sub>hal</sub>
-   esp<sub>bootloader</sub>
-   critical-section
-   esp-println


<a id="orgae38318"></a>

# Start Working


<a id="orgd5ec929"></a>

## NixOS only

If you don't use NixOS skip that block.

    nix develop


<a id="org63d2fd6"></a>

## Initial Setup

    rustup default stable
    cargo install espup --locked
    espup install
    # If it don't see espup : export PATH="{your-path-to-.cargo/bin}:$PATH"
    source export-esp.sh
    # 'source export-esp.sh' must be invoked EACH TIME after a reboot/reset, before operation begins
    # with flake.nix it was automated, so you just need to call 'nix develop'
    rustup default esp
    rustup run esp cargo install espflash --locked

