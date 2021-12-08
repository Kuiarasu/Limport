
--Limport Debug Testing
--[[
    Attach automatic pathing for required modules
        We can do this by adjusting the loader's environment and changing package.path locally

    For language interoperability, we can use metatables
]]
package.path = '.\\?\\init.lua;'..package.path;

local mirror = {};
for i, v in next, getfenv() do
    mirror[i] = v;
end;
setmetatable(mirror, {
    __index = function(self, index)
        if (index == 'TEST') then return 5; end; return getfenv()[index];
    end;
    __newindex = function(self, index, value)
        getfenv()[index] = value;
    end;
})
print('test mirror', mirror.TEST);
local f = function()
    print('F', TEST);
end;
setfenv(f, mirror)();

print(require'jsone');
print(package.loaded.jsone);

