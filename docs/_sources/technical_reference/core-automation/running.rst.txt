Running
=======

Core automation commandline interface (CLI) is a wrapper around the ``invoke`` library, which provides a way to run tasks
in a container (lambda or docker).  When you add a new task or make modifications, you can test the module you've modified
by using pytest

.. code-block:: bash

    # need to install the requirements
    poetry install

    pytest ./tests

All configurations are in the file pytest.ini which are provided in each repository submodule.  Fore core-db, the ini
file looks like this:

.. code-block:: ini

    [pytest]
    addopts = --maxfail=1 --disable-warnings --cov=core_db --cov-report=term-missing --cov-report=html
    testpaths = tests
    python_files = test_*.py
    asyncio_default_fixture_loop_scope = session
    env_override_existing_values = true
    env_files =
        .env

You sould create the .env file so you can add your Environment Varaiables to your project

.. code-block:: ini

    LOCAL_MODE=true

Setting LOCAL_MODE to true will run the all code in a "container" mode (e.g. your laptop or docker container)

**Running Code**

To run a pipeline:

.. code-block:: bash

    core run compile -h
    usage: core run compile [-h] [--mode MODE] [--aws-profile AWS_PROFILE]
                            [--app-path APP_PATH] [--bucket-region BUCKET_REGION]
                            [--bucket-name BUCKET_NAME]
                            portfolio app branch build

    Component Compiler for the Action Runner

    Arguments:
      -c, --client          Client name (default: configuration value)
      -p, --portfolio       Portfolio name (default: environment variable)
      -a, --app             Application/Deployment name
      -b, --branch          Branch name (with dashes instead of underscores)
      -n, --build           Build number (git tag such as "v1.0.0+commitHash")
      -h, --help            show this help message and exit
      --mode MODE           Mode of operation (None|local) (default: None)
                            if Local, then app-path is required and the compiled
                            content is deposited in app-path/_compiled
      --dry-run             Dry run (default: False)
      --app-path APP_PATH   Local app path (local mode only) (default: None)

An example command would look like this:

.. code-block:: bash

    # Local mode
    core --client sample run compile -p demo -a simpleapp -b staging -n 1 --mode=local --app-path /tmp

    # Test mode
    core --client sample run compile -p demo -a simpleapp -b staging -n 1 --mode=local --dry-run

If you wish to output all file content to a container mounted volume, you can set the environment variables:

.. code-block:: ini

    CLIENT=sample
    LOCAL_MODE=true
    VOLUME=/opt/data/core

And by adding the CLIENT and LOCAL_MODE in the .env file, you can run the command without the --client and --mode flags:
