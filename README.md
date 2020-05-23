# TexStudio-autobuild
A simple tool to automatically compile documents made in TexStudio. This tool uses xdotool to automatically sends an F5 keypress to TexStudio to force compilation. The timer is only active when the TexStudio window is in focus.

This tool has no affiliation with the TexStudio project.

## Setup
 
### Dependencies

```
sudo apt install xdotool
```

## Usage

```
./texstudio-autobuild
```
This will cause recompilation every 60 seconds.

### Options
```
-i     set interval between compilations
-m     set interval to minutes, default becomes 60 minutes
-h     display the help info
```
