# Site - Drupal has a multisite concept. One codebase can deliver more then one site.
#   Drupal.rb thinks this is usefull *only* for staging. Running two different
#   websites (dog-collection and cat-collecition) means makeing two new Projects. See Project class.
#   a site has one database. 
#   a site has many available modules (core + addons).
#   trough the database (where module statii are recorded, ugh) these modules 
#   are enabled and disabled. 
#   most site-details, however, are found in a file settings.php in a specially named directory. 
#   more on this feature: http://drupal.org/getting-started/6/install/multi-site
# Author: "Bèr Kessels" berkes <ber@webschuur.com>
# Copyright: (C) 2010
# License: GPL
# Site

class Site

  # The url, including http(s)  where the site is accessible.
  attr_accessor :url
  public :url

  # Database object.  
  attr_accessor :database
  public :database

  # list of available modules in this site 
  attr :modules-available
  protected :modules-available

  # Put site in offline status: shows a message to users in Drupals maintenance_page.
  def set_offline
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

  # Put site back in online status.
  def set_online
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

  # Set a certain variable for this site only: variable will be set in settings.php, not database.
  def set_variable(name, value)
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

  # Get the value of any variable from Drupals variable-pool.
  # more on this pool: http://api.drupal.org/api/function/variable_get
  def get_variable (name)
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

  # Remove a variable from either settings.php and/or from the database variable pool.
  def del_variable
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end
  public :del_variable

  # Upgrade an entire site. Runs update on the core and all available modules.
  # Note: since one core may be shared over more sites, this may break other 
  #  sites. Use the projects update method instead (which will run this method).
  # Makes a snapshot and a database dump of this site.
  def upgrade
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

  # downgrade an entire site, the core, codebase and put back an old database.
  def downgrade
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

end



