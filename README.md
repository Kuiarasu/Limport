# Limport
"Limport" short for lua import, is a small library that will allows you to import files or directories as lua libraries across different engines and platforms.

## Why was this made?
Originally, limport was created to provide clean execution and adjustments for `require` on [Luvi](https://github.com/luvit/luvi) applications and [Luvit](https://github.com/luvit/luvit) projects. <br><br>

```lua
local limport = require('Limport');
limport.import(
	{
		directory = 'json.lua';
		cache = true;
		key = 'json';
	}
);
limport.import('json');
```

## Installation
You can install Limport using lit, `lit install Kuiarasu/Limport`. <br>
If your engine doesn't support lit, you may use `require` on the converted/non-converted version of the directory or `init.lua`, in which case you may rename `init.lua` to `limport.lua`

## Dependencies
Limport requires functionality to access and read files, alternatively if the engine supports GET requests, if `Limport.makeshift.getRequest(string url, bool cache)` is set, it will be used to require the package that way.

## Usage
Versions of Limport before 0.0.6 can be utilized by just a function, such as: <br>
```lua
local import = require('Limport');
import('json', 'json.lua', 'deps/json', 'deps/json.lua');
  
require('json');
require('json.lua');
require('deps/json');
require('deps/json.lua');
```

Limport Version 0.0.6+ will present itself as a library. <br>
`Limport.import(...)` is used to import packages as modules. <br>
```lua
local limport = require('Limport');
local import = limport.import;
import('json', {
	directory = 'json.lua';
	cache = true;
	key = 'json';
});
require('json');
```
You may import as many libraries at once by supplying more parameters into `Limport.import(...)`, which can either be a string or a table.<br>
String parameters will be interpreted as an in-project directory or external directory and as the preload/load keys for `require`. Preload/load key can either include or not include full directories with or without full `.lua` or other extensions. <br>

Table parameters will split data and customization for each package, which will take into account the true directory to the package via `directory`, whether the package will be cached after being preloaded `cache`, and the preload/load `key` for `require`.

## Compatability
[Luvit](https://github.com/luvit/luvit), [Luvi](https://github.com/luvit/luvi) and [Love2D](https://github.com/love2d/love) compatabilities are built into Limport. <br>
* If the engine has the full Lua 5.1+ API or with `io` and `package` APIs being supported, Limport will also work there too. <br>
* If the engine does not meet the requirements above, Limport can import packages via GET requests if `Limport.makeshift.getRequest(string url, bool cache)` is defined manually. Makeshift will need the body as the first return.<br>
* If all the above is not supported, Limport also supports utilizing makeshift functions to help with compatability problems, such as <br>
`Limport.makeshift.read(string fullDirectory)` for reading files, body is expected as first return.<br>
`Limport.makeshift.stat(string fullDirectory)` to identify as a file or directory. If not defined, Limport will make utilize it's own makeshift version using `Limport.makeshift.read`, table {string type "directory" or "file"} or string "file or "directory" is expected as first return.<br>
* Additionally, you may import packages by supplying source code. You will have to create an internal key using `Limport.newDataPackage(string key, string body)`.
