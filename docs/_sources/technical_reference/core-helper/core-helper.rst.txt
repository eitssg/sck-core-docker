.. _core-helper:

core-helper
===========

Core helper provides tools for access AWS using boto3.  The idea is to provide wrappers around a lot
of boilerplate code that is used to access AWS services.  This includes switchig roles for each of
the lambda functions that provide security and limits blast radius.

AWS Helper functions
--------------------

.. autosummary::
   :toctree: _autosummary
   :template: custom-module-template.rst
   :recursive:

   core_helper.aws
