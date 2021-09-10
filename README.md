# vim-projplugin

The ftplugin equivalent for projects.

## Motivation

Vim provides a way to load configuration based on the filetype of the current buffer.
While this is nice, I also have the requirement to load configuration based
on the project.

The Vim way to do this would be to use `set exrc` and have a `.vimrc` in the
root of your project. But it's deprecated and unsafe.

There are also [some][1] [plugins][2] which provide this functionality.
Those plugins require you to have a file in the root of your project.

Having a file in the root of your project may be fine for personal projects
but I wouldn't want my editor config spread into my projects (especially
work projects). Of course I could exclude the `.vimrc` from git. But then I wouldn't
have any sort of backup for those files.

Instead I want to have one path where I can configure all my projects.
This way I can track changes with version control and still keep my projects free
of my editor configuration.

## How To

Lets say your project is `~/projects/github/vim-projplugin`.
Then you can add `$VIMRUNTIME/projplugin/vim-projplugin.vim` (or `.lua`) and
configure it like you would configure a [ftplugin][3].

Then you open Vim from the root of the project and your config is loaded for
every buffer. When you want to open `plugin/projplugin.vim` you should do so by
executing `vim plugin/projplugin.vim` instead of `cd plugin && vim projplugin.vim`.

To make your life easier install [vim-rooter][4] which will take care that the `pwd`
is always the root of your project.

## State of this plugin

I'm using this plugin for over a year now and haven't had any issues yet. Since
I consider it mostly feature complete there probably won't be many changes.
Feel free to create an issue if you have an idea or spot an error.

[1]: https://github.com/LucHermitte/local_vimrc
[2]: https://github.com/embear/vim-localvimrc
[3]: http://vimdoc.sourceforge.net/htmldoc/usr_41.html#ftplugin
[4]: https://github.com/airblade/vim-rooter
