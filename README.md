# wlrc

Wayland compositor configurations for
[sway](https://swaywm.org) and
[labwc](https://labwc.github.io/index.html)

## Dependencies

Following packages are needed to be installed for corresponding functions working:

[swaylock](https://github.com/swaywm/swaylock)
lock screen

[WirePlumber](https://wiki.archlinux.org/title/WirePlumber#Keyboard_volume_control)
(`wpctl` command for volume control)

[wob](https://github.com/francma/wob)
(volume indicator bar)

[grim](https://gitlab.freedesktop.org/emersion/grim)
, [sway-contrib](https://github.com/OctopusET/sway-contrib)
(`grimshot` helper for screenshot)

## Usage

"Clone repo and add scripts to PATH:

```
$ git clone https://github.com/undus5/wlrc.git ~/wlrc
$ ln -s ~/wlrc/*.sh /usr/local/bin/
$ ln -s ~/wlrc/sway ~/.config/sway
$ ln -s ~/wlrc/labwc ~/.config/labwc
```

## Sway Keybindings

General control:

> Super + Ctrl + e (exit sway)\
> Super + Ctrl + r (reload sway)\
> Super + Ctrl + q (kill focused window)

> Super + a (focus on parent container)\
> Super + s (focus on child)\
> Super + d (menu for launching app)\
> Super + f (toggle window fullscreen)\
> Super + g (toggle status bar showing)
> Super + Return (open terminal emulator, alacritty)

Session control:

> Super + Ctrl + a (lock screen)\
> Super + Ctrl + s (lock screen and suspend)

Focus to direction:

> Super + h (focus left)\
> Super + j (focus down)\
> Super + k (focus up)\
> Super + l (focus right)

Move to direction:

> Super + Shift + h (move to left)\
> Super + Shift + j (move to down)\
> Super + Shift + k (move to up)\
> Super + Shift + l (move to right)

Switch to workspaces:

> Super + 1/2/3/4/5/6/7/8/9/0\
> Super + q/w/e/r/t/y/u/i/o/p/[/]\
> Super + z/x/c/v/b/n/m

Move to workspaces:

> Super + Shift + 1/2/3/4/5/6/7/8/9/0\
> Super + Shift + q/w/e/r/t/y/u/i/o/p/[/]\
> Super + Shift + z/x/c/v/b/n/m

Layout toggle:

> Super + = (switch to stacking layout)\
> Super + \ (toggle split layout between horizontal and vertical)\
> Super + ` (toggle current float window always on screen)

> Super + ; (splitv, split next window to vertical layout)\
> Super + ' (splith, split next window to horizontal layout)

Volume control:

> Super + , (volume -5%)\
> Super + . (volume +5%)\
> Super + / (toggle mute speaker)\
> Super + Shift + / (toggle mute microphone)

Screenshot:

> Super + Ctrl + c (take screenshot for selected area)
> Print (take screenshot fullscreen)

## Labwc Keybindings

> Super + d (menu for launching app)\
> Super + Return (open terminal emulator, alacritty)

> Super + , (volume -5%)\
> Super + . (volume +5%)\
> Super + / (toggle mute speaker)\
> Super + Shift + / (toggle mute microphone)

> Super + Up/Down/Left/Right (snap window to edge of screen, toggle)

> Alt + Tab (list and switch running app)

> Super + Space (open right click menus)

Session control, power control and screenshot are in right click menus.

