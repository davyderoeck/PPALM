# Power Platform Application Lifecycle Management
This repository contains a sample build and release pipeline for Power Platform and Dynamics 365 solutions to be used with Microsoft DevOps.

## Build pipelines
### 1. Export MS Solution into Git
The first pipeline is called __1. Export MS Solution into Git__ and is a build pipeline.
This pipeline is actually an on-demand or manual run pipeline that can been exectured by the developper, each time a solution is ready to get exported out of the power platform into the Git Repository.
It is typically connected with a *dev*-branch, linked to the developper and used to store the changes/content of a solution before actually been approved and merged with the global or main content.

The pipeline will execture the following steps:

1. Power Platform Tool Installer
1. Power Platform Set Solution Version 
1. Power Platform Export Solution 
1. Configure GIT repo
1. Power Platform Unpack Solution 
1. Power Platform Unpack Solution 
1. Unmanaged package for *solution.name*
1. Publish Artifact: Unmanaged Solution

### 2. Deploy MS Solution from Git
This second pipeline is called __2. Deploy MS Solution from Git__ and is a build pipeline. This pipeline is automated pipeline connected with the release branch or any branch that will contain the solution code repository that is ready to get repackaged and deployed into a release pipeline.

The pipeline will execture the following steps:

1. Power Platform Tool Installer
1. Power Platform Pack Solution
1. PowerShell Script *(inline)*
1. Universal publish
1. Publish Artifact: solutions

## Release pipeline
### 1. Export MS Solution into Git
This release pipeline is called __3. Package Deployment__ and it is started after completing the second build pipeline.
During start it will contain an artifact called **drop**, containing the unmanaged solution needed into the release cycle.
The pipeline contains already 3 stages and can been adjusted further based on the customer needs and expectations.
The actual stages already included are:
1. **Prepare**: Stage needed to figure out the solution name from the artifact, as we want this pipeline as dynamic as possible. This stage contains only 1 step and this only Step is:
    1. Get Solution Zip FileName (Inline)
1. **Buld**: Stage needed to convert the initial unmanaged solution into a managed solution. It will been using a *build* or *staging* environment only used to convert unmanaged into managed solution. This stage contains the following 9 steps:
    1. Power Platform Tool Installer 
    1. Power Platform Delete Solution 
    1. Power Platform Import Solution 
    1. Power Platform Publish Customizations 
    1. Power Platform Export Solution 
    1. Power Platform Unpack Solution 
    1. Get Version Script
    1. Set Environment Variable Script
    1. Universal publish
1. **Deploy**: Stage that can do the actual import of an unmanaged solution into *any* environment. In the sample file provided, the actual import isn't included yet. The 2 steps included are the minimal steps needed to **get** the managed solution with the correct version into the stage. Those 2 steps are:
    1. Download Package *solution.name*_managed.zip
    1. Power Platform Tool Installer 

## Scripts
There are 2 scripts included into the pipeline that are provided as file instead of inline. There are normally placed within the repository that are mapped and linked to the build-pipelines.
The scripts are:
1. **checkin_build.bat**: This batch file will do the actual checking and commit of the unpacked content into the repository.
1. **prepare_build.bat**: This batch file will set the global git username and email address  based on the user information of the user that actually exectured the first build pipeline. This user information is used to associated with the commits on the repositories. It also prepare the local source control repository and checkout the current *DEV* branch. 

## Artifacts
During the pipelines, different artifact locations are used.  

1. __DEV_solutions__: Used to store the actual exported solution coming from the developpers environments during the first build-pipeline.
1. __GIT_solutions__: Used to store the repackaged solutions from the second build pipeline. Those solutions normally never has been exported out of environment and are build from within source code after a pull request into a release branch
1.  __BLD_solutions__: Used in the release pipeline to convert the unmanaged solution into a managed solution and before installing into a test, acceptance or production environment. 