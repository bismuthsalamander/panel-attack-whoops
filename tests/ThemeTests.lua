local consts = require("consts")
require("FileUtil")
require("Theme")

assert(Theme ~= nil)

local defaultTheme = Theme(consts.DEFAULT_THEME_DIRECTORY)

assert(defaultTheme ~= nil)
assert(defaultTheme.name ~= nil)
assert(defaultTheme.version == 2)
assert(defaultTheme.images.bg_main ~= nil)
assert(defaultTheme.multibar_is_absolute == true)

recursive_copy("tests/ThemeTestData/", Theme.themeDirectoryPath)

-- Deletes an entire directory. BE VERY CAREFUL
local function recursiveRemoveDirectory(folder)
  local lfs = love.filesystem
  local filesTable = lfs.getDirectoryItems(folder)
  for _, fileName in ipairs(filesTable) do
    local file = folder .. "/" .. fileName
    local info = lfs.getInfo(file)
    if info then
      if info.type == "directory" then
        recursiveRemoveDirectory(file)
      elseif info.type == "file" then
        love.filesystem.remove(file)
      end
    end
  end
  love.filesystem.remove(folder)
end

local v2Theme = Theme("V2Test")
assert(v2Theme ~= nil)
assert(v2Theme.name == "V2Test")
assert(v2Theme.version == 2)
assert(v2Theme.images.bg_main ~= nil)
assert(v2Theme.multibar_is_absolute == true)
assert(v2Theme.bg_main_is_tiled == true)
recursiveRemoveDirectory(Theme.themeDirectoryPath .. v2Theme.name)

local v1Theme = Theme("V1Test")
assert(v1Theme ~= nil)
assert(v1Theme.name == "V1Test")
assert(v1Theme.version == 2) -- it was upgraded
assert(v1Theme.images.bg_main ~= nil)
assert(v1Theme.multibar_is_absolute == false) -- old v1 default
assert(v1Theme.bg_main_is_tiled == true) -- override from v1 default
recursiveRemoveDirectory(Theme.themeDirectoryPath .. v1Theme.name)

local v2AbsoluteTheme = Theme("V2AbsoluteTheme")
assert(v2AbsoluteTheme ~= nil)
assert(v2AbsoluteTheme.name == "V2AbsoluteTheme")
assert(v2AbsoluteTheme.version == 2)
assert(v2AbsoluteTheme.multibar_is_absolute == false) -- override
recursiveRemoveDirectory(Theme.themeDirectoryPath .. v2AbsoluteTheme.name)