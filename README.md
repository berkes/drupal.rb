# drupal.rb

[![](http://stillmaintained.com/berkes/drupal.rb.png)](http://stillmaintained.com/berkes/drupal.rb)

http://berkes.github.com/drupal.rb/

## DESCRIPTION:

Drupal is an open source Ruby development tool allowing developers 
to quickly generate and manage Drupal modules.

## SYNOPSIS:

	drupal [options] [arguments]

## REQUIREMENTS:

	none

## ARGUMENTS:

	create module <module_name>   		Generates a module skeleton from an interactive wizard.
	todo list [total]    				  		Displays list of todo items or a total.
	install <core | project> [dir] [5.x|6.x|7.x]
                                       Install a Drupal project or core itself to [dir] (defaults to curent dir) for version (defaults to 6.x)

## OPTIONS:

 	-h, --help       Display this help information.
 	-V, --version    Display version of the Drupal development tool.

## EXAMPLES:

  Create a new module in the current directory.
    drupal create module my_module

  Create a new module in a specific directory.
     drupal create module my_module ./sites/all/modules

  View todo list for current directory.
     drupal todo list

  View todo list for multiple files or directories.
     drupal todo list ./sites/all/modules/mymodule 

  View total todo items only.
     drupal todo list total ./sites/all/modules

  Install drupal core to the current directory.
     drupal install core

  Install a 5.x module when in the 'modules directory
     drupal install devel . 5.x

  Install a module to the modules folder in my new installation (from drupal root)
     drupal install devel ./sites/all/modules
    
  Install a module when in the 'modules directory
     drupal install devel

## LOCAL TEMPLATES

  Create .drupal.rb/templates/ directories in your home-directory and put your
  own templates there. Drupal.rb will pick these, instead of the global ones.

  e.g. $ mkdir ~/.drupal.rb/
       $ cp -r /path/to/gems/berkes-drupal.rb-0.0.7/var/lib/drupal/templates/ \
         ~/.drupal.rb/templates/
         
## DEFAULTS
  Create a file in ~/.drupal.rb/ named defaults.yml. The variables in there will
  be used as defaults on the prompt when creating a module.
  Alternatively you can copy the example from the doc dir in the package. 

## AUTHOR:

Original:
  TJ Holowaychuk 
  tj@vision-media.ca
  http://vision-media.ca

Current Maintainer:
  Bèr Kessels
  ber@webschuur.com 
  http://webschuur.com

## LICENSE:

(The MIT License)

Copyright (c) 2008 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
