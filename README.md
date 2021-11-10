<h2 align="center">FiveM Axon Body 3</h2>

<p align="center">
<a href="https://patreon.com/yeen"><img alt="Patreon" src="https://img.shields.io/badge/patreon-donate?color=F77F6F&labelColor=F96854&logo=patreon&logoColor=ffffff"></a>
<a href="https://discord.gg/xHaPKfSDtu"><img alt="Discord" src="https://img.shields.io/discord/463778631551025187?color=7389D8&labelColor=6A7EC2&logo=discord&logoColor=ffffff"></a>
</p>

## Table of Contents

- [About](#about)
- [Installation](#installation)
- [Features](#features)
- [Configuration](#configuration)
- [Credits](#credits)
- [Screenshots](#screenshots)

## About

The most realistic Axon Body 3 script, based off of [RCPisAwesome's Axon Body Camera](https://forum.cfx.re/t/realistic-axon-body-camera/1155758).  
![img](https://i.imgur.com/Kzf8WpA.png "Real AB3 overlay")  
![img](https://i.imgur.com/1QQ5LmF.png "This script")  

Image 1: a real AB3 overlay  
Image 2: this script  

TFNRP’s Axon Body 3 script’s goal is to be as realistic as possible, with future plans for more audio files the real Axon Body 3 uses.  

## Installation

Clone from Git or download manually  

```bash
$ git clone https://github.com/TFNRP/axonbody3.git
```

## Features

* Supports the [TFNRP framework](https://github.com/TFNRP/framework) to allow use for LEO.  
* Just like the real thing. Beeps every 2 minutes whilst recording, audible to nearby players.  
* Realistic overlay, with the same font used by Axon, ISO-8601 date format and transparent Axon logo.
* Maximum server performance. Everything that can be done client-side, is.
* Two commands included: 
  * `/axon`, `/axonon`, `/axonoff` - Starts/stops Axon recording
  * `/axonhide`, `/axonshow` - Hide/show the first-person overlay

## Configuration

All config variables are client-side and only computed on a client's machine.  

property | type | description
-- | -- | --
`CommandAccessHandling` | function | handling used to verify if the client should be able to enable AB3  
`CommandBinding ` | string\|nil | keybind to use for on/off command. can be nil for no keybind  
`ThirdPersonMode` | boolean | whether the axon overlay is also visible in third person  

## Credits

Special thanks to RCPisAwesome for allowing me to use his Axon beep sound.

## Screenshots

![img](https://i.imgur.com/mGZXo3l.png)
