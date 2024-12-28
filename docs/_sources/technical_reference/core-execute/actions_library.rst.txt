.. _actions-library:

Actions Library
===============

.. toctree::
   :hidden:
   :maxdepth: 1

   actionlib_aws
   actionlib_aws_rds
   actionlib_aws_kms

.. rubric::  actionlib

.. automodule:: core_execute.actionlib
   :members:
   :undoc-members:
   :show-inheritance:
   :inherited-members:

.. autosummary::
   :toctree: _autosummary
   :template: custom-module-template.rst
   :recursive:

   core_execute.actionlib.helper
   core_execute.actionlib.action
   core_execute.actionlib.factory

.. rubric:: actionlib.actions

.. automodule:: core_execute.actionlib.actions
   :members:
   :undoc-members:
   :show-inheritance:
   :inherited-members:

.. rubric:: actionlib.actions.aws

.. automodule:: core_execute.actionlib.actions.aws
   :members:
   :undoc-members:
   :show-inheritance:
   :inherited-members:

.. rubric:: actionlib.actions.system

.. automodule:: core_execute.actionlib.actions.system
   :members:
   :undoc-members:
   :show-inheritance:
   :inherited-members:

.. rubric:: AWS::Actions

All AWS actions are defined in this module.  The actions are used to interact with AWS services.

See :ref:`more...<actionlib_aws>`

.. rubric:: AWS::RDS::Actions

All AWS actions are defined in this module.  The actions are used to interact with AWS services.

See :ref:`more...<actionlib_aws_rds>`

.. rubric:: AWS::KMS::Actions

All AWS actions are defined in this module.  The actions are used to interact with AWS services.

See :ref:`more...<actionlib_aws_kms>`

.. rubric:: SYSTEM::Actions

All system actions are defined in this module.  The actions are used to interact with the system.

See :ref:`more...<actionlib_system>`
