.. _database_schema:

Database Schema
===============
Documentation on the database schemas used in the application.


Clients Table
-------------
Organizatons in AWS are represented in the registry database as a ``Client``.

.. raw:: html

    <b>Table name:</b> core-automation-clients<br/>

+--------------------+-----------+---------------------------------------------+
| Attribute          | Type      | Description                                 |
+====================+===========+=============================================+
| client (hash)      | str       | The 'slug' identifier of the organization   |
+--------------------+-----------+---------------------------------------------+
| more...            |           |                                             |
+--------------------+-----------+---------------------------------------------+


Portfolios Table
----------------
A portfolio is a Business Application.  It defines the owners and stackeholders for the deployments
of applicatin infrastructure.

.. raw:: html

    <b>Table name:</b> core-automation-portfolios<br/>

+--------------------+-----------+---------------------------------------------+
| Attribute          | Type      | Description                                 |
+====================+===========+=============================================+
| client (hash)      | str       | The 'slug' identifier of the organization   |
+--------------------+-----------+---------------------------------------------+
| portfolio (range)  | str       | The 'slug' identifier of the portfolio or   |
|                    |           | Buisness Application (bizApp)               |
+--------------------+-----------+---------------------------------------------+
| more...            |           |                                             |
+--------------------+-----------+---------------------------------------------+

Apps Table
----------
The app Registry is a lists of deployments within a specific portfolio.  A deployment is targeted
at a specific zone

.. raw:: html

    <b>Table name:</b> core-automation-apps<br/>

+-------------------------+-----------+---------------------------------------------+
| Attribute               | Type      | Description                                 |
+=========================+===========+=============================================+
| ClientPortfolio (hash)  | str       | The f"{client}:{portfolo}" string           |
+-------------------------+-----------+---------------------------------------------+
| AppRegEx (range)        | str       | A regular expresstion matching the the      |
|                         |           | string f"{app}-{branch}-{build}"            |
|                         |           |                                             |
|                         |           | Example: "^(.+)-(.+)-(.+)$"                 |
+-------------------------+-----------+---------------------------------------------+
| Zone                    | str       | The Zone where this app is to be deployed   |
+-------------------------+-----------+---------------------------------------------+
| Region                  | str       | The region name sepcified in the Zone       |
|                         |           | definition                                  |
+-------------------------+-----------+---------------------------------------------+
| Tags                    | map       | A set of name/value mappings that are to be |
|                         |           | applied to the resource tags                |
+-------------------------+-----------+---------------------------------------------+

Zones Table
-----------
The zone Registry is a list of locations including AWS Account and Region(s) that are used to
contain App Deployments.

.. raw:: html

    <b>Table name:</b> core-automation-zones<br/>

+------------------------+--------------+----------------------------------------------+
| Attribute              | Type         | Description                                  |
+========================+==============+==============================================+
| ClientPortfolio (hash) | str          | The f"{client}:{portfolo}" string            |
+------------------------+--------------+----------------------------------------------+
| Zone (range)           | str          | A name or label identifying a landing zon e  |
|                        |              | for the application deployments              |
+------------------------+--------------+----------------------------------------------+
| AccountFacts           | AccountFacts |                                              |
+------------------------+--------------+----------------------------------------------+
| RegionFacts            | map          | A map of regionfacts:                        |
|                        |              |                                              |
|                        |              | e.g. regionFacts: Dict[str, RegionFacts]     |
|                        |              | = {"sin": {"AwsRegion": "ap-southeast-1"}}   |
+------------------------+--------------+----------------------------------------------+

AccountFacts
~~~~~~~~~~~~
The AccountFacts is a set of attributes that are used to define the AWS Account that is used in the Zone

+-------------------------+--------------+---------------------------------------------+
| Attribute               | Type         | Description                                 |
+=========================+==============+=============================================+
| AwsAccountId            | str          |                                             |
+-------------------------+--------------+---------------------------------------------+
| AccountName             | str          |                                             |
+-------------------------+--------------+---------------------------------------------+
| Kms                     | KmsFacts     |                                             |
+-------------------------+--------------+---------------------------------------------+
| more ...                |              |                                             |
+-------------------------+--------------+---------------------------------------------+

