# Axon Body 3

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
