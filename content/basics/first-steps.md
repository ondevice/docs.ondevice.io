---
title: "First Steps"
date: 2017-11-13T00:01:20+01:00
weight: 1
---

<div class="alert alert-info">If you haven't installed <code>ondevice</code>
on your systems yet, have a look at the
<a href="{{< relref "/install/_index.md" >}}">install page</a>.
This document assumes you've already set up at least one device
(running <code>ondevice daemon</code>) and a client PC.</div>

#### a quick status check

Let's run `ondevice status` on the device to make sure it's actually online:

```sh
$ ondevice status
Device:
  devID:  demo.aed5vu
  state:  online
  version:  0.5.1

Client:
  version:  0.5.1
```

Our device is online as `demo.aed5vu`.  
**Note:** The `demo.` prefix can be omitted when connecting to your own devices)

Now let's see if `ondevice list` on the client agrees:

```sh
$ ondevice list
ID             State   IP              Version         Name
demo.aed5vu    online  192.123.56.47   ondevice v0.5.1
```

Awesome.  
`ondevice list` can be used to get a quick overview of the states of
your devices.


#### connect to your device

Ok, our device is online. Let's `ssh` into it:

```txt
$ ondevice ssh pi@aed5vu
pi@demo.aed5vu's password:

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Sun Dec 10 23:23:40 2017 from localhost
pi@raspberrypi:~ $ uptime
 20:33:04 up 9 days,  4:05,  4 users,  load average: 0.05, 0.03, 0.00
```

We can also use any of `ssh`'s commandline flags (or use it non-interactively), e.g.:

```txt
$ ondevice ssh root@aed5vu apt-get update '&&' apt-get upgrade
# or:
$ ondevice ssh -f -N -L 6379:localhost:6379 pi@aed5vu
```

#### rename the device

Initially, each device running `ondevice daemon` gets a random [devId][devId].  
But you can rename them later, either in your [control panel][my-ondevice] or
setting the `on:id` [special property][properties] of the device:

    $ ondevice device aed5vu set on:id=rpi

#### set properties

You can also set custom properties for each device. This can be used to store
certain characteristics or to keep track on the state of your maintenance scripts:

```txt
$ ondevice device rpi set arch=armhf distro=raspbian
$ ondevice device rpi set lastUpgrade=2017-12-13
$ ondevice device rpi list
on:oldId=aed5vu
on:createdAt=2017-11-19T22:45:12.044Z
on:id=rpi
on:name=RaspberryPi3 im Office
arch=armhf
distro=raspbian
lastUpgrade=2017-12-13
```



[devId]: {{< relref "basics/devId.md" >}}
[my-ondevice]: https://my.ondevice.io/
[properties]: {{< relref "basics/properties.md" >}}
