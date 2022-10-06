# My dotfiles (and some helpful scripts)

This is designed to be used by having the actual dotfiles (like `$HOME/.bashrc`) link to the files in the git repo (for example, `source <repo>/dotfiles/bashrc` inside `$HOME/.bashrc`). This way there's no synchronization mechanism to worry about. This obviously won't work for everything, but for what I have so far, it's all I need. 

The `bin` directory contains the aforementioned helpful scripts, it should be added to your `$PATH`, and don't forget to run `chmod +x bin/*`.

