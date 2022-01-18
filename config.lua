--- Client-side config.
--- @type table
Config = {
  --- Handling used to verify if the client should be able to enable AB3.
  --- @type function
  --- @return boolean
  CommandAccessHandling = function ()
    -- Add custom framework access handling here.
    return true
  end,
  --- Keybind to use for on/off command. can be nil for no keybind.
  --- @type string
  CommandBinding = 'u',
  --- Whether the axon overlay is also visible in third person.
  --- @type boolean
  ThirdPersonMode = false,
}