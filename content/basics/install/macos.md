---
title: "Mac OS"
date: 2017-11-11T01:20:32+01:00
weight: 3
---

### Installation using homebrew (recommended)

We provide a [homebrew][homebrew] package for `ondevice`.

Simply run:

```txt
$ brew install ondevice/ondevice/ondevice
```

Then, [set up your ondevice.io account](//my.ondevice.io/signup) and
[create an authentication key](//my.ondevice.io/me/keys).

Use these credentials to login:

```txt
$ ondevice login
User: demo
Auth: **********
```


#### Device setup

If you want to set your mac up as device (meaning that you can log into it from
anywhere using `ondevice ssh`), use the following command:

```txt
$ brew services start ondevice
```


### Alternative: Using the one-liner

As with all other supported UNIX-based systems, you can install ondevice using
the following command:

```sh
$ curl -sSL https://get.ondevice.io/ | sudo bash -
```

If it detects homebrew, it'll use it. If it doesn't, it'll fall back to a
binary-only install (downloading the macos binary from
[repo.ondevice.io](//repo.ondevice.io/client/current/macos/) and installing it
to `/usr/local/bin/`).



[homebrew]: //brew.sh/
