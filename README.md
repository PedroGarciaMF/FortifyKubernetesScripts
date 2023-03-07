# Fortify Kubernetes Scripts

To create your Kubernetes Cluster for Fortify on a bare metal machine running Windows let’s start by:
1)	Install VMWare Workstation if you don’t already have it installed.
2)	Install Vagrant using the '''setup-host.ps1''' PowerShell script, if you don’t already have it installed.  
3)	Clone this repo to where you want Vagrant to create the .vagrant folder with the Virtual Machines.
4)	Run the '''vagrant up''' command in that folder.
    a.	Vagrant will create 3 Virtual Machines under .vagrant\machines
5)	User '''vagrant ssh srv-master''' to access the master node and proceed with the manual configuration.
    a.	When prompted for password just type '''vagrant'''.
6)	Add the worker nodes to the hosts file
'''
192.168.50.11   srv-worker-1
192.168.50.12   srv-worker-2
'''
'''sudo vim /etc/hosts'''
7)	User '''vagrant ssh srv-worker-1'''’ on a separate terminal to access the first worker node and proceed with the manual configuration.
    a.	When prompted for password just type '''vagrant'''.
8)	User vagrant '''ssh srv-worker-2''' on a separate terminal to access the second worker node and proceed with the manual configuration.
    a.	When prompted for password just type '''vagrant'''.
9)	On the master node, execute the following command to create a token for the worker node.
'''microk8s.add-node | grep 192.168.50.10'''
10)	Copy the command line and append ''' --worker''' to its end and execute it on the worker node.
11)	Repeat the steps to create a token and to join a node into the cluster on the second worker node.
