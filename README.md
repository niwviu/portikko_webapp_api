# portikko_webapp_api

## Running the Application Locally

Run `aqueduct serve` from this directory to run the application. For running within an IDE, run `bin/main.dart`. By default, a configuration file named `config.yaml` will be used.

To generate a SwaggerUI client, run `aqueduct document client`.

## Running Application Tests

To run all tests for this application, run the following in this directory:

```
pub run test
```

The default configuration file used when testing is `config.src.yaml`. This file should be checked into version control. It also the template for configuration files used in deployment.

## Deploying an Application

See the documentation for [Deployment](https://aqueduct.io/docs/deploy/).

## Running migrations

Run `aqueduct db generate` to generate migrations files.
Run `aqueduct db validate` to validate syntax.
Run `aqueduct db upgrade` to create the db transactions.
Run `aqueduct db upgrade --connect postgres://username:password@localhost:5432/my_application`. Run this command for production.
