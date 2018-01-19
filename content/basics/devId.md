---
title: "Device ID"
linkTitle: "devId"
date: 2017-12-11T22:50:47+01:00
weight: 3
---

ondevice uses so called `devId`s ("device IDs") to identify devices.

They are similar to regular host names, but don't resolve to IP addresses.

devIds are scoped to your ondevice.io account. Each of your devices has a unique,
case insensitive devId.


### renaming your devices

Initially, each device gets a random, 6 character alphanumeric *devId*.
You can rename your devices in your [control panel](https://my.ondevice.io/me/)
(in the maintenance tab of the device's page)
or by using:

    $ ondevice device $devId set on:id=$newId

*See: [ondevice device][ondevice-device]*

### qualified vs. unqualified devIds

`ondevice list` and the control panel display so called qualified devIds
(with your username and a dot as prefix, e.g. `demo.rpi` instead of just `rpi`).

Both are equivalent as long as you just access the devices of your own account
(we advise you to use the qualified versions in scripts though).

We plan to add multiuser support in one way or another in the future, at
which point qualified devIds will become more relevant.

### Human-readable device names

In addition to the `devId`, you can also set an optional, human-readable device
name.  
Its purpose is simply to make your device list easier to read
(in `ondevice list` as well as the control panel).

Device names are pretty much free form, but can be no longer than 100 characters

You can set them using the `on:name` special property:

    $ ondevice device "$devId" set on:name="This is my Raspberry PI at home"

You can only use your <em>devId</em> for `ondevice ssh` etc, not these human-readable names

### Validation

devIDs can be anything from 3 to 50 characters long and are validated using the
following regex: `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*$`

To clarify:

- you can use alphanumeric characters and hyphens, but
- hyphens aren't allowed at the beginning or end of the devId
- each hyphen must be followed by at least one alphanumeric character (i.e. hyphens
  can't touch)

### Further notes

- For smaller, mostly static setups we recommend renaming each device to simplify
  `ssh`-ing into them interactively (`ondevice ssh me@postgres` is easier to
  remember than `ondevice ssh me@f5asc7`)
- For larger setups, just keep the randomly assigned IDs and manage your devices
  using [device properties][properties] (and
  `ondevice list` to filter them)
- as mentioned, we recommend you use qualified IDs in scripts

[ondevice-device]: {{<relref "commands/device.md">}}
[properties]: {{<relref "basics/properties.md">}}
