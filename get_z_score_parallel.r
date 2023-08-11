library(foreach)
library(doParallel)


# Set the number of cores to be used for parallel execution
num_cores <- 6

# Register a parallel backend using doParallel
cl <- makeCluster(num_cores)
registerDoParallel(cl)

clusterEvalQ(cl, {
library(frma)
library(affy)
})
# Read the names of the samples

age_sex_data <- read.csv('/media/arindam/DATA/Arjun_project/age_sex_data.csv')

sample_ids <- age_sex_data$sample_id

# Define your loop using foreach
foreach(i = sample_ids, .errorhandling = "pass") %dopar% {
  # Code to execute for each iteration
  tryCatch(
  {input_path = paste0('/media/arindam/DATA/Arjun_project/cel_files/',i,'.CEL.gz')
   warning_msg <- capture.output(Data <- ReadAffy(filenames = input_path))
  # for custom CDF file use:
  #Data <- ReadAffy(filenames = '/media/arindam/DATA/Arjun_project/cel_files/GSM38051.CEL', cdfname = '/media/arindam/DATA/Arjun_project/GPL17996_HGU133Plus2_Hs_ENTREZG.cdf')
   
   if (length(warning_msg) == 0) {
  Object <- frma(Data)
       bc<- barcode(Object, output = 'z-score')
       output_path = paste0('/media/arindam/DATA/Arjun_project/expr_files/',i,'.csv')
       write.csv(bc, file = output_path)}
   }, error = function(e) {
    # Handle the error if any occurs
    # Here, we print the error message and return a specific value
    cat("Error occurred for file", i, ": ", conditionMessage(e), "\n")
    
      next
  })

}




# Stop the parallel backend
stopCluster(cl)

