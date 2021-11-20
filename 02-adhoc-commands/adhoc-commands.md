##** Ad-hoc Commands**
=======================

- An Ad-Hoc command is a one-liner ansible command that performs one task on
the target host(s)/group(s).

-Unlike playbooks — which consist of collections of tasks that can be reused — ad hoc commands are tasks that you don’t perform frequently, such as restarting a service or retrieving information about the remote systems that Ansible manages.

- This command will only have two parameters,
        the group of a host that you want to perform the task and
        the Ansible module to run.

# Module:
These are small programs that do some work on the server. They are the main building blocks
of Ansible and are basically reusable scripts that are used by Ansible Ad-hoc and playbooks.
Ansible comes with a number of reusable modules.

- The basic syntax of an Ad-hoc command is

#   $ ansible [ -i inventory_file ] <server1:server2:Group1:Group2> -m <module> [-a arguments]

- List all available modules:
# $ ansible-doc -l



**Examples of adhoc commands**

$ ansible all -m ping          :  => ping module

$ ansible all -a "cat /etc/passwd"     #=> command module/ default - does not work with |,>,<,&
$ ansible all -a "cat /etc/passwd | tail -3" : => will fail

$ ansible all -m shell -a "cat /etc/passwd | tail -3" :  => shell module

$ ansible db -m copy -a 'src=/source/file/path dest=/dest/location'
$ ansible db -m copy -a 'src=/source/file/path  dest=/dest/location remote_src = yes'

$ ansible all -m debug -a 'var=inventory_hostname' # debug module
$ ansible all -m debug -a 'msg={{inventory_hostname}}'
