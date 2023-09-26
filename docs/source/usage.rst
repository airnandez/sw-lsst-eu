.. _usage:

*************************************************
Usage of the Software under ``/cvmfs/sw.lsst.eu``
*************************************************

Once the CernVM-FS client is installed and configured in your computer, a one-time process (see :ref:`installation`), you can start using the LSST software.

In this section you will find information on how to use the online LSST software repository. It appears in your computer **in read-only** mode under the path ``/cvmfs/sw.lsst.eu``. Super-user privileges are not required to access the files there in.

Repository Layout
=================

The namespace under ``/cvmfs/sw.lsst.eu`` is meant to be self-explanatory. There you will find a sub-directory per supported platform (i.e. ``darwin-x86_64``, ``darwin-arm64``, ``linux-x86_64``, etc.), a subdirectory for each distribution (e.g. ``lsst_distrib``, ``lsst_sims``).
The repository looks like:

.. code-block:: bash

    $ tree -L 2 -F /cvmfs/sw.lsst.eu
    /cvmfs/sw.lsst.eu
    ├── containers/
    │   └── apptainer/
    ├── darwin-arm64/
    │   └── lsst_distrib/
    ├── darwin-x86_64/
    │   ├── lsst_distrib/
    │   └── lsst_sims/
    └── linux-x86_64/
        ├── apptainer/
        ├── lsst_distrib/
        ├── lsst_sims/
        └── panda_env/

The LSST Science Pipelines are distributed by this mechanism in two forms: as a ``conda`` based environment (for both Linux and macOS) and as an `Apptainer <https://apptainer.org/docs/user/latest/>`_ container image (for Linux only).
The ``conda`` based distribution is located under the subdirectory ``lsst_distrib`` of each platform directory:

.. code-block:: bash

    $ tree -L 1 -F /cvmfs/sw.lsst.eu/linux-x86_64/lsst_distrib
    /cvmfs/sw.lsst.eu/linux-x86_64/lsst_distrib
    ...
    ├── v24.0.0/
    ├── v24.1.0/
    ├── v25.0.0/
    ├── v25.0.1/
    ...
    ├── w_2023_35/
    ├── w_2023_36/
    ├── w_2023_37/
    └── w_2023_38/

and the Apptainer-based distribution is located under ``/cvmfs/sw.lsst.eu/containers/apptainer``:

.. code-block:: bash

    $ tree -L 1 -F /cvmfs/sw.lsst.eu/containers/apptainer/lsst_distrib/
    /cvmfs/sw.lsst.eu/containers/apptainer/lsst_distrib/
    ...
    ├── v24.0.0.sif
    ├── v24.1.0.sif
    ├── v25.0.0.sif
    ├── v25.0.1.sif
    ...
    ├── w_2023_35.sif
    ├── w_2023_36.sif
    ├── w_2023_37.sif
    └── w_2023_38.sif

Files or directories which contain **weekly releases** start with letter "w" (e.g. ``w_2023_38``) or "sims_w" (e.g. ``sims_w_2018_49``).  **Stable releases** of ``lsst_distrib`` start with letter "v" (e.g. ``v25.0.1``) and stable releases of ``lsst_sims`` are named like ``sims_2_13_1``. ``lsst_distrib`` is the name of the LSST distribution, that is, a coherent set of packages that together form the LSST science pipelines. Each release of the software is built from sources, specifically for delivery via CernVM-FS according to the `official instructions <https://pipelines.lsst.io>`_.

Each release of the software you will find under ``/cvmfs/sw.lsst.eu``, be it stable or weekly, is mostly self contained: it includes its own EUPS (see below), its own **Python 3** distribution (typically `miniconda <https://www.anaconda.com/download>`_) and its own set of external packages that specific release depends on (e.g. ``numpy``, ``cfitsio``, etc.). In particular, since the Python distribution installed with each release includes its own interpreter, each release is independent and configured so **it does not conflict with other Python interpreter** you may have already installed on your computer.

.. important::

   The LSST science pipelines depend, among other things, on the Python interpreter and runtime libraries of the C++ compiler, which are both included in recent stable and weekly releases. You can find the details of the Python interpreter and C++ compiler a particular
   release of the LSST software was built with in the file ``README.txt`` in each release's top directory. For instance:

   .. code-block:: text

        $ cat /cvmfs/sw.lsst.eu/linux-x86_64/lsst_distrib/w_2023_28/README.txt
        LSST Software
        -------------

        Product(s):          lsst_distrib
        Tag:                 w_2023_28
        Build time:          2023-07-13 19:05:00 UTC
        Build platform:      CentOS Linux release 7.9.2009 (Core) Linux 3.10.0-1127.19.1.el7.x86_64 #1 SMP Tue Aug 25 17:23:54 UTC 2020 x86_64 x86_64
        conda:               conda 23.1.0
        mamba:               mamba 1.4.2
        conda environment:   lsst-scipipe-7.0.0-exact
        Python interpreter:  Python 3.11.4
        C++ compiler:        c++ (conda-forge gcc 11.4.0-0) 11.4.0
        Documentation:       https://sw.lsst.eu


