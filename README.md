# Limport
"Limport" being short for lua import. Limport is a package that returns a function that will allow you to import files or directories as libraries regardless of the compiled require being able to support requiring supporting file and/or directory libraries.

## Why was this made?
The intention behind limport was to allow Luvi applications to require libraries might be directories, and for luvit to be able to require libraries that are in a project's base directory as simple as requiring lit installed libraries.

## Installation
You can install Limport using lit, `lit install Kuiarasu/Limport`. <br>
If you are using Luvi or any other independent compiler or related, you can download `init.lua` into your directory, maybe renaming it to `limport.lua`.

## Dependencies
Limport doesn't depend on any external libraries outside of luvit. <br>
However, internally 'luvi' (supplied by Luvi and Luvit) or 'fs' (supplied by Luvit) are the required libraries for limport.

## Usage
Using Limport is as easy as triggering a function, like so: <br>
``lua
  local import = require('limport');
  import('json', 'json.lua', 'deps/json', 'deps/json.lua');
  require('json');
  require('json.lua');
  require('deps/json');
  require('deps/json.lua');
`` <br>
In the example above, four variations can be used as inputs into Limport. <br>
You have the option not to supply a file extension in the first input, which will search for files in the same directory for the name + .lua extension. <br>
If the library is not a file, then you cannot add a file extension, so first and third inputs would be acceptable for directory libraries. <br>
You are also able to search into directories that are in the base directory of the program for modules also, also having the option to supply a file extension with the same rules applied. <br>

You would require the imported libraries using the compiled require, like in the example above. You do not need to supply the same full length input into require as you did into Limport. <br>
For instance, `import('json')` is usable through `require('json')` and `require('json.lua')`, and same rule applies if you used `import('json.lua')` instead. <br>
For directory search inputs, they are also the same with two extra inputs. For instance, `import('deps/json')` or `import('deps/json.lua')` is usable through `require('json')`, `require('json.lua')`, `require('deps/json')`, or `require('deps/json.lua')`.
