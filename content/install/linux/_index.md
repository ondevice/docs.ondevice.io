---
title: "Install on Linux"
menuTitle: "Linux"
date: 2017-11-11T01:20:29+01:00
weight: 1
---

<div class="row">
  <div class="col col-md-4">
    <a class="btn btn-default btn-wide" href="{{< relref "install/linux/deb.md" >}}">debian</a>

    <p>We host a package repo for debian based distributions.<br />
    Click the button above to get to the instructions.</p>
  </div>
  <div class="col col-md-4">
    <a class="btn btn-default btn-wide" href="#manual-installation">Others</a>

    <p>For other systems, please refer to the instructions below.</p>
  </div>
</div>

<br /><br />

## Manual Installation

We provide a simple one-liner to install the `ondevice` commandline tool:

```sh
curl -sSL https://get.ondevice.io/ | sudo bash -
```

It will download the current version of the `ondevice` binary matching your
OS/ARCH from `https://repo.ondevice.io/client/stable/` and copy it to
`/usr/local/bin/ondevice`.

<div class="alert alert-info">
  <strong>Note:</strong>
  If possible use one of the other installation methods. <br />
  The binary-only installation is just that: it installs a single file.<br />
  No automated updates, no autostart, etc.
</div>