Basic Usage of the conda-based Distribution
===========================================

The first step for using the LSST science pipelines is to select the release you want to use and bootstrap your environment for that specific release. For instance, to use LSST ``v25.0.1`` on a Linux computer do:

.. code-block:: bash

    # Open a new terminal session using a BASH shell
    $ source /cvmfs/sw.lsst.eu/linux-x86_64/lsst_distrib/v25.0.1/loadLSST.bash
    $ setup lsst_distrib

As a result of executing these commands, some environmental variables are extended or initialized, such as ``PATH``, ``PYTHONPATH``, ``LD_LIBRARY_PATH`` and ``EUPS_PATH``. In particular, your ``PATH`` is extended to find the Python interpreter and other commands included in the pipelines, for instance:

.. code-block:: bash

    $ which python
    /cvmfs/sw.lsst.eu/linux-x86_64/lsst_distrib/v25.0.1/conda/envs/lsst-scipipe-5.0.1-exact/bin/python

    $ pipetask --help
    Usage: pipetask [OPTIONS] COMMAND [ARGS]...
    ...

and your ``PYTHONPATH`` is configured to find the included Python packages you may need in your scripts (e.g. ``import lsst.daf.butler``).

The LSST software uses `EUPS <https://github.com/RobertLuptonTheGood/eups>`_ for managing the set of software products which are part of a given release. EUPS allows you to select the packages you want to use in a work session. For instance, to use the command line tasks for processing CFHT images, you would do:

.. code-block:: bash

    $ setup obs_cfht
    $ setup pipe_tasks

If later on you need to work with a different release, say weekly ``w_2023_20``, **you must create a new terminal session** and configure your environment for the that specific release. For instance:

.. code-block:: bash

    # In a NEW terminal session with BASH shell.
    $ source /cvmfs/sw.lsst.eu/linux-x86_64/lsst_distrib/w_2023_20/loadLSST.bash
    $ setup lsstt_distrib

    # From this point on, your environment in this shell is set up to use release
    # w_2023_20 of lsst_distrib.

At this point you may want to `run the LSST demo <https://pipelines.lsst.io/install/demo.html#download-the-demo-project>`_ and read the tutorials on `how to use the LSST Science Pipelines <https://pipelines.lsst.io/getting-started/index.html#getting-started-tutorials>`_.


Basic Usage of the Apptainer-based Distribution
===============================================

To get help on how to use an Apptainer image use the command ``apptainer run-help`` with the available ``.sif`` file of the release of interest, for instance:

.. code-block:: bash

    $ apptainer run-help /cvmfs/sw.lsst.eu/containers/apptainer/lsst_distrib/w_2023_38.sif

Within the container, the LSST software is installed under ``/opt/lsst/software/stack``.

If on your Linux-based execution host Apptainer is not installed, you can use one of the versions available under ``/cvmfs/sw.lsst.eu/linux-x86_64/apptainer``. For instance, to use Apptainer v1.1.9 you can do:

.. code-block:: bash

    # Extend PATH to include the 'apptainer' executable included in Apptainer v1.1.9
    $ export PATH=/cvmfs/sw.lsst.eu/linux-x86_64/apptainer/v1.1.9/bin:${PATH}

    $ which apptainer
    /cvmfs/sw.lsst.eu/linux-x86_64/apptainer/v1.1.9/bin/apptainer


Advanced Usage
==============

As presented above, each installed release includes its own Python distribution with a set of software packages the LSST Science Pipelines depend on. For your convenience, an extended conda-based environment is also available which includes
a set of convenient packages not included in the original distribution of the LSST Science Pipelines. To use the extended environment do:

.. code-block:: bash

    # Open a new terminal session using a BASH shell (note the '-ext' suffix)
    $ source /cvmfs/sw.lsst.eu/linux-x86_64/lsst_distrib/w_2023_28/loadLSST-ext.bash
    $ setup lsst_distrib

Note that the set of additional packages is added without upgrading or downgrading the packages the LSST Software Pipelines depend on. You can retrieve the exact list of packages included in a given conda-environment via the command:

.. code-block:: bash

    $ conda list

