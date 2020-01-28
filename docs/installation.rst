.. _installation:

******************************
Installation and Configuration
******************************


In this section you will find step-by-step instructions for installing the CernVM-FS client software on your computer and to configure it to access the repository at ``/cvmfs/sw.lsst.eu``. To perform this one-time process **you need super-user privileges**.

After this process is successfully completed, an unprivileged user ``cvmfs`` is created in your computer and several configuration files are located under ``/etc/cvmfs``. In addition, some executable files are installed (e.g. ``cvmfs_config``, ``cvmfs_fsck``, ``cvmfs_talk``). The location of those executables depends on the operating system: on CentOS and Ubuntu they are located in ``/usr/bin`` and on macOS in ``/usr/local/bin``.

The installation and configuration steps for each target platform are presented below.

CentOS
======

Step 1: Install the CernVM-FS client software
---------------------------------------------

Add `CERN's RPM repository <https://cernvm.cern.ch/portal/filesystem/downloads>`_ to your computer:

.. code-block:: bash
 
    sudo yum install -q -y https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest.noarch.rpm
 
Install the CernVM-FS client:

.. code-block:: bash

    sudo yum install -q -y cvmfs
 
.. hint::
   **Manual installation on CentOS**: If you prefer not to add CERN's package repository to your computer or to choose a specific version of the software, you can directly download the desired version of the relevant package from the `CERN package repository <https://cernvm.cern.ch/portal/filesystem/downloads>`_ and manually install it using ``yum``.


Step 2: Configure the LSST repository
-------------------------------------

Install the configuration package for repository ``/cvmfs/sw.lsst.eu``:

.. code-block:: bash 

    sudo rpm -U https://github.com/airnandez/sw-lsst-eu/releases/download/v0.7/cvmfs-config-lsst-0.7-1.noarch.rpm

Complete the CernVM-FS client configuration:

.. code-block:: bash 

    sudo /usr/bin/cvmfs_config setup
    sudo service autofs restart


Step 3: Mount ``/cvmfs/sw.lsst.eu`` 
-----------------------------------

On CentOS, the CernVM-FS client uses ``autofs`` for automatically mounting the file system when required and to unmount it when it is no longer needed. We recommend you configure the ``autofs`` service to start at boot time. Here is one way to do that:

.. code-block:: bash 

    sudo systemctl enable --now autofs

You can now proceed to :ref:`testinginstallation`.

Ubuntu
======

Step 1: Install the CernVM-FS client software
---------------------------------------------

Add `CERN's APT repository <https://cernvm.cern.ch/portal/filesystem/downloads>`_ to your computer and install the CernVM-FS client:

.. code-block:: bash
 
    sudo apt-get install lsb-release
    curl -OL https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest_all.deb
    sudo dpkg -i cvmfs-release-latest_all.deb
    sudo apt-get update

Install the CernVM-FS client:

.. code-block:: bash
 
    sudo apt-get --yes install cvmfs

.. hint::
   **Manual installation on Ubuntu**: If you prefer not to add CERN's package repository to your computer or to choose a specific version of the software, you can directly download the desired version of the relevant package from the `CERN package repository <https://cernvm.cern.ch/portal/filesystem/downloads>`_ and manually install it using ``dpkg``.


Step 2: Configure the LSST repository
-------------------------------------

Install the configuration package for repository ``/cvmfs/sw.lsst.eu``:

.. code-block:: bash 

    curl -OL https://github.com/airnandez/sw-lsst-eu/releases/download/v0.7/cvmfs-config-lsst_0.7_all.deb
    sudo dpkg -i cvmfs-config-lsst_0.7_all.deb

Complete the CernVM-FS client configuration:

.. code-block:: bash 

    sudo /usr/bin/cvmfs_config setup
    sudo service autofs restart


Step 3: Mount ``/cvmfs/sw.lsst.eu`` 
-----------------------------------

On Ubuntu, the CernVM-FS client uses ``autofs`` for automatically mounting the file system when required and to unmount it when it is no longer needed. We recommend you configure the ``autofs`` service to start at boot time. Here is one way to do that:

.. code-block:: bash 

    sudo systemctl enable autofs.service

