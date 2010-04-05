# Module - A Drupal module is a single entity consisting of a .info, .module and
#   associated code files.    
#   Note on Packages: not yet supported!
#   In Drupal a downloadable project can contain many modules. This class (for now)
#   only supports enabling and disabling single modules. Downloading will be 
#   implemented in the package class.
# Author: "Bèr Kessels" berkes <ber@webschuur.com>
# Copyright: (C) 2010
# License: GPL
# Module


class Module
  # The modules namespace, also known as 'modulename'. The system name.
  attr_acessor :namespace
  public :namespace

  # The human readable modulename. 
  attr_acessor :name
  public :name

  # The human readable module description-string. May contain HTML.
  attr_acessor :description
  public :description

  # The module (package!) version.
  attr_acessor :version
  public :version

  # Enable a single module. Modulefile must be available.
  def enable
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

  # Disable a module. Uninstall and remove routines in a module (if any) will
  #  not be ran. Use uninstall for this.
  def disable
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end
  public :disable

  # Alias for enable. Provided for balance with uninstall.
  def install
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end
  public :install

  # remove or delete entirely. Fires the uninstall routines (if any). May 
  #  unrecoverably delete (module specific) content from your database!
  def uninstall
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

  # Upgrade module one step up. Fetches new version module, then runs db upgrades
  def upgrade
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

  # Set back a snapshot of a previous version of a module.
  def downgrade
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

 private
  # Runs a database-upgrade for a module. 
  def upgrade_database
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

  # Runs a database-upgrade for a module.  
  def downgrade_database
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end
  
  # Create a snapshot of the code (NOT DATABASE) of a module.
  def snapshot
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end
end



