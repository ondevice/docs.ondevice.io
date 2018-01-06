---
title: "Auth Keys"
date: 2017-12-11T21:20:57+01:00
weight: 2
---

Auth keys form the permission model of ondevice. You can manage your keys in your
[control panel][my-keys]

You need to call `ondevice login` with one of those keys on each system you want
to use with your ondevice account.

For personal use, a single `full` key is probably enough.

For more complex setups, we recommend a single `device` key (or one per
group of devices) and distinct `client`, `full` or `custom` keys for each end
user (or maintenance script) working with your devices.


ondevice.io tracks usage stats for each individual key. Using more keys gives
you more details on how each of them is being used.


### Roles

We provide *roles* that each come with their own set of *permissions* (for details
see the matrix below)


- `full`: has access to the whole account. Most useful for smaller setups
  (e.g. your personal ondevice.io account)
- `client`: read-only access to your account
  - can list devices (`ondevice list`)
  - can connect to them (`ondevice ssh`, `ondevice rsync`, ...)
  - can get device properties (`ondevice device $devId list`)
  - cannot set device properties
  - cannot run `ondevice daemon`
- `device`: can only run `ondevice daemon`
  - cannot list other devices or connect to them
  - can be considered insensitive (since they only allow passive access)
- `disabled`: Disables the given auth key.  
  Note that once a key has been deleted, all systems using it lose access to
  your account (and you might lose access to them).  
  Disabling keys before you delete them helps you minimize that risk
  (and have a look at auth key usage stats in your [control panel][my-keys])
- `custom`: Allows you to configure each permission individually.

### Permission Matrix

<table style="text-align: center">
<thead><tr>
  <th colspan="4" style="text-align: center">Roles</th><th style="text-align: center">Permissions</th>
</tr><tr>
  <th><code>full</code></th>
  <th><code>client</code></th>
  <th><code>device</code></th>
  <th><code>disabled</code></th>
  <th></th>
</tr></thead>
<tbody><tr>
  <td><i class="fa fa-check"></i></td><td></td><td><i class="fa fa-check"></td><td></td>
  <th class="permission"><code>device</code><br />
    Allows the client to run <code>ondevice daemon</code>
  </th>
</tr><tr>
  <td><i class="fa fa-check"></td><td><i class="fa fa-check"></td><td></td><td></td>
  <th class="permission"><code>connect</code><br />
    can run <code>ondevice ssh</code> etc. to connect to your devices
  </th>
</tr><tr>
<td><i class="fa fa-check"></td><td><i class="fa fa-check"></td><td></td><td></td>
  <th class="permission"><code>get_properties</code><br />
    has read access to device permissions
  </th>
</tr><tr>
<td><i class="fa fa-check"></td><td><i class="fa fa-check"></td><td></td><td></td>
  <th class="permission"><code>list_devices</code><br />
    can list devices
  </th>
</tr><tr>
  <td><i class="fa fa-check"></td><td></td><td></td><td></td>
  <th class="permission"><code>set_properties</code><br />
    can set/remove device properties
  </th>
</tr><tr>
  <td><i class="fa fa-check"></td><td></td><td></td><td></td>
  <th class="permission"><code>manage_devices</code><br />
    can rename and delete devices
  </th>
</tr></tbody>
</table>

<style>
th.permission {
  font-weight: inherit;
}
</style>

*Note: There's also the deprecated `manager` role which is similar to the new
`full` role but lacks the `device` permission. This role will be removed soon
and keys using it migrated.*

[my-keys]: https://my.ondevice.io/me/keys
