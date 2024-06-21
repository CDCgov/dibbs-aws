# Table of Contents
[1. Overview](#1-overview)\
[2. Notices](#2-notices)
  - [2.1 Public Domain Standard Notice](#21-public-domain-standard-notice)
  - [2.2 License Standard Notice](#22-license-standard-notice)
  - [2.3 Privacy Standard Notice](#23-privacy-standard-notice)
  - [2.4 Contributing Standard Notice](#24-contributing-standard-notice)
  - [2.5 Records Management Standard Notice](#25-records-management-standard-notice)
  - [2.6 Additional Standard Notices](#26-additional-standard-notices)

[3. Architectural Design](#3-architectural-design)\
[4. Getting Started](#4-getting-started)
  - [4.1 Requirements](#41-requirements)
  - [4.2 Clone DIBBS-AWS Repository](#42-clone-dibbs-aws-repository)
  - [4.3 Begin Using Repository](#43-begin-using-repository)
  - [4.4 Make A New Branch](#44-make-a-new-branch)
  - [4.5 Amendments To Your Local Branch](#45-amendments-to-your-local-terraform)
  - [4.6 Running Code Locally](#46-running-code-locally)
  - [4.7 Review Prospective Changes](#47-review-prospective-changes)
  - [4.8 Apply Changes](#48-apply-changes)

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

![Current DIBBS Architecture 6-14-2024](https://github.com/CDCgov/dibbs-aws/assets/29112142/d6b9066c-a304-403a-bf50-f349b5c2502f)

The final architectural design encompasses the elements in the following:
![Future DIBBS Architecture](https://github.com/CDCgov/dibbs-aws/assets/29112142/4ea4b871-67c3-43cb-9444-4cccbd07338a)

Please note the final architectural design may change.

+ [Return to Table of Contents](#table-of-contents).


# 4. Getting Started
This section will assist engineers with executing Infrastructure as Code (IaC) found in the _dibbs-aws_ repository utilizing Terraform.  

[Return to Table of Contents](#table-of-contents).

## 4.1 Requirements
Engineers will need following tools installed on their local machine:
* Terraform version 1.0.0+  [_See_ Hashicorp installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* AWS CLI version 2+ [_See_ AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/v1/userguide/cli-chap-install.html)
* AWS Profile Access \
-- <u>Note</u>: Engineers *must* have access and permissions to create AWS resources

[Return to Table of Contents](#table-of-contents).

## 4.2 Clone DIBBS-AWS Repository

<em><strong>4.2.1.</em></strong> Create a directory to store the repository on your local machine
- Mac OS users: `mkdir workspace`
- Windows users: `md workspace`
<em><strong>4.2.2.</em></strong> Clone the dibbs-aws repository (<u>use one of the following commands</u>:)
- `git clone git@github.com:CDCgov/dibbs-cloud.git` 
- `git clone https://github.com/CDCgov/dibbs-cloud.git`

[Return to Table of Contents](#table-of-contents).

## 4.3 Begin Using Terraform

<em><strong>4.3.1.</em></strong> Navigate to terraform/implementation.\
&ensp; Initialize your local terraform code. `terraform init`\
<em><strong>4.3.2.</em></strong> Developing in a terraform workspace.\
&ensp; Check the terraform workspaces. `terraform workspace list`\
&ensp; _Note_: If you only have a default terraform workspace, you can create a terraform workspace to develop in.  _Skip to "Create a terraform workspace to develop in," below_.
- <u>Select the terraform workspace to develop in</u>.\
 &ensp; `terraform workspace select {selectEnvironmentName}`\
 &ensp; For example, `terraform workspace select dev`.\
- <u>Create a terraform workspace to develop in</u>.\
&ensp; `terraform workspace new {newEnvironmentName}`.\
&ensp; For example, `terraform workspace new dev`.

[Return to Table of Contents](#table-of-contents).

## 4.4 Make A New Branch
Make a new branch to store any of your amendments to ensure you keep a clean main (or master) branch clear from unapproved revisions.

<em><strong>4.4.1.</em></strong> Navigate to the `dibbs-aws` repository on your local machine.\
&ensp; `cd /workspace/dibbs-aws`\
<em><strong>4.4.2.</em></strong> Make a new branch.\
&ensp; For example, `git checkout -b update–and-setup-dibbs-aws-backend`.\

[Return to Table of Contents](#table-of-contents).

## 4.5 Amendments to Your Local Terraform

This section will go over some of the sections you will need to amend or change in your local terraform branch.

<em><strong>4.5.1. Update Terraform Code</em></strong>
* Navigate to the _terraform/implementation/ecs/_variable.tf_ file.  Update default values with your unique team or project name.  _For example_, locate the `owner` variable and change the default value from `dibbs` to your unique team or project name (i.e. _stilt-stateNameAbbreviation_, _stilt-WA_, etc.).
* Alternatively, you can create an _override.tf_ file to override any default values in this repo.  See Hashicorp's [Override Files](https://developer.hashicorp.com/terraform/language/files/override) documentation for additional information.

<em><strong>4.5.2. Validate Changes</em></strong>
* Run `terraform validate` to ensure the new configurations are valid before you proceed.  Resolve any conflicts.  If there are no conflicts, move to 4.5.3.

<em><strong> 4.5.3. Save Changes</em></strong>
* Save changes to your working branch.


<em><strong>4.5.4. Commit Changes</em></strong>
*You can commit your changes prior to running a terraform plan.  
&ensp; `git add terraform/implementation/ecs/var.tf`\
&ensp; `git commit -m "update terraform default dibbs values to [insertValue]"`\
&ensp; `git push`

[Return to Table of Contents](#table-of-contents).


## 4.6 Running Code Locally
<em><strong>4.6.1. Run ECS Module Changes Locally</em></strong>
* To run your ECS Module Changes locally, navigate to _terraform/implementation/ecs/_.
* In your command line or editor terminal run `ecs.sh development`.

[Return to Table of Contents](#table-of-contents).

## 4.7 Review Prospective Changes
<em><strong>4.7.1. Run Terraform Plan</em></strong>
* Run `terraform plan` to see what resources will be created with the amendments you created in section 4.5.
* Resolve any conflicts that may arise.  _For example_, target group names can only be 13 characters long.  So, if you receive an error for the target group name above the limit, you may need to revise the target group name to satisfy this requirement.  Once you have made the necessary changes, run `terraform validate` then `terraform plan` again.
* Review the plan and ensure things look correct before moving to 4.8.  

[Return to Table of Contents](#table-of-contents).

## 4.8 Apply Changes
<em><strong>4.8.1. Run Terraform Apply</em></strong>
* Run `terraform apply` to officially create the necessary resources using Terraform.
* You will first receive a plan.  Review the plan to ensure it is consistent to the changes you would like to make.  
* If the plan is correct, type `yes` to apply your terraform changes.

[Return to Table of Contents](#table-of-contents).
