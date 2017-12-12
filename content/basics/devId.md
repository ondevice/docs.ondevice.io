---
title: "Device ID"
linkTitle: "devId"
date: 2017-12-11T22:50:47+01:00
weight: 3
---

ondevice uses so called `devId`s to name devices.  
They are similar to regular host names, but don't resolve to IP addresses.

devIds are scoped to your ondevice.io account. Each of your devices has a unique
devId.  
devIds are case insensitive.

Initially, each device gets a random, 6 character *devId*. You can rename your
devices in your control panel or using:

    ondevice device $devId set on:id=$newId
