# configuration_files

Installation and configuration files.

## Firefox extensions

- uBlock Origin.
- LessPass.

## KataGo

Run the benchmark function to get the best parameters.

## Sabaki

```shell
<path_to_katago_executable>
gtp -model <neural_net_path> -config <config_path>
```

## SSH

Private variables and commands are declared in a `.zsh` file placed in `$ZSH_CUSTOM` folder.

- For basic usage: `ssh <user>@<ip> -p <port>`.
- For X11 forwarding: `ssh -X <user>@<ip> -p <port>`.
- To redirect a port (also working for multiple ports): `ssh -L 16006:127.0.0.1:6006 <user>@<ip> -p <port>`, and go to [127.0.0.1:16006](127.0.0.1:16006).
- To share files with `sshfs`: `sshfs <user>@<ip>: -p <port> <folder_path_in_which_to_mount>`.
- To share files with `scp`: `scp -P <port> <user>@<ip>:<file_path_to_share> <path_location>`.

To share files or a website with the world (with or without password) --> Apache2.

## Android

Google Play builds are no longer updated for Termux (https://github.com/termux/termux-app/issues/1072).
So Termux needs to be installed from F-Droid (https://f-droid.org/FDroid.apk), along with Termux:API.
