.. _core-execute:

core-execute
============
The core-execute is a lambda function that is used to execute the Step Function that performs the "deploy",
"plan" and "apply" steps.  Deploying infastructre can take a long time and the Step Function is used to
manage the deployment process and monitor the deployments.


.. toctree::
   :hidden:
   :maxdepth: 3

   actions_library

.. rubric:: Actions Lobrary

Core Execute provides a library of actions that can be used to perform the "deploy", "plan" and "apply" tasks.

Tasks are a collection of 1 or more actions.  Actions code is located in this module and definitions of
what actions to execute for a task are located in the Deployment Details aretefact store.

.. rubric:: Tasks

* compile
* plan
* apply
* deploy
* release
* teardown

.. rubric:: Actions

Actions are the smallest unit of work that can be executed.  Actions are defined in the Deployment Details

Stored on the filesystem (s3 bucket) in the folder:

   s3://<bucket>/artefacts/<deployment_id>/<task>.actions

Where deployment_id is the unique identifier for the deployment: "myportfolio/myapp/mainbranch/build123"

So, if the task is *deploy*, the actions file is:

   s3://<bucket>/artefacts/myportfolio/myapp/mainbranch/build123/deploy.actions

The actions file is YAML file which contains a list of actions that is executed by the state machine.

.. code-block:: yaml

   - Label: action-system-noop1-label
     Type: "SYSTEM::NoOp"
     Params:
        Account: "154798051514"
        Region: "ap-southeast-1"
     Scope: "build"
   - Label: action-system-noop2-label
     Type: "SYSTEM::NoOp"
     DependsOn: ["action-system-noop1-label"]
     Params:
        Account: "154798051514"
        Region: "ap-southeast-1"
     Scope: "build"


The above will run two actions, the first action is a NoOp action that does nothing and the second action is a NoOp
action that depends on the first action.

See the :ref:`actions-library` for more information on the actions that are available.

