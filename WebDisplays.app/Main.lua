--------------------------------core---------------------------------------------
local GUI = require("GUI")
local system = require("System")
local image = require("Image")
local fs = require("Filesystem")
local component = require("component")
local wdScreen = component.get("webdisplays")
local SD = fs.path(system.getCurrentScript())
local localization = system.getLocalization(SD .. "/Localizations/")
local url = nil

if not wdScreen then
  GUI.alert(localization.wdnc)
  return
end

local workspace, window, menu = system.addWindow(GUI.tabbedWindow(1, 1, 100, 30, 0xE1E1E1))
local layout = window:addChild(GUI.layout(1, 3, window.width, window.height, 1, 1))
-- Add single cell layout to window

--local contextMenu = menu:addContextMenuItem("Settings")
--contextMenu:addItem("TurnOff Display")
--contextMenu:addItem("Close").onTouch = function()
--  window:remove()
--end
-- Context menu

---------------------------functions---------------------------------------------

local function Tab(txt, func)
  window.tabBar:addItem(txt).onTouch = function()
    layout:removeChildren()
    func()
    workspace:draw()
  end
end
--Tab

local function Input(txt)
  layout:addChild(GUI.input(2, 2, 30, 1, 0xD2D2D2, 0x555555, 0x999999, 0xD2D2D2, 0x2D2D2D, "", txt))
end

local function Text(txt)
layout:addChild(GUI.text(1, 1, 0x2D2D2D, txt))
end
--Text

local function Button(txt)
return layout:addChild(GUI.roundedButton(1, 1, 30, 1, 0xD2D2D2, 0x696969, 0x4B4B4B, 0xF0F0F0, txt))
end
--Button

local function BButton(txt)
return layout:addChild(GUI.roundedButton(1, 1, 30, 3, 0xD2D2D2, 0x696969, 0x4B4B4B, 0xF0F0F0, txt))
end
--Big Button

local function Image(adr)
 layout:addChild(GUI.image(1, 1, image.load(SD .. adr)))
 end
--image

function openURL(url)
  if wdScreen.isLinked() then
    wdScreen.setURL(url)
  else
    GUI.alert(localization.wdnl)
  end
end
--open URL

----------------------------------main-------------------------------------------

Tab(localization.urlc, function()
  Text(localization.srch)
  Button(localization.gogl).onTouch = function()
    openURL("google.com")
  end
  Button(localization.yanx).onTouch = function()
    openURL("yandex.ru")
  end
  Text(localization.polr)
  Button(localization.ytbe).onTouch = function()
    openURL("youtube.com")
  end
  Button(localization.ruvk).onTouch = function()
    openURL("vk.com")
  end
  Button(localization.twtr).onTouch = function()
    openURL("twitter.com")
  end
  Button(localization.fabk).onTouch = function()
    openURL("facebook.com")
  end
  Button(localization.gthb).onTouch = function()
    openURL("github.com")
  end
  Text(localization.curl)
  WebAdr = Input(localization.tyrl)
  BButton(localization.gobn).onTouch = function()
    openURL(WebAdr)
  end
end )


Tab(localization.sett, function()
  Image("/Resources/Sett.pic")
  BButton(localization.offs).onTouch = function()
    openURL("mod://webdisplays/main.html")
  end
  Button(localization.unlk).onTouch = function()
    wdScreen.unlink()
  end
end )

Tab(localization.abot, function()
  Image("/Resources/Auth.pic")
  Text(localization.auth)
  Button(localization.ruvk).onTouch = function()
    openURL("m.vk.com/olejka_top4ik")
  end
  Button(localization.mweb).onTouch = function()
    openURL("olejka.pw")
  end
  Text(localization.atxt)
  Text("github.com/TheSainEyereg/WebDisplays-MineOS-App")
  Button(localization.gthb).onTouch = function()
    openURL("github.com/TheSainEyereg/WebDisplays-MineOS-App")
  end  
end )
---------------------------------------------------------------------------------

window.onResize = function(width, height)
  window.tabBar.width = width
  window.backgroundPanel.width = width
  window.backgroundPanel.height = height - window.tabBar.height
  layout.width = width
  layout.height = window.backgroundPanel.height
  window.tabBar:getItem(window.tabBar.selectedItem).onTouch()
end

window:resize(window.width, window.height)
