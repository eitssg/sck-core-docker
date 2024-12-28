.. _core-renderer:

core-renderer
=============

The core-autmation framework provides a context or meta-data facts that are used to render CloudFormation
templates.  The renderer is a Jinja2 template engine that is uses this context and wraps up the yaml or
json nicely for you.

Jinja2 Context Renderer
-----------------------

.. autosummary::
   :toctree: _autosummary
   :template: custom-module-template.rst
   :recursive:

   core_renderer.renderer
   core_renderer.monkeypatch
