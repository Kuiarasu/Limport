
local type = type;
local package = package;
local ppload, pload = package.preload, package.loaded;

local cache_read, cache_stat;
local limport = {
    makeshift = {};
    data_packages = {};
};

--makeshift.getRequest
--makeshift.read

--[[
	local limport = require('Limport');
	limport.import(
		{
			directory = 'json.lua';
			cache = true;
			key = 'json';
		}
	);
	limport.import('json');

	Compatability checks go:
	Backup -> Luvit -> Luvi -> Love2D -> Lua 5.1+

	package.preload[key]() == package.loaded[key]

	Different import methods
	-> Luvit
	-> Luvi
	-> Love2D
	-> Lua 5.1+/io or package
	-> Makeshift GET Requests (HTTP/HTTPS)
	-> Makeshift read and stat
	-> Data Packaging
]]

local read = function(directory)

end;

--[[
	start of import
	get file directory
		identify as a url
	grab file object
		grab http/https file object
		grab data package
	get body of file
		get body of file object
		get body of data package
	create preload key
		strip based off file directory
		strip as data package
	register a generated loader function to preload by a preload key
	end of import

	
	the loader's closure will be sent into loaded by require with the assigned key
]]
local handleLiner = function(liner)
	--https://someurl.com/test.lua
	--json -> data package
	--we don't want to give them the ability to syntax .lua extensions because it causes problems directory wise
	local linerType = type(liner);
	local makeshift = limport.makeshift;
	if (linerType == 'string') then
		--package.loaded will only give us closures to the module
		--package.preload will only fill if a module needs to be set beforehand
		--using require on a file will immediately run the loader as if it came from package.preload
		--in this case, we need to somehow grab the loader, create a mirror environment and adjust package.path
		--recording the events of package.preload is a good idea, but that won't apply to modules that are not preloaded.
		--we might have to set the environment of require, and hope it transfers over to the module -> edit: it does not
		--seems impossible, but the purpose of limport.import is to provide clean syntax
		--before we're "importing", we'll have to add a key to package.preload
		--but the issue is, we don't know what paths require will check, which will be flexible
		--ideally we want require to pick out the correct path, then we need to take the loader

		--the below is intended to be localized into environments
		package.path = '.\\'..liner..'\\?.lua;.\\'..liner..'\\?\\init.lua;'..package.path;
	elseif (linerType == 'table') then

	end;
end;

local theory_require = function(dir)
	if (package.loaded[dir] ~= nil) then
		return package.loaded[dir];
	end;
	local paths = LUA_PATH or os.getenv('LUA_PATH') or package.path;
    local loader = package.preload[dir];
    local env = getfenv();
    if (loader ~= nil) then
        local closure = {setfenv(loader, env)(dir)}
        package.loaded[dir] = unpack(closure);
        return unpack(closure);
    end;
    local check_traceback = string.char(9).."no field package.preload['"..dir.."']";
	for path in string.gmatch(paths, '[^;]+') do
        local true_path = path:gsub('?', dir);
        local ran, result = pcall(function() 
            return assert(loadfile(true_path));
        end);
        if (ran == true) then
            local closure = {setfenv(result, env)(dir)}
            package.loaded[dir] = unpack(closure);
            return unpack(closure);
        end;
        check_traceback = check_traceback..'\n'..string.char(9).."no file '"..true_path.."'";
	end;
    error("module '"..dir.."' not found:\n"..check_traceback);
end;

limport.newDataPackage = function(key, body)
    assert(type(key) == 'string' and type(body) == 'string', 'Unhandled type');
    limport.data_packages[key] = body;
end;

limport.import = function(...)
    local parameters = {...};
    for i = 1, parameters do
		handleLiner(parameters[i]);
    end
end;


return limport;