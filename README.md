# Nowrap

Disables line wrapping in VT compatible terminals. It has no settings, it
does one thing and that is it. Works with coloured text too!

nowrap is used as follows
```
$ tput cols
40
$ echo "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
abcdefghijklmnopqrstuvwxyzabcdefghijklm
nopqrstuvwxyz
$ echo "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz" | nowrap
abcdefghijklmnopqrstuvwxyzabcdefghijklz
```

note: currently the last character (far right) does not show accurately,
see issue #1 for more details.
