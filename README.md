# Table of Contents
- [Table of Contents](#table-of-contents)
- [1. Overview](#1-overview)
- [2. Notices](#2-notices)
  - [2.1 Public Domain Standard Notice](#21-public-domain-standard-notice)
  - [2.2 License Standard Notice](#22-license-standard-notice)
  - [2.3 Privacy Standard Notice](#23-privacy-standard-notice)
  - [2.4 Contributing Standard Notice](#24-contributing-standard-notice)
  - [2.5 Records Management Standard Notice](#25-records-management-standard-notice)
  - [2.6 Additional Standard Notices](#26-additional-standard-notices)
- [3. Architectural Design](#3-architectural-design)
- [4. Getting Started](#4-getting-started)
  - [4.1.0 Requirements](#410-requirements)
  - [4.1.1 Terraform documentation](#411-terraform-documentation)
  - [4.2 Helper Scripts](#42-helper-scripts)
  - [4.3 Modules used in this repository](#43-modules-used-in-this-repository)
  - [4.4 Development Workflow](#44-development-workflow)
  

# 1. Overview

The Data Integration Building Blocks (DIBBs) project is an effort to help state, local, territorial, and tribal public health departments better make sense of and utilize their data. You can read more about the project on the [main DIBBs eCR Viewer repository](https://github.com/CDCgov/dibbs-ecr-viewer/blob/main/README.md).

This repository is specifically to develop an AWS "starter kit" for the DIBBs project. This will enable our jurisdictional partners to build from this repository to provision their own AWS infrastructure. 

This repository is actively used by the DIBBs eCR Viewer team to deploy and test their application in AWS.

+ [Return to Table of Contents](#table-of-contents)

# 2. Notices
## 2.1 Public Domain Standard Notice
This repository constitutes a work of the United States Government and is not
subject to domestic copyright protection under 17 USC § 105. This repository is in
the public domain within the United States, and copyright and related rights in
the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
All contributions to this repository will be released under the CC0 dedication. By
submitting a pull request you are agreeing to comply with this waiver of
copyright interest.


+ [Return to Table of Contents](#table-of-contents)

## 2.2 License Standard Notice
The repository utilizes code licensed under the terms of the Apache Software
License and therefore is licensed under ASL v2 or later.

This source code in this repository is free: you can redistribute it and/or modify it under
the terms of the Apache Software License version 2, or (at your option) any
later version.

This source code in this repository is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the Apache Software License for more details.

You should have received a copy of the Apache Software License along with this
program. If not, see http://www.apache.org/licenses/LICENSE-2.0.html.

The source code forked from other open source projects will inherit its license.


+ [Return to Table of Contents](#table-of-contents)

## 2.3 Privacy Standard Notice
This repository contains only non-sensitive, publicly available data and
information. All material and community participation is covered by the
[Disclaimer](DISCLAIMER.md)
and [Code of Conduct](code-of-conduct.md).
For more information about CDC's privacy policy, please visit [http://www.cdc.gov/other/privacy.html](https://www.cdc.gov/other/privacy.html).


+ [Return to Table of Contents](#table-of-contents)

## 2.4 Contributing Standard Notice
Anyone is encouraged to contribute to the repository by [forking](https://help.github.com/articles/fork-a-repo)
and submitting a pull request. (If you are new to GitHub, you might start with a [basic tutorial](https://help.github.com/articles/set-up-git).) By contributing to this project, you grant a world-wide, royalty-free, perpetual, irrevocable, non-exclusive, transferable license to all users under the terms of the [Apache Software License v2](http://www.apache.org/licenses/LICENSE-2.0.html) or later.

All comments, messages, pull requests, and other submissions received through
CDC including this GitHub page may be subject to applicable federal law, including but not limited to the Federal Records Act, and may be archived. Learn more at [http://www.cdc.gov/other/privacy.html](http://www.cdc.gov/other/privacy.html).


+ [Return to Table of Contents](#table-of-contents)

## 2.5 Records Management Standard Notice
This repository is not a source of government records, but is a copy to increase collaboration and collaborative potential. All government records will be published through the [CDC web site](http://www.cdc.gov).

+ [Return to Table of Contents](#table-of-contents)

## 2.6 Additional Standard Notices
Please refer to [CDC's Template Repository](https://github.com/CDCgov/template) for more information about [contributing to this repository](https://github.com/CDCgov/template/blob/main/CONTRIBUTING.md), [public domain notices and disclaimers](https://github.com/CDCgov/template/blob/main/DISCLAIMER.md), and [code of conduct](https://github.com/CDCgov/template/blob/main/code-of-conduct.md).


+ [Return to Table of Contents](#table-of-contents)

# 3. Architectural Design
The current architectural design for dibbs-aws is as follows:

![Current DIBBS Architecture as of 6-24-2024](https://github.com/CDCgov/dibbs-aws/assets/29112142/7d43d3c1-5d61-41b8-a1c3-bb4884073825)

+ [Return to Table of Contents](#table-of-contents)


# 4. Getting Started
This section will assist engineers with executing Infrastructure as Code (IaC) found in the _dibbs-aws_ repository utilizing Terraform.  

[Return to Table of Contents](#table-of-contents)

## 4.1.0 Requirements
**Engineers will need following tools installed on their local machine:**
* Terraform version 1.0.0+  [Hashicorp installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
  * [Terraform Documentation](#411-terraform-documentation)
* AWS CLI version 2+ [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/v1/userguide/cli-chap-install.html)
* AWS Profile Access

_**Note**_: Engineers *must* have access and permissions to create AWS resources

## 4.1.1 Terraform documentation
* If you havn't used terraform before, and have the will to learn, please visit these resources before continuing.
  - Terraform Documentation: The official Terraform documentation is an exhaustive resource that covers everything from installation to advanced topics. https://developer.hashicorp.com/terraform/docs
  - Terraform/AWS Intro: HashiCorp provides an official tutorial that covers the basics of Terraform and helps you get started with deploying infrastructure into AWS. https://developer.hashicorp.com/terraform/tutorials/aws-get-started
  - Terraform AWS Provider Documentation: If you're using Terraform with AWS, this documentation provides detailed information on the available resources and data sources. https://registry.terraform.io/providers/hashicorp/aws/latest/docs
  - Terraform module published by the dibbs-ecr-viewer DevOps teams this repo uses: https://registry.terraform.io/modules/CDCgov/dibbs-ecr-viewer/aws/latest

[Return to Table of Contents](#table-of-contents)

## 4.2 Helper Scripts

**If you are familiar with terraform, have setup a backend, understand terraform deployment workflows, know how to validate terraform, or are otherwise opinionated about how you want to run things, feel free to skip this section**
- We have several helper scripts that will assist you with setting up your AWS backend and deploying your AWS resources. 
- These scripts are located in the **terraform/utilities** folder, the **terraform/implementation/setup** folder and the **terraform/implementation/ecs** folder.
- The **utilities** folder contains scripts that will assist in generating terraform docs, formatting and linting terraform code.
- The **setup.sh** script will assist you with creating the terraform state and .env files to be used later, also sets up OIDC for your GitHub workflows. 
- The **deploy.sh** script will assist you with deploying your ECS module from your development machine.

_**Note**_: It is not recommended to run these scripts without reviewing them and understanding their limitations.

_**Note**_: It is not recommended to use these scripts to automate your terraform deployments, please see the [GitHub workflows](https://github.com/CDCgov/dibbs-aws/tree/main/.github/workflows) for examples on how to do that.

**Terraform validation and docs with `./utils.sh`**
* In your terminal, navigate to the _/terraform/utilities_ folder.
* `cd /terraform/utilities`
* Run `./tfdocs.sh` to generate terraform documentation.
* Run `./tffmt.sh` to validate your terraform code.
* Run `./tflint.sh` to lint your terraform code.
* Run `./utils.sh` to run all utilities.

**Update And Setup Your AWS Backend with `./setup.sh`**
* In your terminal, navigate to the _/terraform/implementation/setup_ folder.
* `cd /terraform/implementation/setup`  
* Run `./setup.sh`

_**Note**_: You will be prompted to set your variable values (i.e. *Region*, *Owner*, *Project*, etc.).  For example, the default value for *Owner* is `Skylight`. You can change this value to one that represents your organization or department. Keep these short and sweet to prevent running into character limits when provisioning AWS resources. _The Owner name <u>must</u> be <u>less than</u> 13 characters_.

The `setup.sh` scripts will assist you with creating the terraform state and tfvars files, as well as check to ensure the necessary arguments or variables were created.  See [setup.sh](https://github.com/CDCgov/dibbs-aws/blob/main/terraform/implementation/setup/setup.sh) file.  Also see [Inputs](https://github.com/CDCgov/dibbs-aws/blob/main/terraform/implementation/setup/README.md#inputs).

The setup.sh script will create the following files:

- _tfstate.tfvars_
- _.env_
- _terraform.state_

**Deploy Your ECS Module with `./deploy`**
* It is highly recommended to create a new directory per environment that is launched, to do so run `cp terraform/implementation/ecs terraform/implementation/<ENVIRONMENT>`.
  * The benefits of doing this reduces the likelyhood of conflicts and allows each environment to run different versions of the same module.
* To run your ECS Module Changes in your local terminal, navigate to your working directory, ` cd terraform/implementation/ecs/` or `cd terraform/implementation/<ENVIRONMENT>`
* In your terminal run the deploy script for your designated environment `./deploy.sh -e <ENVIRONMENT>`.

_**Note**_: The _-e_ tag stands for environment and you can specify `dev`, `test`, `prod`, this can match your `<ENVIRONMENT>` naming convention.
or whatever environment your team desires.

- [Return to Table of Contents](#table-of-contents)

## 4.3 Modules used in this repository

**Modules pulled from the Terraform Registry**
- [terraform-aws-dibbs-ecr-viewer](https://registry.terraform.io/modules/CDCgov/dibbs-ecr-viewer/aws/latest) - This module is used to deploy the eCR Viewer application to AWS.
- [vpc](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest) - This module is used to deploy the VPC for the ECS module.

**Local modules**
- [oidc](./terraform/modules/oidc/README.md) - OIDC module, used to setup OIDC for GitHub workflows
- [tfstate](./terraform/modules/tfstate/README.md) - TFState module, used to setup the terraform state backend and lock table
- [db](./terraform/modules/db/README.md) - Database module, used to setup the database for the ECS module

## 4.4 Development Workflow

**Use the dibbs-aws repository**

1. Select to create your own repo from this template, or fork it to your own repository.
1. Clone the repository to your local machine.
2. Make a new branch for your changes: `git checkout -b <BRANCH>`.
3. Make any changes required by your team to the terraform configurations.
4. Add and commit changes to your working branch: `git add . && git commit -m "Your message here"`.
5. Push your changes to your github repository: `git push origin <BRANCH>`.
6. Open a Pull Request so that your team can review your changes and testing can be done.
7. Go back to step 4 until your changes are approved.
8. Once your changes are approved, merge your changes into the main branch.

**Terrform Commands**

- Please review these docs for specific help understanding and running terraform commands: [Terraform Commands](#41-requirements)

- [Return to Table of Contents](#table-of-contents)