Detailed help on using the ``conda`` command is available in the `conda command reference <https://docs.conda.io/projects/conda/en/latest/commands/index.html>`_.

In a similar way to ``conda``, you can retrieve the list of EUPS-managed products included in a bootstraped release of the LSST software via the command:

.. code-block:: bash

    $ eups list --name

Then you can activate one of those products, for example:

.. code-block:: bash

    $ setup obs_subaru

More information about EUPS can be found in this `EUPS tutorial <https://developer.lsst.io/stack/eups-tutorial.html>`_.


More Advanced Usage
===================

Since ``/cvmfs/sw.lsst.eu`` is a read-only file system you cannot modify the packages installed there in. However, you can customize the set of EUPS packages you want to use in a work session, for instance, to include a modified package in your ``$HOME``.

Let's suppose that you want to use your own version of one of the products included in the pileines, namely ``obs_cfht``. You would like to modify that product to satisfy your specific needs.
Below you will find how you would proceed to do that. Note that there is nothing special with this product: this procedure should work with any other package.

.. code-block:: bash

    # Here we use a weekly release of the LSST pipelines, namely the one tagged 'w_2023_28'.
    $ source /cvmfs/sw.lsst.eu/linux-x86_64/lsst_distrib/w_2023_28/loadLSST.bash

    # EUPS setup the current version of the product 'obs_cfht' included in this release
    # of the stack and verify that the active version is the one included in the stack.
    $ setup obs_cfht
    $ eups list obs_cfht
    g98ea1558ea+2411fcc24f 	w_2023_28 current w_latest setup

    # Clone the product you want to customize under your $HOME and modify it to suit your needs.
    $ git clone https://github.com/lsst/obs_cfht $HOME/obs_cfht
    $ cd $HOME/obs_cfht

    # Make your modifications and build it
    $ scons opt=3

    # Declare version 'my_private_obs_cfht' of product 'obs_cfht' located under '$HOME/obs_cfht'
    # and verify that now EUPS knows about your private version.
    $ eups declare -r $HOME/obs_cfht  obs_cfht  my_private_obs_cfht
    $ eups list obs_cfht
      g98ea1558ea+2411fcc24f 	w_2023_28 current w_latest setup
      my_private_obs_cfht

    # In order to use your private version you need to set it up first.
    $ setup obs_cfht my_private_obs_cfht
    $ eups list obs_cfht
      g98ea1558ea+2411fcc24f 	w_2023_28 current w_latest
      my_private_obs_cfht 	setup


    # From this point on, when you use the product 'obs_cfht' you will be using
    # the one in your $HOME, that you can modify.


    # When done, unsetup your private version.
    $ setup -u obs_cfht my_private_obs_cfht
    $ eups list obs_cfht
       g98ea1558ea+2411fcc24f 	w_2023_28 current w_latest
       my_private_obs_cfht

    # When you no longer need your private version tell EUPS to forget it.
    $ eups undeclare obs_cfht my_private_obs_cfht
    $ eups list obs_cfht
       g98ea1558ea+2411fcc24f 	w_2023_28 current w_latest

    # If you setup 'obs_cfht' again, it is the one included in the LSST stack that will
    # be used and not your private one.
    $ setup obs_cfht
    $ eups list obs_cfht
       g98ea1558ea+2411fcc24f 	w_2023_28 current w_latest setup


Using both lsst_distrib and lsst_sims in the same work session
==============================================================

To work with both **lsst_distrib** and **lsst_sims** in the same work session you can proceed as shown below. For illustration purposes, in this example we use **lsst_distrib** release ``w_2019_19`` and **lsst_sims** release ``sims_w_2019_19`` on a computer running Linux:


.. code-block:: bash

    # Setup the environment for lsst_distrib and EUPS setup it
    $ source /cvmfs/sw.lsst.eu/linux-x86_64/lsst_distrib/w_2019_19/loadLSST.bash
    $ setup lsst_distrib

    # Extend EUPS_PATH to also include the EUPS products in lsst_sims
    $ export EUPS_PATH=${EUPS_PATH}:/cvmfs/sw.lsst.eu/linux-x86_64/lsst_sims/sims_w_2019_19/stack/current
    $ setup lsst_sims

Now, to check that both **lsst_distrib** and **lsst_sims** are (EUPS) setup do:

 .. code-block:: bash

    $ eups list --name -s | grep -e lsst_sims -e lsst_distrib
    lsst_distrib
    lsst_sims

The same procedure works on macOS, but you need to use the appropriate top directory, that is ``/cvmfs/sw.lsst.eu/darwin-x86_64`` instead of ``/cvmfs/sw.lsst.eu/linux-x86_64``.
