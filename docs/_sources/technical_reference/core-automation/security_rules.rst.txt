Dynamic Security Rules
======================

Security rules may need to reference resources with randomness injected into their
names (eg: sqs queues) and thus cannot be created PRIOR to resource generation.

Security Rules are injected into resources *after* they are genearated.

Many times resource deployments and Cloudformation need access to other rsources (such as s3) in order to
be crated.  As such, Security Rules must be created *before* or during the Cloudformation deployment.

The process to create security rules is as follows:

#. Create the security rules stack with ``ResourcesStackName`` is set to blank (""), to create all base rules.
#. Create the resources stack
#. Update the security rules stack with ``ResourcesStackName`` set, to create the remaining rules for
   dynamically named resources.

To achieve this, ``Condition: ResourcesExist`` is used on any rules resources that will try to import
values from the resources stack.

.. todo::

    * Dynamically create DynamoDB table names to ensure uniqueness and do not exceed table name length
      limits by using hashes.  Example: client-portfolio-app-<table-name>-HASHKEY.  Tags will contain
      branch and build.
    * Lambda function names should be unique and not exceed 64 characters.  Use a hash to ensure
      uniqueness.  Names should use the same logic: client-portfolio-app-<function-name>-HASHKEY.
      Tags will contain branch and build.
