.. _core-db:

core-db
=======

Core-autmation provides a database schema that is used to store the state of the application.  This
schema is used to store the state of the application and is used to provide a history of changes to
the application infrastucture deployments.

The database schema can be found :ref:`here...<database_schema>`

Base Models
-----------

.. autosummary::
   :toctree: _autosummary
   :template: custom-module-template.rst
   :recursive:

   core_db.actions
   core_db.response
   core_db.dbhelper
   core_db.constants
   core_db.exceptions

FACTS Database
--------------

.. autosummary::
   :toctree: _autosummary
   :template: custom-module-template.rst
   :recursive:

   core_db.facter
   core_db.registry

Deployments Database
--------------------

.. autosummary::
   :toctree: _autosummary
   :template: custom-module-template.rst
   :recursive:

   core_db.item

Event Log Database
------------------

.. autosummary::
   :toctree: _autosummary
   :template: custom-module-template.rst
   :recursive:

   core_db.event

