---
title: "Debian/Ubuntu/Raspbian"
linktitle: Debian
date: 2017-11-11T01:20:26+01:00
weight: 2
---

Installing the *ondevice* commandline client on Debian based systems is pretty straight forward.

We host a [debian repository](https://repo.ondevice.io/debian/), so you can install and upgrade *ondevice* using `apt-get`.

Before you start, make sure you've read the [basics]({{< ref "/basics/_index.md" >}})?

To set things up, simply run:

```sh
$ curl -sSL https://get.ondevice.io/ | sudo bash -
```

It'll set up the repository, add the necessary keys and install `ondevice`.

Prebuilt packages are available for i386, amd64 and armhf.  
If the above script has trouble detecting your OS or architecture, set the `$OS` and `$ARCH` environment variables respectively (and file a bug report [here][packaging-issues])

If above command worked, you're ready for the next step.  
ondevice.io distinguishes between devices and clients (clients connect to devices - no surprise there), so if you want to set up pure devices or clients, skip the other section.



### Device Setup

To autostart `ondevice daemon` (which allows you to connect to this device from anywhere else), simply run

```sh
$ sudo apt-get install ondevice-daemon
```

This command will ask you for your ondevice.io credentials (API tokens).

Note: It won't check if they're correct! If you've made a mistake or want to change them later, run:

```sh
$ sudo dpkg-reconfigure ondevice-daemon
```

The `ondevice-daemon` package takes care of everything needed to autostart `ondevice daemon` on each system boot.

After you're done, check `ondevice status` (you might need to wait a few seconds for the device to go online):

```
$ sudo ondevice status
Device:
  devID:  demo.de1eix
  state:  online
  version:  0.4.4

Client:
  version:  0.4.4
```

To be able to run `ondevice status` as normal user, add your username (the linux user, not the ondevice.io account) to the `ondevice` group):

```sh
$ sudo adduser "$USER" ondevice
```

That's it, your device has been set up. Continue with the client setup below or read [first steps][firstSteps]


### Client Setup

On the client side, run:

```sh
$ ondevice login
User: demo
Auth:
2017/05/30 17:57:19 Info: updating client auth
```

Now you can run `ondevice list`, `ondevice ssh`, etc. to access your devices.

For more detail on that, have a look at the [first steps][firstSteps] page.


### Advanced stuff

#### noninteractive device setup

To install the `ondevice-daemon` package non-interactively (e.g. in an automated setup script), use something like this little snippet:

```sh
# Answer debconf's questions before it can ask them
debconf-set-selections <<EOF
ondevice-daemon ondevice-daemon/ondevice-setup boolean true
ondevice-daemon ondevice-daemon/user string $YOUR_ONDEVICE_IO_USERNAME
ondevice-daemon ondevice-daemon/auth password $YOUR_DEVICE_TOKEN
EOF

apt-get install ondevice-daemon
```

[packaging-issues]: http://github.com/ondevice/ondevice-packaging/issues
[firstSteps]: {{< ref "/basics/_index.md" >}}
