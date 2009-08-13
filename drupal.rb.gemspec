Gem::Specification.new do |s|
  s.name     = "drupal.rb"
  s.version  = "0.0.9"
  s.date     = "2008-10-16"
  s.summary  = "Drupal development kit"
  s.email    = "ber@webschuur.com"
  s.homepage = "http://berkes.github.com/drupal.rb/"
  s.description = "Drupal is an open source Ruby development tool allowing developers to quickly generate and manage Drupal modules."
  s.has_rdoc = true
  s.require_path = "lib"
  s.authors  = ["tj@vision-media.ca", "ber@webschuur.com"]
  s.files    = ["History.txt", 
		"Manifest.txt", 
		"README.txt", 
		"Rakefile", 
		"drupal.rb.gemspec", 
		"lib/drupal.rb", 
		"lib/drupal/create_module.rb", 
		"lib/drupal/todo_list.rb", 
		"lib/drupal/install.rb", 
		"lib/drupal/templates/6.x/comments/file", 
		"lib/drupal/templates/6.x/comments/large", 
		"lib/drupal/templates/6.x/hooks/block", 
		"lib/drupal/templates/6.x/hooks/boot", 
		"lib/drupal/templates/6.x/hooks/install", 
		"lib/drupal/templates/6.x/hooks/cron", 
		"lib/drupal/templates/6.x/hooks/form_alter", 
		"lib/drupal/templates/6.x/hooks/init", 
		"lib/drupal/templates/6.x/hooks/menu", 
		"lib/drupal/templates/6.x/hooks/perm", 
		"lib/drupal/templates/6.x/hooks/schema", 
		"lib/drupal/templates/6.x/hooks/theme", 
		"lib/drupal/templates/6.x/txt/changelog", 
		"lib/drupal/templates/6.x/txt/readme",
		"lib/drupal/templates/6.x/base/info",
		
		"lib/drupal/templates/5.x/comments/file", 
		"lib/drupal/templates/5.x/comments/large", 
		"lib/drupal/templates/5.x/hooks/block", 
		"lib/drupal/templates/5.x/hooks/install", 
		"lib/drupal/templates/5.x/hooks/cron", 
		"lib/drupal/templates/5.x/hooks/form_alter", 
		"lib/drupal/templates/5.x/hooks/init", 
		"lib/drupal/templates/5.x/hooks/menu", 
		"lib/drupal/templates/5.x/hooks/perm",
		"lib/drupal/templates/5.x/txt/changelog", 
		"lib/drupal/templates/5.x/txt/readme",
		"lib/drupal/templates/5.x/base/info",
		
		"bin/drupal"]
	s.executables = ["drupal"]
  s.test_files = ["test/test_drupal.rb", "test/test_install.rb", "test/test_create_module.rb", "test/test_todo_list.rb"]
  s.rdoc_options = ["--main", "README.txt"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
end
