# Project - Not Drupal-specific. A project consists of a core, with one or many sites. 
#  A project is located somewhere on disk and is a git working directory. 
#  A project has DTAP, development, testing acceptance and production environments. 
#   stages may be rolled into one: e.g. testing and acceptance may be one site, server and codebase.
#  @TODO: write documentation on staging handling: code versus database: both are moved/im-exported differently.
# Author: "Bèr Kessels" berkes <ber@webschuur.com>
# Copyright: (C) 2010
# License: GPL
# Database

class Project
  # auto increment numeric id for a project. 
  private :id

  # Human readable project identifier. Often an acronym of the name.
  attr_acessor :project_code
  public :project_code

  # Location of project on your disc. expects POSIX filenames. 
  attr_acessor :location
  public :location

  # Human readable proejctname, may be identical for the project_code.
  attr_acessor :name
  public :name

  # If hosted on github, the github projectname. Leave blank to disable.
  attr_acessor :github
  public :github

  # Creates a new project, initialises it and turns it into a git working directory.
  #  TODO: redesign this, so it can handle directories that already contain code.
  # * param  code projectcode.
  # * param  name project name.
  # * param  location project location on disc.
  def create( code, name, location )
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

  # Remove the project. (entirely, be carefull!)
  # * param  code the projectcode to use.
  def delete( code )
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

  # Stage project up one level. E.g. a 'test' will go into acceptance.
  def stage_up
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

  # Stage project down one level. E.g. a 'test' will go into 'dev'.
  def stage_down
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

end



