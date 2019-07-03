
*This post was original published on [Christian Mayer's Blog](https://blog.fox21.at/) on 2017-04-01 15:08:54 +0200.*

# Apache2 Restart

This post describes how to reconfigure and restart an [Apache](https://www.apache.org/) server in a secure way. *Secure* is relative. Of course there is always a chance that someting goes wrong. This approach limits the chances. Especially it's a good approach for changing an existing configuration you have not touched yet and to have no [downtime](https://en.wikipedia.org/wiki/Downtime).

This may also work for other [HTTP](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol) [daemons](https://en.wikipedia.org/wiki/Daemon_(computing)). It's not limited to Apache, but some commands are Apache specific.

1. Backup  
  Before you make any changes to the configuration make a backup of the current configuration. Maybe this step isn't required if the configuration files are already under a version control system (like [Git](https://en.wikipedia.org/wiki/Git)).
2. Config Test  
  This is also still before you make any changes. Run `apachectl configtest` to see if the current configuration works. It's an important step. Do not skip this. If you are not the only person who edits the Apache configuration this step protects you if it was faulty even before changing anything. Do not apply any of your things you need to change if this step fails.
3. Which Apache modules are installed?  
  Run `apachectl -M` and save the output of this command to your disk. It's good to know which modules are loaded before you apply a new configuration.
4. Check Status  
  Run `systemctl status apache2` to see infomrations about the current running Apache process. You maybe want to save this output to your local harddrive.
5. Reload  
  Still using the old configuration. Reload the Apache executing `systemctl reload apache2` to see if the old configuration is what is needed until this point. If the behavior of Apache has changed after the reload it means that someone in the past has made a change to the configuration but did not reload the Apache process.
6. Apply your changes.  
  This is the step where you actual touch the Apache configuration files. Until this step you did not touched anything. Apply your new changes to the configuration.
7. Config Test #2  
  Run `apachectl configtest` again to see if your changes made well. If not fix the configuration and run `apachectl configtest` again.
8. Reload #2  
  Run `systemctl reload apache2` to load your new configuration into the Apache process.
9. Check Status #2
  Run `systemctl status apache2` again to check if everything is OK.
10. Test  
  Check Apache from your browser to see if the changes has been applied successful.
