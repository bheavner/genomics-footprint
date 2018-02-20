# Transcription factor binding site atlas: A case study in reproducible big data science

- **Followings are the supplementary information that these directories contain workflows and scripts used to generate DNase footprints, TF binding motifs, and databases. Step numbers and dataset numbers follow the convention used in the paper.**


   - Steps 1-3 generating datasets D1-3
     - [generate_footprints](https://github.com/globusgenomics/genomics-footprint/tree/master/generate_footprints) - This generate_footprints provide an instruction for how to run the DNAse footprinting workflow and include a demo snapshot.

   - Step 4 generating D5
     - [generate_motif](https://github.com/globusgenomics/genomics-footprint/tree/master/generate_motif) - This generate_motif directory is a guideline if one needs to create transcription factor motifs. The motif file is used for annotating  the footprints.

   - Step 5 generating D6
     - [generate_db](https://github.com/globusgenomics/genomics-footprint/tree/master/generate_db) - The generate_db directory shows a step-by-step procedure along with the processing code to intersect hint or wellington footprints output with the FIMO database and save the output in a local directory and optionally to put the results in a database.
     
- [getting_started](https://github.com/globusgenomics/genomics-footprint/tree/master/getting_started) - This getting_started shows how to access the footprint databases and provides a case example for query.
