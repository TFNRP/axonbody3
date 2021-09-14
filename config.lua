Config = {
  --- handling used to verify if the client should be able to enable AB3
  --- @type function
  --- @return boolean
  CommandAccessHandling = function ()
    return exports.framework:IsLocalClientOnDuty()
  end,
  --- keybind to use for on/off command. can be nil for no keybind
  --- @type string
  CommandBinding = 'u',
  --- whether the axon overlay is also visible in third person
  --- @type boolean
  ThirdPersonMode = false,
}