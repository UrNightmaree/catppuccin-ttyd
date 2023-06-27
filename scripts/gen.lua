#!/usr/bin/env lua
local cp = require("catppuccin")
local pretty_encode = require("resty.prettycjson") -- luarocks install lua-resty-prettycjson

if not cp[arg[1]] then
    io.stderr:write(("error: invalid flavor at arg #1: '%s'\n"):format(arg[1] or ""))
    os.exit(1)
end

local flavor = {}
for k, v in pairs(cp[arg[1]]()) do
    flavor[k] = v.hex
end

local is_latte = arg[1] == "latte"

local theme_json = {
    foreground = flavor.text,
    background = flavor.base,

    cursor       = flavor.text,
    cursorAccent = flavor.text,

    selectionBackground         = flavor.surface0,
    selectionInactiveBackground = flavor.surface1,

    black         = is_latte and flavor.subtext1 or flavor.surface1,
    brightBlack   = is_latte and flavor.subtext0 or flavor.surface2,
    red           = flavor.red,
    brightRed     = flavor.red,
    green         = flavor.green,
    brightGreen   = flavor.green,
    yellow        = flavor.yellow,
    brightYellow  = flavor.yellow,
    magenta       = flavor.pink,
    brightMagenta = flavor.pink,
    cyan          = flavor.teal,
    brightCyan    = flavor.teal,
    white         = is_latte and flavor.surface2 or flavor.subtext1,
    brightWhite   = is_latte and flavor.surface1 or flavor.subtext0,

    extendedAnsi = { flavor.peach, flavor.rosewater }
}

local f = assert(io.open("src/"..arg[1]..".json", "w+"))
f:write(pretty_encode(theme_json, nil, (" "):rep(4)))
f:close()
