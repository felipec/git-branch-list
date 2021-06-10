# git-branch-list

The current version of `git branch --list` mostly works, but it's slow and cumbersome. While this
could easily be fixed in git itself, every patch that tries to improve the user interface is
de facto rejected.

An external command `git branch-list` is the solution.

## Advantages

Why is `git branch-list` better?

1. It provides useful information at all verbosity levels
1. It does not clutter the output with unhelpful characters
1. It provides a more consistent output
1. It sorts branches
1. It filters branches
1. It tracks branches in a simpler way
1. It's faster

## Example

### Offcial `git branch --list`

Say you have a `master` branch that tracks a remote branch, but it's not always up-to-date (we'll
use Linux's repository).

In this case official `git branch` will show this:

    * master

This doesn't provide much information. If you use the `--verbose` option, you get:

    * master 9f4ad9e425a1 [behind 16592] Linux 5.12

OK, we are behind by 16592 commits, but behind what? We can guess from the commit title, but it's
not really clear.

If we use `--verbose --verbose` we get:

    * master 9f4ad9e425a1 [origin/master: behind 16592] Linux 5.12

Finally we have some useful information, but it took two levels of verbosity, and there's a lot of
information that isn't typically useful.

### Our `git branch-list`

On the other hand, with `git branch-list`:

    * master origin/master

Boom! Right away we see the most useful information: `master` tracks `origin/master`.

Then, if we want to know when the branches are up-to-date, we use `-t`:

    * master origin/master<

Do we really care if we are 16592 commits behind, as opposed to 14386 commits behind? No, all we
care about is that we are beind, which the `<` symbol represents. This is the same information you
get when you use `__git_ps1` with `GIT_PS1_SHOWUPSTREAM=auto`.

If you want even more information you can specify the `-v` option:

    * master [origin/master<] Linux 5.12

We get all the most useful information at all levels (who cares what the object id is?).

## Convenience

You can get some of the advantages of `git branch-list` from the official `git branch`, whoever, you
need to know specifically which options to enable.

For example, let's say you have several branches that update documentation prefixed with `doc-`.
With the official `git branch` you could do something like:

    git branch --list doc-*

This works, however, 1) it doesn't work unless you specify `--list`, and 2) you need to add the
asterisk (`*`).

On the other hand with `git branch-list`:

    git branch-list doc

You don't need any option, nor asterisk. It just works straightaway.

Another example; you can enable a useful sorting of branches with the following configuration:

    [branch]
            sort = -committerdate

But with `git branch-list` you don't need to; it's sorted by default.
