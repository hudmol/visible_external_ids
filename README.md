# visible_external_ids
An ArchivesSpace plugin that adds the ability to view external ids in Archival Object readonly and form views

## How to install it

To install, just activate the plugin in your config/config.rb file by
including an entry such as:

     # If you have other plugins loaded, just add 'visible_external_ids' to
     # the list
     AppConfig[:plugins] = ['local', 'other_plugins', 'visible_external_ids']

And then clone the `visible_external_ids` repository into your
ArchivesSpace plugins directory.  For example:

     cd /path/to/your/archivesspace/plugins
     git clone https://github.com/hudmol/visible_external_ids.git
