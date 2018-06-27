.. _usage:

*************************************************
Usage of the Software under ``/cvmfs/sw.lsst.eu``
*************************************************

Once the CernVM-FS client is installed and configured in your computer, a one-time process (see :ref:`installation`), you can start using the LSST software.

In this section you will find information on how to use the online LSST software repository. It appears in your computer **in read-only** mode under the path ``/cvmfs/sw.lsst.eu``. Super-user privileges are not required to access the files there in.

Repository Layout
=================

The namespace under ``/cvmfs/sw.lsst.eu`` is meant to be self-explanatory. There you will find a sub-directory per supported platform (i.e. ``darwin-x86_64``, ``linux-x86_64``), a subdirectory for each distribution (e.g. ``lsst_distrib``) and a subdirectory for each available release (e.g. ``v15.0``, ``w_2018_19``). It looks like:

.. code-block:: bash

    $ tree -L 3 /cvmfs/sw.lsst.eu
    /cvmfs/sw.lsst.eu
    ├── darwin-x86_64
    │   └── lsst_distrib
    │       ├── v15.0
    │       ├── w_2018_14
    │       ├── w_2018_15
    │       ├── w_2018_16
    │       ├── w_2018_17
    │       ├── w_2018_18
    │       ├── w_2018_19
    │       ├── w_2018_20
    │       └── w_2018_21
    └── linux-x86_64
        ├── lsst_distrib
        │   ├── v15.0
        │   ├── w_2018_14
        │   ├── w_2018_15
        │   ├── w_2018_16
        │   ├── w_2018_17
        │   ├── w_2018_18
        │   ├── w_2018_19
        │   ├── w_2018_20
        │   └── w_2018_21
        └── lsst_sims
            └── sims_2_8_0


Names of directories containing **stable releases** start with letter "v" (e.g. ``v15.0``) and directories where **weekly releases** are located are named starting with letter "w" (e.g. ``w_2018_19``). ``lsst_distrib`` is the name of the LSST distribution, that is, a coherent set of packages that together form the LSST science pipelines. Each release of the LSST software is built specifically for delivery via CernVM-FS according to the `official instructions <https://pipelines.lsst.io>`_.

Each release of the LSST software you will find under ``/cvmfs/sw.lsst.eu``, be it stable or weekly, is mostly self contained: it includes its own EUPS (see below), its own **Python 3** distribution (typically `miniconda <https://www.anaconda.com/download>`_) and its own set of external packages that specific release depends on (e.g. ``numpy``, ``cfitsio``, etc.). In particular, since the Python distribution installed with each release includes its own interpreter, each release is independent and configured so **it does not conflict with other Python interpreter** you may have already installed on your computer.

.. important::

   The LSST science pipelines depend on the runtime libraries of the C++ compiler. **You must have the appropriate version of the C++ compiler installed on your computer** for the LSST software to execute properly, since that compiler is not included in ``/cvmfs/sw.lsst.eu``.

   It is likely that successive versions of the C++ compilers keep a backwards-compatible Application Binary Interface (ABI). In practice, that means that, in general, a more recent version of the C++ compiler than the one used to build the LSST software can be used.

   You can find the specifics of the C++ compiler a particular release of the LSST software depends on in the file ``README.txt`` in each release's top directory.

Basic Usage
===========

The first step for using the LSST science pipelines is to select the release you want to use and bootstrap your environment for that specific release. For instance, to use LSST ``v15.0`` on a Linux computer do:

.. code-block:: bash

    # Open a new terminal session using a BASH shell
    $ source /cvmfs/sw.lsst.eu/linux-x86_64/lsst_distrib/v15.0/loadLSST.bash

As a result of executing this command, some environmental variables are extended or initialized, such as ``PATH``, ``PYTHONPATH``, ``LD_LIBRARY_PATH`` and ``EUPS_PATH``.

.. note::

    Most of the recent releases of the LSST pipelines use GCC v6.3 on Linux, which is usually installed on CentOS and RedHat via the `devltoool-6 <https://www.softwarecollections.org/en/scls/rhscl/devtoolset-6/>`_ package. If that package is installed on your computer, it will be automatically detected and activated as a result of the command above.

The LSST software uses `EUPS <https://github.com/RobertLuptonTheGood/eups>`_ for managing the set of software products which are part of a given release. EUPS allows you to select the packages you want to use in a work session. For instance, to use the command line tasks for processing CFHT images, you would do:

.. code-block:: bash

    $ setup obs_cfht
    $ setup pipe_tasks

After these steps, your working environment is modified so that you can use the command line tasks (e.g. ``ingestImages.py``, ``processCcd.py``, etc.) and import LSST-specific modules in your own Python programs (e.g. ``import lsst.daf.persistence``):

.. code-block:: bash

    $ processCcd.py --help
    usage: processCcd.py input [options]

    positional arguments:
      input                 path to input data repository, relative to
                            $PIPE_INPUT_ROOT

    optional arguments:
      -h, --help            show this help message and exit
      --calib RAWCALIB      path to input calibration repository, relative to
                            $PIPE_CALIB_ROOT
    ...


If later on you need to work with a different release, say weekly ``w_2018_19``, **you must create a new terminal session** and configure your environment for the that specific release. For instance:

.. code-block:: bash

    # In a new terminal session with BASH shell
    $ source /cvmfs/sw.lsst.eu/linux-x86_64/lsst_distrib/w_2018_19/loadLSST.bash

    # From this point on, your environment is set up to use release w_2018_19

At this point you may want to `run the LSST demo <https://pipelines.lsst.io/install/demo.html#download-the-demo-project>`_ and read the tutorials on `how to use the LSST Science Pipelines <https://pipelines.lsst.io/getting-started/index.html#getting-started-tutorials>`_.


Advanced Usage
==============

As presented above, each installed release includes its own miniconda Python distribution with a strict set of packages the LSST science pipelines depend on. For your convenience, a set of packages is added without modifying the dependencies of the LSST software.

You can determine which version of the Python interpreter is used for a given release of the LSST stack and obtain the list of installed packages via the ``conda`` command. For instance, when using ``w_2018_19`` on macOS you get:

.. code-block:: bash

    $ source /cvmfs/sw.lsst.eu/darwin-x86_64/lsst_distrib/w_2018_19/loadLSST.bash

    $ which python
    /cvmfs/sw.lsst.eu/darwin-x86_64/lsst_distrib/w_2018_19/python/miniconda3-4.3.21/bin/python

    $ python --version
    Python 3.6.2 :: Continuum Analytics, Inc.

    $ conda list
    # packages in environment at /cvmfs/sw.lsst.eu/darwin-x86_64/lsst_distrib/w_2018_19/python/miniconda3-4.3.21:
    #
    appnope                   0.1.0            py36hf537a9a_0  
    asn1crypto                0.22.0                   py36_0  
    astropy                   2.0.1               np113py36_0  
    ...
    yaml                      0.1.6                         0  
    zeromq                    4.2.5                h378b8a2_0  
    zlib                      1.2.8                         3  

Among the packages deliberately added to each installed release, there are the ones necessary to use the `Jupyter <http://jupyter.org>`_ interactive computing environment with Python 3. You can therefore launch Jupyter via one of the commands:

.. code-block:: bash

    $ jupyter nootebook

or

.. code-block:: bash

    $ jupyter lab

and you will get an LSST-enabled notebook environment ready to use.

In a similar way to ``conda``, you can retrieve the list of EUPS-managed products included in a bootstraped release of the LSST software via the command:

.. code-block:: bash

    $ eups list --name
    afw       
    apr       
    apr_util  
    ...
    wcslib    
    ws4py     
    xpa       

Then you can activate one of those products, for example:

.. code-block:: bash

    $ setup obs_subaru

More information about EUPS can be found in this `EUPS tutorial <https://developer.lsst.io/stack/eups-tutorial.html>`_.


More Advanced Usage
===================

Since ``/cvmfs/sw.lsst.eu`` is a read-only file system you cannot modify the packages installed there in. However, you can customize the set of EUPS packages you want to use in a work session.

Let's suppose that you want to use your own version of one of the products included in the stack, namely ``obs_cfht``. You would like to modify that product to satisfy your specific needs. Below you will find how you would proceed to do that. Note that there is nothing special with this product: this procedure should work with any other package.

.. code-block:: bash

    # Here we use a weekly release of the LSST pipelines, namely the one tagged 'w_2018_25'
    $ source /cvmfs/sw.lsst.eu/linux-x86_64/lsst_distrib/w_2018_25/loadLSST.bash

    # EUPS setup the current version of the product 'obs_cfht' included in this release of the stack
    # and verify that the set up version is the one included in the stack
    $ setup obs_cfht
    $ eups list obs_cfht
       15.0-5-g891f9b3  w_latest w_2018_25 current setup

    # Clone the product you want to customize under your $HOME and modify it to suit your needs
    $ git clone https://github.com/lsst/obs_cfht $HOME/obs_cfht
    $ cd $HOME/obs_cfht

    # Build it
    $ scons opt=3

    # Declare version 'my_private_obs_cfht' of product 'obs_cfht' located under '$HOME/obs_cfht'
    # and verify that now EUPS knows about your private version
    $ eups declare -r $HOME/obs_cfht  obs_cfht  my_private_obs_cfht
    $ eups list obs_cfht
       15.0-5-g891f9b3  w_latest w_2018_25 current setup
       my_private_obs_cfht 

    # In order to use your private version you need to set it up first
    $ setup obs_cfht my_private_obs_cfht
    $ eups list obs_cfht
       15.0-5-g891f9b3  w_latest w_2018_25 current
       my_private_obs_cfht  setup

    # From now on, when you use the product 'obs_cfht' you will be using the one
    # in your $HOME

    # When done, unsetup your private version
    $ setup -u obs_cfht my_obs_cfht
    $ eups list obs_cfht
       15.0-5-g891f9b3  w_latest w_2018_25 current
       my_private_obs_cfht 

    # When you no longer need your private version tell EUPS to forget it
    $ eups undeclare obs_cfht my_private_obs_cfht
    $ eups list obs_cfht
       15.0-5-g891f9b3  w_latest w_2018_25 current

    # If you setup 'obs_cfht' again, it is the one included in the LSST stack that will be used
    # and not your private one
    $ setup obs_cfht
    $ eups list obs_cfht
       15.0-5-g891f9b3  w_latest w_2018_25 current setup









.. todo::

    Add information about:

    * How to install additional packages by creating a custom conda environment
