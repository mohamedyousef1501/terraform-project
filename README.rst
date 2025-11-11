Terraform Project
=================

Minimal Terraform project that deploys a VPC, proxy/load-balancer components, and a backend application.
Includes a small local example app.

Architecture Diagram
--------------------

.. image:: ./images/arch_diagram.png
   :alt: Architecture diagram

Repository structure
--------------------

- Root Terraform files
  - .terraform.lock.hcl
  - main.tf
  - providers.tf
  - variables.tf
  - outputs.tf
  - terraform.tfvars

- Terraform working data
  - .terraform/modules/modules.json
  - .terraform/providers/registry.terraform.io/hashicorp/aws/...
  - .terraform/providers/registry.terraform.io/hashicorp/local/...

- Local app
  - app/app.py  -- contains the backend example (prints "Hello from backend!")

- Reusable modules
  - modules/backend-app/
    - main.tf
    - outputs.tf
    - variables.tf
  - modules/load-balancers/
    - main.tf
    - outputs.tf
    - variables.tf
  - modules/proxy/
    - main.tf
    - outputs.tf
    - variables.tf
  - modules/vpc/
    - main.tf
    - outputs.tf
    - variables.tf

Prerequisites
-------------

- Terraform (use the version compatible with the providers in this repo)
- AWS credentials configured (e.g., via AWS CLI or environment variables)
- Optional: Python to run the local example app

Configuration
-------------

Edit ``terraform.tfvars`` to set environment values. Key variables provided in this repo:

- ``aws_region`` (`terraform.tfvars`)
- ``key_name`` (`terraform.tfvars`)

Current example values in ``terraform.tfvars``:

.. code-block:: text

   aws_region = "us-east-1"
   key_name  = "vockey"

See variable definitions in ``variables.tf``.

Quick start
-----------

1. Initialize Terraform:

.. code-block:: sh

   terraform init

2. Validate and plan:

.. code-block:: sh

   terraform validate
   terraform plan -var-file=terraform.tfvars

3. Apply:

.. code-block:: sh

   terraform apply -var-file=terraform.tfvars

4. Inspect outputs:

.. code-block:: sh

   terraform output

5. Run the local example app:

.. code-block:: sh

   python app/app.py

Notes
-----

- Module source and interfaces are under ``modules/``.
- Provider plugin binaries and module cache are stored in ``.terraform/``.
- Inspect module inputs/outputs in the module files linked above.

Useful files
------------

- Root configuration: ``main.tf``, ``providers.tf``, ``variables.tf``, ``outputs.tf``, ``terraform.tfvars``
- Modules: files under ``modules/``
- Local app: ``app/app.py``

Outputs and local helpers
------------------------

The repository contains resources that emit useful outputs. For example, the root ``outputs.tf`` includes:

- ``public_alb_dns`` — Public ALB DNS name
- ``proxy_public_ips`` — Public IPs of proxy instances
- ``backend_private_ips`` — Private IPs of backend instances
- ``all_ips_file`` — Path to the generated IPs file (``all-ips.txt``)

License / Attribution
---------------------

(Keep or add license information here if desired.)
