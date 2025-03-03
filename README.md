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
  - [4.1 Requirements](#41-requirements)
  - [4.2 Clone DIBBS-AWS Repository](#42-clone-dibbs-aws-repository)
  - [4.3 Begin Using Terraform](#43-begin-using-terraform)
  - [4.4 Make A New Branch](#44-make-a-new-branch)
  - [4.5 Update Terraform Through The Command Line](#45-update-terraform-through-the-command-line)
  - [4.6 Run Terraform Code In Your Designated Environment](#46-run-terraform-code-in-your-designated-environment)
  - [4.7 Validate Your Terraform Changes](#47-validate-your-terraform-changes)
  - [4.8 Review Prospective Changes](#48-review-prospective-changes)
  - [4.9 Apply Changes](#49-apply-changes)
  - [4.10 Update Variables](#410-update-variables)
  

# 1. Overview

The Data Integration Building Blocks (DIBBs) project is an effort to help state, local, territorial, and tribal public health departments better make sense of and utilize their data. You can read more about the project on the [main DIBBs repository](https://github.com/CDCgov/phdi/blob/main/README.md).

This repository is specifically to develop an AWS "starter kit" for the DIBBs project. This will enable our jurisdictional partners to build from this repository to provision their own AWS infrastructure.

+ [Return to Table of Contents](#table-of-contents).

# 2. Notices
## 2.1 Public Domain Standard Notice
This repository constitutes a work of the United States Government and is not
subject to domestic copyright protection under 17 USC § 105. This repository is in
the public domain within the United States, and copyright and related rights in
the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
All contributions to this repository will be released under the CC0 dedication. By
submitting a pull request you are agreeing to comply with this waiver of
copyright interest.


+ [Return to Table of Contents](#table-of-contents).

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


+ [Return to Table of Contents](#table-of-contents).

## 2.3 Privacy Standard Notice
This repository contains only non-sensitive, publicly available data and
information. All material and community participation is covered by the
[Disclaimer](DISCLAIMER.md)
and [Code of Conduct](code-of-conduct.md).
For more information about CDC's privacy policy, please visit [http://www.cdc.gov/other/privacy.html](https://www.cdc.gov/other/privacy.html).


+ [Return to Table of Contents](#table-of-contents).

## 2.4 Contributing Standard Notice
Anyone is encouraged to contribute to the repository by [forking](https://help.github.com/articles/fork-a-repo)
and submitting a pull request. (If you are new to GitHub, you might start with a [basic tutorial](https://help.github.com/articles/set-up-git).) By contributing to this project, you grant a world-wide, royalty-free, perpetual, irrevocable, non-exclusive, transferable license to all users under the terms of the [Apache Software License v2](http://www.apache.org/licenses/LICENSE-2.0.html) or later.

All comments, messages, pull requests, and other submissions received through
CDC including this GitHub page may be subject to applicable federal law, including but not limited to the Federal Records Act, and may be archived. Learn more at [http://www.cdc.gov/other/privacy.html](http://www.cdc.gov/other/privacy.html).


+ [Return to Table of Contents](#table-of-contents).

## 2.5 Records Management Standard Notice
This repository is not a source of government records, but is a copy to increase collaboration and collaborative potential. All government records will be published through the [CDC web site](http://www.cdc.gov).

+ [Return to Table of Contents](#table-of-contents).

## 2.6 Additional Standard Notices
Please refer to [CDC's Template Repository](https://github.com/CDCgov/template) for more information about [contributing to this repository](https://github.com/CDCgov/template/blob/main/CONTRIBUTING.md), [public domain notices and disclaimers](https://github.com/CDCgov/template/blob/main/DISCLAIMER.md), and [code of conduct](https://github.com/CDCgov/template/blob/main/code-of-conduct.md).


+ [Return to Table of Contents](#table-of-contents).

# 3. Architectural Design
The current architectural design for dibbs-aws is as follows:

![Current DIBBS Architecture as of 6-24-2024](https://github.com/CDCgov/dibbs-aws/assets/29112142/7d43d3c1-5d61-41b8-a1c3-bb4884073825)

+ [Return to Table of Contents](#table-of-contents).


# 4. Getting Started
This section will assist engineers with executing Infrastructure as Code (IaC) found in the _dibbs-aws_ repository utilizing Terraform.  

[Return to Table of Contents](#table-of-contents).

## 4.1 Requirements
Engineers will need following tools installed on their local machine:
* Terraform version 1.0.0+  [_See_ Hashicorp installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* AWS CLI version 2+ [_See_ AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/v1/userguide/cli-chap-install.html)
* AWS Profile Access \
-- <u><em><strong>Note</u></em></strong>: Engineers *must* have access and permissions to create AWS resources

[Return to Table of Contents](#table-of-contents).

## 4.2 Clone DIBBS-AWS Repository

<em><strong>4.2.1.</em></strong> Create a directory to store the repository on your local machine
- Mac OS users: `mkdir workspace`
- Windows users: `md workspace`

<em><strong>4.2.2.</em></strong> Clone the dibbs-aws repository (<u>use one of the following commands</u>:)\
&nbsp;&nbsp;&nbsp;&nbsp;`git clone git@github.com:CDCgov/dibbs-cloud.git` <br />  &nbsp;&nbsp;&nbsp;&nbsp;`git clone https://github.com/CDCgov/dibbs-cloud.git`

[Return to Table of Contents](#table-of-contents).

## 4.3 Begin Using Terraform

<em><strong>4.3.1.</em></strong> Navigate to terraform/implementation.\
&ensp; Initialize your local terraform code. `terraform init`\
<em><strong>4.3.2.</em></strong> Developing in a terraform workspace.\
&ensp; Check the terraform workspaces. `terraform workspace list`\
&ensp; <u><em><strong>Note</u></em></strong>: If you only have a default terraform workspace, you can create a terraform workspace to develop in.  _Skip to "Create a terraform workspace to develop in," below_.
- <u>Select the terraform workspace to develop in</u>.\
 &ensp; `terraform workspace select {selectEnvironmentName}`\
 &ensp; For example, `terraform workspace select dev`.
- <u>Create a terraform workspace to develop in</u>.\
&ensp; `terraform workspace new {newEnvironmentName}`.
&ensp; For example, `terraform workspace new dev`.

[Return to Table of Contents](#table-of-contents).

## 4.4 Make A New Branch
Make a new branch to store any of your amendments to ensure you keep a clean main (or master) branch clear from unapproved revisions.

<em><strong>4.4.1.</em></strong> Navigate to the `dibbs-aws` repository on your local machine.\
&ensp; `cd /workspace/dibbs-aws`\
<em><strong>4.4.2.</em></strong> Make a new branch.\
&ensp; For example, `git checkout -b setup-dibbs-aws-backend-and-services`.

[Return to Table of Contents](#table-of-contents).

## 4.5 Update Terraform Through The Command Line

This section will go over some of the sections you will need to amend or change in your local terraform branch.

<em><strong>4.5.1. Update And Setup Your AWS Backend</em></strong>
* In your terminal, navigate to the _/terraform/setup_ folder (`cd /terraform/setup`).  
* Run `./setup.sh`.

&nbsp;&nbsp;&nbsp;&nbsp;<u><em><strong>Note</em></strong></u>: You will be prompted to set your variable values (i.e. *Region*, *Owner*, *Project*, etc.).  For example, the default value for *Owner* is `Skylight`. You can change this value to one that represents your organization or department.  _The Owner name <u>must</u> be <u>less than</u> 13 characters_.

The setup.sh scripts will assist you with creating the terraform state and tfvars files, as well as check to ensure the necessary arguments or variables were created.  See [setup.sh](https://github.com/CDCgov/dibbs-aws/blob/main/terraform/implementation/setup/setup.sh) file.  Also see [Inputs](https://github.com/CDCgov/dibbs-aws/blob/main/terraform/implementation/setup/README.md#inputs).

The setup.sh script will create the following files:

- _.tfvars_
- _.env_ (will need to be created manually if prompted)
- _terraform.state_


<em><strong> 4.5.2. Check What Files Changed</em></strong>
* Run `git status` to see what changes have changed.

<em><strong> 4.5.3. Save Changes</em></strong>
* Save and commit changes to your working branch.

[Return to Table of Contents](#table-of-contents).

## 4.6 Run Terraform Code In Your Designated Environment
<em><strong>4.6.1. Run ECS Module Locally</em></strong>
* It is highly recommended to create a new directory per environment that is launched, to do so run `cp terraform/implementation/ecs terraform/implementation/{insertEnvironmentName}`.
* To run your ECS Module Changes in your local terminal, navigate to your working directory, ` cd terraform/implementation/ecs/` or `cd terraform/implementation/{insertEnvironmentName}`
* In your terminal run the deploy script for your designated environment `./deploy.sh -e {insertEnvironmentName}`.\
&nbsp;&nbsp;&nbsp;&nbsp;<u><em><strong>Note</em></strong></u>: The _-e_ tag stands for environment and you can specify `dev`, `stage`, `prod`, this can match your environment naming convention.
&nbsp;&nbsp;&nbsp;&nbsp;or whatever environment your team desires.

[Return to Table of Contents](#table-of-contents).

## 4.7 Validate Your Terraform Changes

<em><strong>4.7.1. Validate Changes</em></strong>
* Run `terraform validate` to ensure the new configurations are valid.
* If you receive a `success`, then move to 4.8.

[Return to Table of Contents](#table-of-contents).

## 4.8 Review Prospective Changes
<em><strong>4.8.1. Run Terraform Plan</em></strong>
* Run `terraform plan` to see what resources will be created with the amendments you created in section 4.5.
* Resolve any conflicts that may arise.  _For example_, target group names can only be 13 characters long.  So, if you receive an error for the target group name above the limit, you may need to revise the target group name to satisfy this requirement.  Once you have made the necessary changes, run `terraform validate` then `terraform plan` again.
* Review the plan and ensure things look correct before moving to 4.9.  

[Return to Table of Contents](#table-of-contents).

## 4.9 Apply Changes
<em><strong>4.9.1. Run Terraform Apply</em></strong>
* Run `terraform apply` to officially create the necessary resources using Terraform.
* You will first receive a plan.  Review the plan to ensure it is consistent to the changes you would like to make.  
* If the plan is correct, type `yes` to apply your terraform changes.

[Return to Table of Contents](#table-of-contents).

## 4.10 Update Variables
<em><strong>4.10.1. Update Other Default Variables</em></strong>
* Navigate to the _defaults.tfvars_ file ` cd terraform/implementation/ecs/` or `cd terraform/implementation/{insertEnvironmentName}`.
* In this _defaults.tfvars_ file, you can update and override any other default values.

<em><strong>4.10.2. Test and Validate Your Changes</em></strong>
* Save your changes.
* Run `terraform init`.
* Validate your changes `terraform validate`.
* If no errors, run `terraform plan` to see what changes will result.
* Then run `terraform apply`.  Fix any issues that may result until your apply is successful.
* Save, commit and push your changes to your github repository for your team to review.

[Return to Table of Contents](#table-of-contents).