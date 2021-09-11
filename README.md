<h2 align="center">FiveM Axon Body 3</h2>

<p align="center">
<a href="https://patreon.com/yeen"><img alt="Patreon" src="https://img.shields.io/badge/patreon-donate?color=F77F6F&labelColor=F96854&logo=patreon&logoColor=ffffff"></a>
<a href="https://discord.gg/xHaPKfSDtu"><img alt="Discord" src="https://img.shields.io/discord/463778631551025187?color=7389D8&labelColor=6A7EC2&logo=discord&logoColor=ffffff"></a>
</p>

## Table of Contents

- [About](#about)
- [Configuration](#configuration)
- [Screenshots](#screenshots)

## About

The most realistic Axon Body 3 script.  
![img](https://i.imgur.com/Kzf8WpA.png "Real AB3 overlay")  
![img](https://i.imgur.com/1QQ5LmF.png "This script")  

Image 1: a real AB3 overlay  
Image 2: this script  

This script is intended for use with developers as a baseplate.  
TFNRP's Axon Body 3 script's goal is to be as realistic as possible.  

## Features

* Uses the [TFNRP framework](https://github.com/TFNRP/framework) to allow use for LEO.  
* Just like the real thing. Beeps every 2 minutes whilst recording, audible to nearby players.  
* Realistic overlay, with the same font used by Axon, ISO-8601 date format and transparent Axon logo.
* Maximum server performance. Everything that can be done client-side, is.

## Configuration

`client.lua:120` for the overlay to be visible in third-person, change to:
```lua
      if not hudForceHide then
```

## Screenshots

![img](https://i.imgur.com/mGZXo3l.png)