RegionFacts
~~~~~~~~~~~~
The RegionFacts is a set of attributes that are used to define the AWS Region that is used in the Zone

+-------------------------+--------------+---------------------------------------------+
| Attribute               | Type         | Description                                 |
+=========================+==============+=============================================+
| AwsRegion               | str          | AWS Region Code.  e.g. us-east-1            |
+-------------------------+--------------+---------------------------------------------+

KmsFacts
~~~~~~~~
+-------------------------+--------------+---------------------------------------------+
| Attribute               | Type         | Description                                 |
+=========================+==============+=============================================+
| KmsKey                  | str          | KmsKey used to encrypt resources            |
+-------------------------+--------------+---------------------------------------------+



Items Table
-----------
The items table provides a dataabase of all Portfolios, Apps, Branches, Builds, and Components that have
been deployed to the Landing Zones.

The following data models are in stored the Items table:


* :ref:`portfolio-schema`
* :ref:`app-schema`
* :ref:`branch-schema`
* :ref:`build-schema`
* :ref:`component-schema`

.. _portfolio-schema:

Portfolio Schema
~~~~~~~~~~~~~~~~

.. raw:: html

    <b>Table name:</b> {client}-core-automation-items<br/>
    <small><i><b>Note:</b> {client} is the AWS Organization Name (slug value)</i></small>

+--------------------+-----------+------------------------------------------+
| Attribute          | Type      | Description                              |
+====================+===========+==========================================+
| prn (hash)         | str       | Pipeline Reference Number                |
+--------------------+-----------+------------------------------------------+
| parent_prn (range) | str       | Parent Pipeline Reference Number         |
+--------------------+-----------+------------------------------------------+
| name               | str       | Name of the portfolio                    |
+--------------------+-----------+------------------------------------------+
| contact_email      | str       | Contact email address                    |
+--------------------+-----------+------------------------------------------+
| created_at         | timestamp | Timestamp when the portfolio was created |
+--------------------+-----------+------------------------------------------+
| updated_at         | timestamp | Timestamp when the portfolio was last    |
|                    |           | updated                                  |
+--------------------+-----------+------------------------------------------+


.. _app-schema:

App Schema
~~~~~~~~~~


.. raw:: html

    <b>Table name:</b> {client}-core-automation-items<br/>
    <small><i><b>Note:</b> {client} is the AWS Organization Name (slug value)</i></small>

+--------------------+-----------+------------------------------------------+
| Attribute          | Type      | Description                              |
+====================+===========+==========================================+
| prn (hash)         | str       | Pipeline Reference Number                |
+--------------------+-----------+------------------------------------------+
| parent_prn (range) | str       | Parent Pipeline Reference Number         |
+--------------------+-----------+------------------------------------------+
| name               | str       | Name of the app                          |
+--------------------+-----------+------------------------------------------+
| portfolio_prn      | str       | Example "prn:portfolio_name"             |
+--------------------+-----------+------------------------------------------+
| contact_email      | str       | Contact email address                    |
+--------------------+-----------+------------------------------------------+
| created_at         | timestamp | Timestamp when the app was created       |
+--------------------+-----------+------------------------------------------+
| updated_at         | timestamp | Timestamp when the app was last updated  |
+--------------------+-----------+------------------------------------------+

.. _branch-schema:

Branch Schema
~~~~~~~~~~~~~

Branches for the App deployment

+--------------------+-----------+---------------------------------------------------+
| Attribute          | Type      | Description                                       |
+====================+===========+===================================================+
| prn (hash)         | str       | Pipeline Reference Number                         |
+--------------------+-----------+---------------------------------------------------+
| parent_prn (range) | str       | Parent Pipeline Reference Number                  |
+--------------------+-----------+---------------------------------------------------+
| name               | str       | Name of the app                                   |
+--------------------+-----------+---------------------------------------------------+
| portfolio_prn      | str       | Example "prn:portfolio_name"                      |
+--------------------+-----------+---------------------------------------------------+
| app_prn            | str       | Example "prn:portfolio_name:app_name"             |
+--------------------+-----------+---------------------------------------------------+
| created_at         | timestamp | Timestamp when the portfolio was created          |
+--------------------+-----------+---------------------------------------------------+
| updated_at         | timestamp | Timestamp when the portfolio was last             |
|                    |           | updated                                           |
+--------------------+-----------+---------------------------------------------------+

