---
title: "What is ondevice"
date: 2017-11-11T11:39:26+01:00
weight: 1
---

`ondevice` is a wrapper around `ssh` (and other tools) to allow access to
devices even if they're behind a NAT (without having to bother with dynamic IPs
or port forwarding).

It does so by tunneling connections through the [ondevice.io][ondevice] network
(using HTTPS WebSockets).


We distinguish between `devices` (computers that wait for incoming connections)
and `clients`, the computers that can connect to these devices.

Devices run `ondevice daemon` as a system daemon and maintain a connection to
our API servers, waiting for incoming connections.
They forward incoming connections to the system's SSH server (so you still need
to authenticate to your SSH server, nothing's changed in that regard).

The clients run stuff like `ondevice ssh` or `ondevice rsync` (either scripted or
interactively).

Each client/device has to be authenticated using `ondevice login` (using one of
your [ondevice.io authentication keys](//my.ondevice.io/me/keys)), only you
have access to your devices.


## Characteristics

- Since all the traffic is tunneled through HTTPS websockets, `ondevice` will
  work in most environments, no router configuration necessary.
- `ondevice` acts as a *proxy command* for the OpenSSH client. You still need
  to authenticate to the device's SSH server (i.e. even if an attacker
  compromised your ondevice.io account, they wouldn't get access to your devices).  
  But as always: Make sure to use strong passwords.
- Traffic is tunneled through the ondevice.io API servers.
  Don't worry, all of it is end-to-end encrypted (it's ssh after all).
- each ondevice.io account is its own, separate namespace. Only you get access
  to your devices (you can explicitly grant other people access to your devices
  by handing them an API key)
- `ondevice ssh` is scriptable.
  it'll exit with the remotely executed command's exit code.  
  Also, most `ondevice` commands offer machine-readable JSON output.
- ondevice is built to scale, so it will initially give each device a random,
  6-character devId (like `keeSh7`), but you can rename them later of course.
- devices usually don't have access to other devices registered to the same
  account (i.e. we make a strong distinction between devices and clients).
  But there's noting stopping you to set up both on the same computer.

## Differences to VPNs

ondevice.io is a tunnel service, not a VPN.

In many ways, those two are similar, but:

- VPNs place your whole PC in an additional network (sometimes routing all
  your traffic through it).
- VPNs often use UDP and most of the time special port numbers that are often
  blocked in open networks (hotels, airports, etc.). Even if you get network
  admins to explicitly whitelist your VPN traffic, things break when the server
  IP changes.
- VPNs are prone to IP conflicts (one of the clients being in a physical network
  using the same IP range then your VPN). While these are rare, they are quite
  hard to work around
- ondevice uses standard websockets over HTTPS, a combination that works in
  most real-life scenarios (but obviously comes with a little more protocol
  overhead than VPN)
- ondevice (at least right now) only supports SSH traffic (SSH is a powerful
  beast though ;) ). But we're working on adding support for other protocols
  (as well as generic TCP or UDP tunnels)

[ondevice]: //ondevice.io/
