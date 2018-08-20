
Our goal is to provide a set of instructions that enable a reader to evaluate the FAIRness (Findability, Accessibility, Interoperability and Reusabiblity) of the data and analysis presented in the manuscript titled ["Reproducible big data science: A case study in continuous FAIRness"](https://www.biorxiv.org/content/early/2018/06/20/268755) using a representative data sample of urinary bladder from the [ENCODE[(www.encodeproject.org) project. 

# Evaluation of FAIRness 
We leveraged technologies like the BDBag to define a dataset and its contents by enumerating its elements, regardless of their location (enumeration, fixity, and distribution); the Research Object (RO) to characterize a dataset and its contents with arbitrary levels of detail, regardless of their location (description); and the Minid to uniquely identify a dataset and, if desired, its constituent elements, regardless of their location (identify, fixity). Table 2 and Table 3 from the manuscript provide a list of all minids created and used for generation of Atlas of Transcription Factor Binding Sites (TFBS). As an example, we provide the minid of the urinary bladder tissue here: [ark:/57799/b9ft3h](http://minid.bd2k.org/minid/landingpage/ark:/57799/b9ft3h). When you click on the link, it will take you to the landing page of the urinary bladder tissue data as shown in the screenshot below:

![Screenshot](generate_footprints/urinary_bladder_new.png)

By clicking on the link under Locations, one can download the BDBag of urinary bladder data. Using BDBag tools, a user can download the raw BAM files. These are the same tools we have used in the following steps to download the raw data to Globus Genomics, perform analysis and generate results. 

The results of generating footprints using two algorithms, hint and wellington are describbed in the subsequent steps. These steps take several hours to complete. The results of the analysis of footprints from urinary bladder input data is accessible from [ark:/57799/b9h38s](http://minid.bd2k.org/minid/landingpage/ark:/57799/b9h38s). The [R notebook](http://footprints.bdds.globusgenomics.org) demonstrates how the generated atlas of TFBS can be reused, thus demonstrating the four attributes of digital objects that are often viewed as fundamental to data-driven discovery.

In the subsequent sections, the reader can use the urinary bladder identifier to run the footprints workflows in Globus Genomics to generate footprints from Hint and Wellington algorithms.

# Generate Footprints

Here we describe how one can generate footprints for a tissue using a MINID as input for the desired tissue type.
Generating footprints requires running a workflow via https://bdds.globusgenomics.org which integrates a number of sub-workflows as shown in figure below to generate alignment files for all replicates in patients; then merging replicate alignment files for a patient to a single alignment file; finally, calling the footprint algorithms for each patient (i.e. Wellington, Hint).

Each step of the process will be laid out such that any user logged on to the system should be able to re-generate the footprints for a tissue type. Due to the high amount of computation used, we will supply a test MINID as input.

## Table of Contents

- [Screenshot of Workflow](#screenshot-of-workflow)
- [Test MINID](#test-MINID)
- [Process steps](#process-steps)
    - [Log on to BDDS Globus Genomics](#log-on-to-bdds-globus-genomics)
    - [Generate API Key](#generate-api-key)
    - [Import published workflows](#import-published-workflows)
    - [Execute analysis](#execute-analysis)
    - [Results](#results)

## Screenshot of Workflow

The workflow consists of one master workflow which manages the sub-workflows. The input to the master workflow is the MINID for the tissue type you wish to generate footprints for. The MINIDs represent a BDbag for the tissue type which contains the DNAse data from the ENCODE database. These MINIDs and BDbags have been previously generated. The red box in the master workflow submits in parallel the alignment sub-workflow for each patient in the tissue type. Each patient may contain 1 to many replicates, thus, each replicate must be individually aligned and sorted (gray box). Once the replicates for a patient are aligned, they are merged to a single alignment file representing a patient. When all merged patient alignemnt files are completed (red box) an alignemnts BDbag is generated and used as input to generate the footprints (green box).

![Screenshot](generate_footprints/Figure5c.png)

## Test MIND

We provide a MINID for the Urinary bladder tissue type. Although this tissue type is small, footprint search and generation process may take several hours. The MINID for urinary bladder is: ark:/57799/b9ft3h

![Screenshot](generate_footprints/urinary_bladder_new.png)

## Process steps

Follow along each step to launch the footprint generation master workflow.

### Log on to BDDS Globus Genomics

Users will need to log on to https://bdds.globusgenomics.org. Globus Genomics using Globus for authentication and Authorization. If you don't have a Globus account, you can create one from www.globus.org or log into Globus using your institutional account. We created a Globus Group that controls access to the BDDS Globus Genomics service. Users can become members of the group by clicking here: https://www.globus.org/app/groups/6f9dd64a-a22c-11e8-95d8-0efa7862ab5c. Please note that only users with access to the instance will be allowed to submit and run workflows. 

### Generate API Key

Once logged in, if this is the first time you are logging in or submitting the Footprints workflow and have not generated an API key before, you will need to create one now. If you already have an API key for the https://bdds.globusgenomics.org, then you can skip this step.

 1) Click on the "User" menu item in the top of the page:

 ![Screenshot](generate_footprints/user_menu.png)

 2) Click on the "Preferences" sub-menu item:

 ![Screenshot](generate_footprints/preferences_submenu.png)

 3) Select the "Manage API key" item in the next page:

 ![Screenshot](generate_footprints/manage_api_key.png)

 4) If you do not have an API key, "None" will be shown in your landing page. You can click the "Create new key" button and one will be generated and shown to you in the screen.

 ![Screenshot](generate_footprints/generate_api_key.png)

 5) You can go back to the main page at: https://bdds.globusgenomics.org

### Import published workflows

Next you will need to import all needed workflows into your environment. If you have previously imported these workflows, you do not need to import them again.

NOTE - If you modify any of the workflows or rename the workflows you import, there is a strong possibility that your submission will not work. If you would like to modify a workflow and generate a new set of workflows with different tools or parameters, please contact us at support@globus.org.

You will need import each of the following workflows:

 * [Footprints MASTER Workflow]( https://bdds.globusgenomics.org/u/arodri1215/w/copy-of-imported-footprints-master-workflow-4)
 * [SNAP_BAG_MASTER_v.1.1.0](https://bdds.globusgenomics.org/u/arodri1215/w/copy-of-snapbagmasterv100)
 * [DNAse-footprints-singlesample-bamInput_wellington_hint]( https://bdds.globusgenomics.org/u/arodri1215/w/imported-dnase-footprints-singlesample-baminputwellingtonhint)
 * [snap_from_minid_bag]( https://bdds.globusgenomics.org/u/arodri1215/w/snapfromminidbag)

For each workflow in the list above, follow these steps to import to your environment:

 1) Click on the workflow's link (above i.e. "Footprints MASTER Workflow")
 2) Select the "Import workflow" icon (green + icon)

 ![Screenshot](generate_footprints/import_workflows.png)

### Execute analysis

If you have completed the above required steps, you should be able to execute the analysis. The analysis can take a few hours to download the data for the MINID, perform alignment and generate footprints for each of the patients and its replicates of the tissue type.

 1) Go to your [workflow environment page](https://bdds.globusgenomics.org/workflow)
 2) You should see at least 4 workflows which you have imported:

 ![Screenshot](generate_footprints/list_of_workflows.png)

 3) Select "Run" option for the workflow "imported: Footprints MASTER Workflow"

 ![Screenshot](generate_footprints/master_workflow_run_option.png)

 4) Click on the "Run workflow" option. The MINID has been entered for you.

 ![Screenshot](generate_footprints/master_workflow_execute.png)

That is all you need to do. You should now see a series of jobs appear in your history panel. These jobs are getting queued up and will start running as soon as resources become available. Once the items in the history become green, your data will have been generated.

### Results

The output for the master workflow is a BDbag for the tissue type used as input. The output contains the footprints generated in the workflow. The BDbag and MINID for the sample submitted in this README file can be located at: ark:/57799/b9h38s

![Screenshot](generate_footprints/bdds_minid_urinary_bladder_footprints.png)

## Generating D5 (transcription factor motif file that is used for annotating the footprints 
[Instructions](https://github.com/globusgenomics/genomics-footprint/tree/master/generate_motif) 

## Instructions to intersect hint or wellington footprints output with the FIMO database
[Here](https://github.com/globusgenomics/genomics-footprint/tree/master/generate_db)
     
# Survey
After going through the instructions, please provide your feedback through the survey here: https://goo.gl/forms/Ag35eRlgiXithlx43
