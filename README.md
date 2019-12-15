# vagrant-lamp

A LAMP (Linux, Apache, MySQL, PHP) stack running in a virtual machine created by Vagrant. Includes a fresh WordPress install in the `var/www/html` folder on the guest machine.

## Prerequisites

To use this VM, you must have the following software installed:
- [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads.html)

Below are instructions on how to use this virtual machine.  The first option includes instructions on how to use it without WordPress.  The latter is instructions on how to use it with WordPress.

## Usage (without WordPress)

If you just want the LAMP stack without WordPress, follow these instructions:

1. Edit the `bootstrap.sh` file, removing the WordPress installation.
2. Create a `www` folder in the project directory (same directory as the `Vagrantfile`).  This folder will be synched up with the virtual machine and it is the root directory of the web server.
3. Boot up the virtual machine:

```
$ vagrant up
```

4. Navigate `http://192.168.50.4/` in your browser.

## Usage (with WordPress)

1. Create a `www` folder in the project directory (same directory as the `Vagrantfile`).  This folder will be synched up with the virtual machine and it is the root directory of the web server.

2. Boot up the virtual machine:

```
$ vagrant up
```

3. SSH into the virtual machine:

```
$ vagrant ssh
```

4. Login to MySQL:

```
$ sudo mysql -u root -p
```

When prompted to enter the password, type: `root`.

5. Create the MySQL table for WordPress:

```
mysql> create database wordpress;
```

Verify the creation of the database:

```
mysql> show databases;
```

6. Exit MySQL:

```
mysql> exit
```

7. Exit the virtual machine:

```
$ exit
```

8. Navigate `http://192.168.50.4/` in your browser.

## Teardown

When you are done with the virtual machine, you need to perform a teardown.  See the various types of teardowns [here](https://www.vagrantup.com/intro/getting-started/teardown.html).