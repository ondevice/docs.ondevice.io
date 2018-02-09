---
title: "Device Properties"
linkTitle: "Properties"
date: 2017-12-12T23:44:41+01:00
---

Device properties are a way to keep track of your devices' characteristics,
such as:

- static properties like OS/distro/architecture
- *"uses version `1.2.3` of package `xyz`"*: (`version_xyz=1.2.3`)
- *"has executed script `abc` 2 days ago"*: `script_abc=2018-01-13T12:34:56Z`

A good way to think of them would be as a simple device-scoped key-value store.

<br />

You can manage them using [`ondevice device`][ondevice-device]:

- `ondevice device $devId props` lists them for any given devId
- `ondevice device $devId set key1=val1 key2=val2 ...`  
  sets device properties
- `ondevice device $devId rm key1 key2 ...`  
  removes one or more properties by name

### Special properties

ondevice uses the following special properties (with the prefix `on:`):

- `on:id`  
  the [devId][devId] [rw]  
  - use `ondevice device $oldId set on:id=$newId` to rename a device
  - `ondevice device $devId rm on:id` deletes the device (only works for offline devices)
- `on:name` [rw]  
  the human-readable name of the device  
  This descriptive name will be listed by `ondevice list` as well as the device
  list in your [control panel][control-panel]
- `on:createdAt` [ro]  
  timestamp of the device's creation (in ISO 8601 format, e.g. `2018-01-15T17:01:33Z`)

If available, you can also use the following, read only, properties containing
information on a device's current state (if available):

- `on:state` [ro]  
  `offline` or `online`
- `on:stateTs` [ro]  
  The ISO timestamp of the last state change (i.e. *"on/offline since"*)
- `on:ip` [ro]  
  The device's (last known) IP
- `on:version` [ro]  
  The User-Agent string (i.e. client version) of the device in question (e.g. `ondevice v0.5.3`)


### `ondevice list`

`ondevice list --json --props` is a quick way to get a machine-readable list of
all your devices and their properties.


You can use `ondevice list` filter expressions to search for devices with certain
properties.

Have a look at [ondevice list's documentation][ondevice-list] for details.


### Further notes

- Property names are case sensitive
- `ondevice list` filter expressions also perform case sensitive comparisons
- Property names can contain alphanumeric characters as well as `_` and `-`
- Property names can't be longer than 100 chars
- setting a property to the empty string deletes it
- special properties start with `on:`
- Updating your properties will trigger `propertiesSet` or `propertiesDeleted` events
- property values can be up to 1kB in size.
- You need the `get_properties` permission (`client`, `full` or custom
  [AuthKey]({{<relref "basics/auth-keys.md">}}) roles) to read properties and
  the `set_properties` permission to alter them.
- properties are stored on the ondevice servers and devices usually can't access
  them

[control-panel]: https://my.ondevice.io/
[devId]: {{<relref "basics/devId.md">}}
[ondevice-device]: {{<relref "commands/device.md">}}
[ondevice-list]: {{<relref "commands/list.md">}}
