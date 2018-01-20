---
title: "ondevice list"
menuTitle: "list"
date: 2017-11-19T00:49:15+01:00
weight: 4
---

List your devices and their state

### Usage

```sh
ondevice list [--options...] [filters...]
```

### Options

- `--json`  
  Print each device as JSON object (one per line).  
  e.g.: `{"id":"demo.7t91ta",state":"offline","stateTs":1490197318991,"version":"ondevice v0.4.3"}`
- `--print-ids`  
  Print devIDs only, one per line (mutually exclusive with `--json`)
- `--props`  
  Also fetch device properties (will be included in the JSON output
- `--state=<online/offline>`  
  Filter devices by their state.  
  This is equivalent to the filter expression `on:state=<online/offline>` (see below)
  but filtered on the server (while filter expressions are processed on the client)


### Filter expressions

With `v0.5.3`, `ondevice list` adds support for simple filter expressions.

These allow you to search for devices matching certain [properties][properties].

Filter expressions have the following syntax:

    propertyName[operator[value]]

Supported operators:

- `=`, `==`: equality
- `!=`: not equal
- `<`, `<<`: less than
- `>`, `>>`: greater than
- `<=`: less than or equal (case sensitive string comparison)
- `>=`: greater than or equal (case sensitive string comparison)

For example (assuming you've set device properties accordingly):

- `arch` lists devices with the `arch` property (equivalent to `arch!=`)
- `arch=` lists devices without the `arch` property (read: where the `arch`
  property is empty)
- `arch=amd64` lists devices with architecture `amd64`
- `'version_foo<1.2.3'` lists devices with a *foo* package older than *v1.2.3*  
  Note that this also matches the empty string (and also note that in most
    shells you'll have to escape `<` and `>`)
- `version_foo 'version_foo<1.2.3'` lists devices where the *foo* package is
  installed but older than *v.1.2.3*  
  (this one doesn't match the empty string, thus excluding devices without the
  property)


### Examples

#### Discovering device characteristics

This example lists online devices without the `arch` property and tries to discover it.

We're using Debian's `dpkg --print-architecure` here.
Similar commands can be used for other distros/OSs.


```sh
#!/bin/bash
# "discover.sh"
set -e
for devId in $(ondevice list --print-ids --state=online arch= | shuf); do
  echo "=====\n Fetching device info: '$devId'\n====" >&2
  # fetch arch and distro version
  arch="$(ondevice ssh "user@$devId" dpkg --print-architecture)"
  distro="$(ondevice ssh "user@$devId" lsb_release -s -c)"

  if [ -z "$arch" -o -z "$distro" ]; then
    echo "Failed to fetch device info for '$devId': arch='$arch' distro='$distro'" >&2
    exit 1
  fi
  # set device properties
  ondevice device "$devId" set arch="$arch" distro="$distro"
done

echo "~~~ all done ~~~" >&2
```

We're using `shuf` to randomise the list of matching devices (doing that prevents
us from getting stuck at a single misbehaving device in subsequent runs).

Also, we're failing early (at the first error). This makes it easier to diagnose
issues when running the script manually.

Extend this script to fit your needs and run it periodically (e.g. once an hour as cronjob)
to automatically gather device infos.

Note that for long-running scripts, devices may go offline by the time it's their
turn. This will cause the script to fail (but since we run it relatively often,
that shouldn't be too big an issue)

Make sure you set up ssh-key based authentication for this to work noninteractively.



### Further notes:

- undefined properties evaluate to the empty string
- The operators only perform relatively simple (case sensitive) string comparison.  
  This means that `43<5`, `hello>World` etc.  
  So if you want to use comparison operators, make sure you
  - use zero-padded numbers
  - use UNIX time stamps or formats like ISO-8601 for time stamps
  - take care when comparing version numbers
  - ...
- Except for special properties (the ones starting with `on:`), no properties are
  predefined. It is up to you to write scripts to annotate your devices with
  them
- for each single-character operator there's a two-character version.  
  Use them if you expect variable input to avoid parsing ambiguities, e.g.:  
  `foo=="=bar="` will look for the value `=bar=` while `foo="=bar="` would only match `bar=`


### Help text

{{< snippet "help/list.txt" >}}

[properties]: {{<relref "basics/properties.md">}}