You can now proceed to :ref:`testinginstallation`.

macOS
=====

Step 1: Install the CernVM-FS client software
---------------------------------------------

**Step 1a**: Download and install the latest stable release of `FUSE for OS X <https://osxfuse.github.io>`_. This is a dependency of the CernVM-FS client.

**Step 1b**: Install the CernVM-FS client proper:

.. warning::

    The instructions below work on **macOS 10.13 or later** (i.e. High Sierra, Mojave and Catalina). If you are using an older version of macOS you may want to install an older version of the CernVM-FS client, for instance `cvmfs-2.5.0.pkg <https://ecsft.cern.ch/dist/cvmfs/cvmfs-2.5.0/cvmfs-2.5.0.pkg>`_.

.. code-block:: bash 

    curl -OL https://ecsft.cern.ch/dist/cvmfs/cvmfs-2.7.0/cvmfs-2.7.0.pkg
    open cvmfs-2.7.0.pkg

The last window of the install process of this package gives some instructions on how to configure the client for accessing a repository. Please ignore them as we will do the configuration in the next step.

.. important::

    **Please make sure you restart your computer after installing this package**. This is needed to make sure that the symbolic link ``/cvmfs`` is created and points to ``/Users/Shared/cvmfs``.


Step 2: Configure the LSST repository
-------------------------------------

Install the configuration package for repository ``/cvmfs/sw.lsst.eu``:

.. code-block:: bash 

    curl -OL https://github.com/airnandez/sw-lsst-eu/releases/download/v0.7/sw-lsst-eu-cvmfs-config_0.7.pkg
    open sw-lsst-eu-cvmfs-config_0.7.pkg

Complete the CernVM-FS client configuration:

.. code-block:: bash 

    sudo /usr/local/bin/cvmfs_config setup


Step 3: Mount ``/cvmfs/sw.lsst.eu`` 
-----------------------------------

Create the mount directory:

.. code-block:: bash 

    sudo mkdir -p /cvmfs/sw.lsst.eu

On macOS you need to manually mount and unmount the file system when needed. To mount the file system do:

.. code-block:: bash 

    sudo mount -t cvmfs sw.lsst.eu  /cvmfs/sw.lsst.eu

and to unmount it:

.. code-block:: bash

    sudo umount /cvmfs/sw.lsst.eu

.. _testinginstallation:

*************************
Testing your Installation
*************************

In the previous steps you installed the CernVM-FS client software and configured it to mount the LSST repository. At this point you can check your computer is correctly configured to access ``/cvmfs/sw.lsst.eu`` by doing:

.. code-block:: bash 

    ls /cvmfs/sw.lsst.eu

If you can see the contents of that directory your computer is correctly configured and you are ready to start using the LSST software. See :ref:`usage` for details.

.. important::

    Please note that on both Linux and macOS **you must mount the file system on the directory** ``/cvmfs/sw.lsst.eu`` because the LSST software is specifically built and packaged to be used under this path. The software won't work when relocated under another path.

You may also want to tell the cvmfs client running on your computer to probe all the configured servers and sort them by geographical proximity:

.. code-block:: bash

    sudo cvmfs_talk -i sw.lsst.eu host probe geo

To display how it ordered the servers do:

.. code-block:: bash

    sudo cvmfs_talk -i sw.lsst.eu host info


.. _troubleshooting:

*********************************
Troubleshooting your Installation
*********************************

In order for this distribution mechanism to work, your computer must be connected to the network, be able to establish network connections to the servers operated by CC-IN2P3 and replicated by other organisations (e.g. CERN) and download files via the HTTP protocol. To check that this is the case, please do:

.. code-block:: bash
 
        git clone https://github.com/airnandez/sw-lsst-eu
        cd sw-lsst-eu
        bash check.sh

You can tell everything is OK if there is no error message. Otherwise, the displayed error message may help you understanding what is wrong.

You may also want to check the status of the servers hosting the files of this software repository by visiting `CERN's replication monitor <http://cernvm-monitor.cern.ch/cvmfs-monitor/sw.lsst.eu/>`_.

If this does not help solving your issue, please see :ref:`help`.

