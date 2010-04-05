# core - Drupal core. A core is a basic Drupal without the additional modules. 
#        Modules shipped with core, come as one package, with one releasenumber.
#        Core modules can be disabled, but not removed. Same for core themes.
#        Core comes with additional libraries, CSS and images. 
# Author: "Bèr Kessels" berkes <ber@webschuur.com>
# Copyright:: (C) 2010
# License:: GPL
# Drupal core

class Core

  # Drupal core version. Getter only. Can only be changed by up- or downgrading
  attr_accessor :version
  public :version

  # Run a Drupal upgrade steps up one version at a time.
  # Creates an additional snapshot (backup) for downgrade or restore
  # * access public 
  def upgrade
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

  # Drupal does not support downgrade, so effectively this is setting back the 
  #  last snapshot made during upgrade.
  def downgrade
    raise NotImplementedError, 'This is auto-gen. method, please implement.'
  end

  private
    # Download a Drupal core from drupal.org
    def download
      raise NotImplementedError, 'This is auto-gen. method, please implement.'
    end

    # Unzip/-tar the last tarball
    def unpack
      raise NotImplementedError, 'This is auto-gen. method, please implement.'
    end
    
    # create a snapshot of a Drupal core: zip core (without /sites contents!)
    def create_snapshot
      NotImplementedError, 'This is auto-gen. method, please implement.'
    end
end

