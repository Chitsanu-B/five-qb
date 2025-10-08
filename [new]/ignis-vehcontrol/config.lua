Config = {}

Config.Framework = 'AUTO' -- 'ESX', 'QB', or 'AUTO' for automatic detection

Config.OpenKey = 311 -- K key to open/close
Config.CloseKey = 200 -- ESC key to close

Config.UpdateInterval = 1000 -- UI update frequency (ms)
Config.RequireInVehicle = true -- Must be in vehicle to use

Config.EnableSeatSwitching = true
Config.EnableDoorControls = true
Config.EnableWindowControls = true
Config.EnableEngineToggle = true
Config.EnableLightsToggle = true

Config.DisableAutoEngineStart = true -- Set to true to disable automatic engine start when entering vehicle, false to allow normal behavior

Config.RequireJob = false -- Set to job name like 'police' or false
Config.AllowedJobs = {
    'police',
    'mechanic'
}

Config.FuelSystem = 'LegacyFuel' -- 'LegacyFuel', 'ox_fuel', 'ps-fuel', or 'NONE'

Config.Notifications = {
    MustBeInVehicle = 'You must be in a vehicle to use this.',
    SeatSwitched = 'Switched to seat',
    SeatOccupied = 'Seat is occupied',
    NoPermission = 'You do not have permission to use this.'
}

Config.Debug = false