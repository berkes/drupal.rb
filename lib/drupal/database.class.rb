# Database - Each Drupalsite has a database. Possibly with shared tables. 
#   Note on Prefixes: not yet supported!
#   In Drupal a database can have table-prefixes, acting as vritual databases,
#   but fysically in one database. Prefixes can also be used to share tables 
#   amoungst other tables. This is not supported (yet).
# Author: "Bèr Kessels" berkes <ber@webschuur.com>
# Copyright:: (C) 2010
# License:: GPL
# Database

class Database
  # Database name 
  attr_accessor :name
  public :name

  # Database user 
  attr_acessor :user
  public :user

  # Database password (if any). Empty string if none given 
  attr_acessor :pass
  public :pass

  # Database server (hostname) 
  attr_acessor :host
  public :host

  # Make a new connection, using abovementioned credentials and details.
  def connect
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

  # Disconnect the connection created in connect method
  def disconnect
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

end



