\name{csu_eapc}
\alias{csu_eapc}
\title{csu_eapc}

\description{
\code{csu_eapc} calculate the Estimated Annual Percentage Change (EAPC) of rates during a time period with the Confidence Intervalle (CI) across different population (Registry, year, sex...)
}
\usage{
csu_eapc(df_data,
		var_rate, var_period,
		var_by=NULL,
		var_eapc = "eapc")
}

\arguments{
  \item{df_data}{
  Data (need to be R dataframe format, see example to import csv file).
}
  \item{var_rate}{
		Rate variable. (Standardized or not, incidence, mortality, etc..)
}
  \item{var_period}{
		Period variable. (Year, month, etc...)
}
  \item{var_by}{
		(Optional) Variables over which the EAPC will be calculated (sex, country, cancer ...).\cr
}
  \item{var_eapc}{
		(Optional) Name of the new variable for the EAPC. Default is "eapc".\cr
		The variable for the CI will be name based on var_eapc + "_" +  up/Low.
}

}
\details{
	This function use Generalized Linear Model (GLM):\cr
	glm(rate ~ year, family=poisson(link="log")). \cr 
	We use the poisson family instead of Gaussian, so we can compute EAPC even if the is a rate of 0.
	
}
\value{
	Return a dataframe.
	
}
\references{
	\url{http://rht.iconcologia.net/stats/sart/eapc/eapc_method.pdf}
}
\author{
	Mathieu Laversanne
}

\seealso{
	\code{\link{csu_asr}}
	\code{\link{csu_ageSpecific}}
}

\examples{

data(csu_registry_data_2)

# you import your data from csv file using read.csv:
# mydata <-  read.csv("mydata.csv", sep=",")

# Estimated Annual Percentage Change (EAPC) base on ASR.


df_asr <- csu_asr(csu_registry_data_2, 
                  "age", "cases", "py",
                  var_by = c("registry", "registry_label", "sex", "year", "ethnic" ),
                  var_age_group = c("registry_label"), 
				  missing_age = 99)
				  
result <- csu_eapc(df_asr,
					"asr", "year",
					var_by=c("registry", "registry_label", "sex", "ethnic" ))

				  
# you can export your result as csv file using write.csv:
# write.csv(result, file="result.csv")
				  		  
}