.. _build-schema:

Build Schema
~~~~~~~~~~~~

.. raw:: html

    <b>Table name:</b> {client}-core-automation-items<br/>
    <small><i><b>Note:</b> {client} is the AWS Organization Name (slug value)</i></small>

+--------------------+-----------+---------------------------------------------------+
| Attribute          | Type      | Description                                       |
+====================+===========+===================================================+
| prn (hash)         | str       | Pipeline Reference Number                         |
+--------------------+-----------+---------------------------------------------------+
| parent_prn (range) | str       | Parent Pipeline Reference Number                  |
+--------------------+-----------+---------------------------------------------------+
| name               | str       | Name of the build                                 |
+--------------------+-----------+---------------------------------------------------+
| portfolio_prn      | str       | Example "prn:portfolio_name"                      |
+--------------------+-----------+---------------------------------------------------+
| app_prn            | str       | Example "prn:portfolio_name:app_name"             |
+--------------------+-----------+---------------------------------------------------+
| branch_prn         | str       | Example "prn:portfolio_name:app_name:branch_name" |
+--------------------+-----------+---------------------------------------------------+
| created_at         | timestamp | Timestamp when the build was created              |
+--------------------+-----------+---------------------------------------------------+
| updated_at         | timestamp | Timestamp when the build was last                 |
|                    |           | updated                                           |
+--------------------+-----------+---------------------------------------------------+

.. _component-schema:

Component Schema
~~~~~~~~~~~~~~~~

.. raw:: html

    <b>Table name:</b> {client}-core-automation-items<br/>
    <small><i><b>Note:</b> {client} is the AWS Organization Name (slug value)</i></small>

+--------------------+-----------+---------------------------------------------------+
| Attribute          | Type      | Description                                       |
+====================+===========+===================================================+
| prn (hash)         | str       | Pipeline Reference Number                         |
+--------------------+-----------+---------------------------------------------------+
| parent_prn (range) | str       | Parent Pipeline Reference Number                  |
+--------------------+-----------+---------------------------------------------------+
| portfolio_prn      | str       | Example "prn:portfolio_name"                      |
+--------------------+-----------+---------------------------------------------------+
| app_prn            | str       | Example "prn:portfolio_name:app_name"             |
+--------------------+-----------+---------------------------------------------------+
| branch_prn         | str       | Example "prn:portfolio_name:app_name:branch_name" |
+--------------------+-----------+---------------------------------------------------+
| build_prn          | str       | Example "prn:portfolio_name:app_name:branch_name" |
+--------------------+-----------+---------------------------------------------------+
| status             | enum      | Status of the component                           |
+--------------------+-----------+---------------------------------------------------+
| message            | string    | Message related to the component                  |
+--------------------+-----------+---------------------------------------------------+
| created_at         | timestamp | Timestamp when the component was created          |
+--------------------+-----------+---------------------------------------------------+
| updated_at         | timestamp | Timestamp when the component was last             |
|                    |           | updated                                           |
+--------------------+-----------+---------------------------------------------------+

Event Table
-----------

.. raw:: html

    <b>Table name:</b> {client}-core-automation-events<br/>
    <small><i><b>Note:</b> {client} is the AWS Organization Name (slug value)</i></small>

+--------------------+-----------+------------------------------------------+
| Attribute          | Type      | Description                              |
+====================+===========+==========================================+
| prn (hash)         | str       | Pipeline Reference Number                |
+--------------------+-----------+------------------------------------------+
| timestamp          | timestamp | Timestamp of the event                   |
+--------------------+-----------+------------------------------------------+
| status             | enum      | Status of the event                      |
+--------------------+-----------+------------------------------------------+
| message            | string    | Message related to the event             |
+--------------------+-----------+------------------------------------------+
| details            | string    | Additional details about the event       |
+--------------------+-----------+------------------------------------------+

