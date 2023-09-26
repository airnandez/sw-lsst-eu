.. _overview:

********
Overview
********

With this cloud-based software distribution mechanism **you will be able to use any of the releases of the LSST science pipelines available online**. Those releases are accessible in **read-only mode through a file system** mounted on path ``/cvmfs/sw.lsst.eu`` and effectively appear as if you had installed all of them on your computer.

This service is built upon CERN's `CernVM file system <https://cvmfs.readthedocs.io>`_, a POSIX read-only file system in user space designed for large-scale software distribution. A software agent running on your computer interacts with servers via standard protocols, downloads the files on demand, caches them on your computer and exposes them via the operating system's file system interface.

In this section you will find information on the benefits of this mechanism, its intended audience, the platforms where it is supported and how to get started.

=====================
Browse the Repository
=====================

You may want to **browse the current contents of this software repository** by visiting `CERN's repository monitor <https://cvmfs-monitor-frontend.web.cern.ch/sw.lsst.eu>`_ before deciding if this service is suitable for your individual needs.

========
Benefits
========

This service mainly intends to make easier the use of the LSST software by a broader community: the more people test and routinely use the software the better it will get. 

Since keeping up with the frequent releases of the LSST software by installing it yourself can be time consuming, with this service **you can focus on using the LSST software from the comfort of your personnal computer**, instead on the technicalities of frequently installing and updating it.

At any given moment you will find several releases, both **stable** and **weekly**, of the LSST software ready to use. You just need to navigate the file system under the path

.. code-block:: bash
 
    /cvmfs/sw.lsst.eu

to select the release you want to use, configure your environment to use the desired release and start using the software. This approach has the additional benefit that you can test your own scripts and notebooks against several releases of the LSST software, compare results, use new features, detect regresions and provide feedback to the developers.

Each one of releases you find under ``/cvmfs/sw.lsst.eu`` is packaged so that it is almost self-contained. In other words, each release embeds almost all its dependencies, including a Python iterpreter and several other packages. In practice, this means that you can have other Python environments already installed in your computer and they won't conflict with the ones used for the LSST software releases.

To summarize, this mechanism may be convenient if you **don't want to regularly install or update the LSST software on your computer**: when you need it, you access online the release of your choice among the ones available at that time.

=================
Intended Audience
=================

This mechanism of distributing the LSST software, which supplements the `other mechanisms <https://pipelines.lsst.io/install/index.html>`_ provided by the project, is intended in particular for **individuals** willing to use the LSST software on their personnal computers. 

However, it is not limited to that use case. The same mechanism is used for making the LSST software available to the computers in the CC-IN2P3's `login <http://doc.lsst.eu/ccin2p3/ccin2p3.html#login-farm>`_ and `batch <http://doc.lsst.eu/ccin2p3/ccin2p3.html#batch-farm>`_ farms. This is considered beneficial for reproducibility purposes, since as a scientist you can use exactly the same version of the LSST software on your personal computer, as well as in your notebooks and in your batch or grid jobs executing at CC-IN2P3, `NERSC <https://www.nersc.gov>`_  and `OpenScienceGrid <https://opensciencegrid.org>`_ sites.


===================
Supported Platforms
===================

The `reference platform <https://pipelines.lsst.io/install/prereqs/index.html#platform-compatibility>`_ for the LSST science pipelines software is currently CentOS 7. Besides that plaform, the software has been shown to work on macOS and Ubuntu, among others systems.

The distribution mechanism documented here has been tested on CentOS, Ubuntu and macOS but is expected to work on other Linux distributions as well. If you successfully test it on your favorite Linux distribution, please let us know (see :ref:`help`).


==================
How to Get Started
==================

You are encouraged to visit the section :ref:`usage` to get more details to help you decide whether this distribution mechanism is convenient for your individual use case. If you think it is, you can take a few minutes to install and configure the required software (see :ref:`installation`).
