---
layout: post
date: 
title: 
description: A HOWTO for installing MariaDB and TokuDB.
language: en
categories: [Productivity]
tags: [MySQL, SQL, DB, Database, MariaDB, TokuDB, HOWTO, Tutorial, Debian, Linux, Maria, Maria DB, Toku, Toku DB]
---

*This post was original published on [Christian Mayer's Blog](https://blog.fox21.at/) on 2013-07-26 21:03:00 +0200.*

# Install MariaDB and TokuDB

1. Follow the steps at [https://downloads.mariadb.org/mariadb/repositories/](https://downloads.mariadb.org/mariadb/repositories/) (Debian >> Debian 7 >> 5.5 >> NetCologne)[1].
	
	```
	$ apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
	$ apt-get update
	$ apt-get install mariadb-server
	$ /etc/init.d/mysql stop
	```
	
	In the `apt-get install` step you will be prompted for a root password. After the installation you must stop the MariaDB server.

2. Make a copy of the original `my.cnf`.
	
	```
	$ cp /etc/mysql/my.cnf /etc/mysql/my.cnf_ORG
	```

3. Change the bind-address[2] in `/etc/mysql/my.cnf`.
	
	From
	
	```
	bind-address = 127.0.0.1
	```
	
	to
	
	```
	bind-address = 0.0.0.0
	```

4. Change the basedir[3] in `/etc/mysql/my.cnf`.
	
	From
	
	```
	basedir = /usr
	```
	
	to
	
	```
	basedir = /opt/mysql
	```
	
	Because I would like to install TokuDB under `/opt/mysql`.

5. Download [TokuDB 7.0.1 for MariaDB 5.5.30][tdbdl]. After downloading extract the `.tar.gz` file to `/opt`.
	
	```
	$ cd /opt
	$ tar -vxzf mariadb-5.5.30-tokudb-7.0.1-linux-x86_64.tar.gz
	$ ln -s mariadb-5.5.30-tokudb-7.0.1-linux-x86_64 mysql
	$ cd mysql
	$ chown -R mysql:mysql .
	```
	
	So now you have `/opt/mysql` as your `basedir`.

6. Install TokuDB.
	
	```
	$ scripts/mysql_install_db --user=mysql --defaults-file=/etc/mysql/my.cnf
	```

7. Replace the MariaDB files.
	
	```
	$ mv /etc/init.d/mysql /etc/init.d/mysql_ORG
	$ mv /usr/bin/mysql /usr/bin/mysql_ORG
	$ mv /usr/bin/mysqladmin /usr/bin/mysqladmin_ORG
	$ mv /usr/bin/mysqldump /usr/bin/mysqldump_ORG
	$ ln -s ../../opt/mysql/support-files/mysql.server /etc/init.d/mysql
	$ ln -s ../../opt/mysql/bin/mysql /usr/bin/mysql
	$ ln -s ../../opt/mysql/bin/mysqladmin /usr/bin/mysqladmin
	$ ln -s ../../opt/mysql/bin/mysqldump /usr/bin/mysqldump
	```

8. Start the MariaDB server and check if TokuDB is installed.
	
	```
	$/etc/init.d/mysql start
	$ mysql -u root -pYOUR_ROOT_PASSWORD
	```
	
	Now you can show the plugins:
	
	```sql
	show plugins;
	```
	
	There must be TokuDB entries like these:
	
	```
	TokuDB
	TokuDB_user_data
	TokuDB_user_data_exact
	TokuDB_file_map
	TokuDB_fractal_tree_info
	TokuDB_fractal_tree_block_map
	```

### Footnotes

- [1] In the TokuDB 7.0.3 for [MariaDB](https://mariadb.org/) 5.5.30 section from the [TokuDB download page][tdbdl] you also find a [Quick Start Guide](http://www.tokutek.com/download.php?download_file=QuickStartGuide-7.0.3.pdf).
- [2] You don't need to change the bind IP address if you use the server local.
- [3] You don't have to set the basedir to `/opt/mysql`. In the Tokutek quick start guide they recommend to set the basedir to `/opt/tokutek/mysql`. I decided to use `/opt/mysql`.

[tdbdl]: http://www.tokutek.com/resources/support/gadownloads/
