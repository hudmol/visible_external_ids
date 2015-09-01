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

## v1.3+ Compatibility
In developing this feature as a plugin, due to the numerous template overrides required
it became clear this feature would be a better fit as a core change to minimise future 
maintenance and potential code conflicts.

We've delivered a pull-request to the core team which will deliver the same behaviours 
but in a more sustainable way - https://github.com/archivesspace/archivesspace/pull/258.  

If these changes are accepted and released, this plugin will no longer be required (beware
an exception  has been added to notify you when this time has come).  To migrate to the 
new behaviour, first remove `visible_external_ids` from `AppConfig[:plugins]` and then set 
`AppConfig[:show_external_ids] = true`. 
