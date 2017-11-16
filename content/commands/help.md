---
title: "help"
date: 2017-11-16T17:57:17+01:00
draft: true
---

## Usage:
- `ondevice help`
- `ondevice help <cmd>`

Lists available commands and prints usage information on each of them

## Examples:

```
# ondevice help
USAGE: ondevice <command> [...]

- Device commands:
    daemon [--conf=ondevice.conf] [--pidfile=ondevice.pid] [--sock=unix://ondevice.sock]
         Run the ondevice device daemon
    stop
         Stops the local ondevice daemon (if running)

- Client commands:
    device <devId> <props/set/rm> [key1=val1 ...]
         List/manipulate device properties
    event [--json] [--since=eventId] [--until=eventId] [--count=50] [--type=...] [--device=...] [--timeout=30] [--await=eventType]
         Prints past (and listens for live) account events
    list [--json] [--props] [--status=<online/offline>]
         List your devices
    rsync [rsync args...]
         Copy files from/to your devices using rsync
    ssh [ssh-arguments...]
         Connect to your devices using the ssh protocol

- Other commands:
    help [cmd]
         Shows this help screen
    status [--json]
         Prints the client and local device status
    login [--batch=username]
         Log in to the ondevice.io service
```

```
# ondevice help login
$ ondevice login

Log in to the ondevice.io service using one of your API keys.

Options:
--batch=username
  Run in batch mode, using the given username and reading the authentication key
  from stdin, e.g.:
    echo '5h42l5xylznw'|ondevice login --batch=demo


Example:
  $ ondevice login
  User: <enter your user name>
  Auth: <enter your credentials>
```
