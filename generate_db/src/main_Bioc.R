#-------------------------------------------------------------------------------
fillAllSamplesByChromosome <- function(chromosome,
                                       dbConnection = db.wellington,
                                       fimo = db.fimo,
                                       minid = "temp.filler.minid",
                                       dbUser = "ben",
                                       dbTable = "testwellington",
                                       sourcePath = wellington.path,
                                       isTest = True,
                                       method = "DEFAULT",
                                       Fill_DB_Enable=FALSE)
{
  all.sampleIDs <- unlist(lapply(strsplit(list.files(sourcePath,
                                                     "ENCSR.*.bed$",ignore.case = TRUE),
                                          ".", fixed=TRUE), "[", 1))

  for(sampleID in all.sampleIDs){
    printf("---- %s (%s) (%d/%d)", sampleID, chromosome,
           grep(sampleID, all.sampleIDs), length(all.sampleIDs))

    if (isTest) {
      # nrow set for testing
      tbl.wellington <- readDataTable(sourcePath, sampleID, nrow = 10,
                                          chromosome, method = method)
    } else {
      tbl.wellington <- readDataTable(sourcePath, sampleID, NA,
                                          chromosome, method = method)
    }
    print("Data table read. Merging with Fimo...")

    # Make a check for the table rows; if there's none, then break the loop
    if(nrow(tbl.wellington) < 1){
        printf("No rows matching %s", chromosome)
        break
    }

    fimo.con <- getDBConnection(fimo)
    tbl <- mergeFimoWithFootprints(tbl.wellington, sampleID,
                                   dbConnection = fimo.con,
                                   method=method)
    dbDisconnect(fimo.con)

    library(data.table)
    dir_path=paste(sourcePath,"/TFBS_OUTPUT",sep="")
    fname=paste(dir_path,"/",db.wellington,".",sampleID,".",chromosome,".csv",sep="")
    fwrite(tbl,fname, sep=",")


    #-----------------------------------------------------------------------------------------------
    # Below is to fill database with the data so please uncomment if that's what you want.
    #-----------------------------------------------------------------------------------------------

    if (Fill_DB_Enable == TRUE){

        print("Merged. Now splitting table to regions and hits...")
        x <- splitTableIntoRegionsAndHits(tbl, minid, method = method)
        printf("filling %d regions, %d hits for %s", nrow(x$regions),
               nrow(x$hits), sampleID)

        dbConnection.con <- getDBConnection(dbConnection)

        # Trim the tables using a subset
        regions.locs <- dbGetQuery(dbConnection.con, "select loc from regions")
        x$regions <- subset(x$regions, (!loc %in% regions.locs$loc))

        fillToDatabase(x$regions, x$hits, dbConnection.con, dbUser, dbTable)

        databaseSummary(dbConnection.con)
        #close the connection
        dbDisconnect(dbConnection.con)
    }
  } # for sampleID
} # fill.all.samples.by.chromosome
#-------------------------------------------------------------------------------
