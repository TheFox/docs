# Connect from macOS to remote Linux server. For example to Debian or Ubuntu.

# Prepare remote server.
# Enable X11 Forwarding in SSH.
vim /etc/ssh/sshd_config
#X11Forwarding yes
#X11DisplayOffset 10
#X11UseLocalhost no
systemctl restart sshd

# Start XQuartz under macOS.
# "Allow connections form network clients" must be enabled.
# Then run
xhost +

# Prepare local SSH config under macOS.
which xauth # Save that path for later.

vim ~/.ssh/config
#Host *
#	XAuthLocation /opt/X11/bin/xauth # this is the path from `which xauth`.
#	ForwardAgent yes
#	ForwardX11 yes

# Connect to server using
ssh -Y user1@server
echo $DISPLAY # should not be empty

# If it's still empty maybe you need to install xauth
# on the remote server as well:
sudo apt-get install xauth

# If you later switch to root, use the X11 connection from the SSH user:
xauth add $(xauth -f ~user1/.Xauthority list | tail -1)

# Now you can install GNOME Vim:
apt-get install vim-gtk3
gvim /tmp/hello.txt

# To test X11 Forwarding install X11 App
apt-get install x11-apps

# and run xeyes
xeyes &

# Some programms like 'gnome-system-monitor' need additional packages:
apt-get install dconf-editor dbus-x11
