#' Spatial units polygons
#'
#' A data set containing grid cells of 100 x 100 km2.
#'  The variables are as follows:
#'  @format Object of class sf and data frame with 486 rows and 2 variables: \code{id},
#'    \code{geom}
#'  \describe{
#'  \item{id}{unique id of each grid cell}
#'  \item{geom}{geometry of the polygons}
#' }
#' source Generated in QGIS 3.28.2
"spatial_units"



#' Species range maps
#'
#' A data set containing imaginary range maps for three example species A, B and C. 
#' Data structure is set out in such way, to simulate the data standards of the IUCN 
#' Red List of Threatened Species. Any similarity to real data from the IUCN Red List 
#' of Threatened Species is a mere coincidence. 
#' 
#' The variables (find more details for the variables in the IUCN Red List of Threatened 
#' Species website https://www.iucnredlist.org/) are as follows:
#'
#'  @format  Object of class sf and data frame with 6 rows and 8 variables:\code{ASSESSMENT},
#'   \code{ID_NO}, \code{SCI_NAME}, \code{PRESENCE}, \code{ORIGIN}, \code{SEASONAL},
#'    \code{LEGEND}, \code{geom}
#'  \describe{
#'   \item{ASSESSMENT}{unique id of the assessment of a species}
#'   \item{ID_NO}{unique id of a species}
#'   \item{SCI_NAME}{scientific name of a species}
#'   \item{PRESENCE}{species presence, from 1 (extant) to 6 (presence uncertain)}
#'   \item{ORIGIN}{species origin, from 1 (native) to 6 (assisted colonisation)}
#'   \item{SEASONAL}{species seasonality, from 1 (resident) to 5 (seasonal occurrence uncertain)}
#'   \item{LEGEND}{combinations of the presence, origin and seasonal codes}
#'   \item{geom}{geometry of the polygons}
#' }
#' source Generated in QGIS 3.28.2
"species"

#' Ecoregion polygon
#'
#' A data set containing imaginary ecoregion polygon. Created for testing.
#'
#'  @format  Object of class sf and data frame with 1 rows and 3 variables:\code{ECO_NAME},
#'    \code{ID}, \code{geom}
#'  \describe{
#'   \item{ECO_NAME}{name of the ecoregion}
#'   \item{ID}{unique id}
#'   \item{geom}{geometry of the polygons}
#' }
#' source Generated in QGIS 3.28.2
"ecoregion"





#' Assessment information
#'
#' A data set containing imaginary assessment information for three example species A, B and C. Data structure is
#'  set out in such way, to simulate the data standards of the IUCN Red List of Threatened Species.
#'  Any similarity to real data from the IUCN Red List of Threatened Species is a mere coincidence.
#'  The variables (find more details for the variables in the IUCN Red List of Threatened Species website
#'  https://www.iucnredlist.org/) are as follows:
#'
#'  @format Object of class sf and data frame with 3 rows and 10 variables:\code{assessmentId},
#'   \code{internalTaxonId}, \code{scientificName}, \code{redlistCategory}, \code{redlistCriteria},
#'    \code{yearPublished}, \code{assessmentDate}, \code{criteriaVersion}, \code{language},
#'    \code{systems}
#'  \describe{
#'   \item{assessmentId}{unique id of the assessment of a species}
#'   \item{internalTaxonId}{unique id of a species}
#'   \item{scientificName}{scientific name of a species}
#'   \item{redlistCategory}{}
#'   \item{redlistCriteria}{}
#'   \item{yearPublished}{year of the assessment publish on the IUCN Red List website}
#'   \item{assessmentDate}{}
#'   \item{criteriaVersion}{}
#'   \item{language}{}
#'   \item{systems}{}
#' }
#' source Generated in EXCEL
"assessment"


#' Common names of species
#'
#' A data set containing imaginary common names for three example species A, B and C. Data structure is
#'  set out in such way, to simulate the data standards of the IUCN Red List of Threatened Species.
#'  Any similarity to real data from the IUCN Red List of Threatened Species is a mere coincidence.
#'  The variables (find more details for the variables in the IUCN Red List of Threatened Species website
#'  https://www.iucnredlist.org/) are as follows:
#'
#'  @format Object of class sf and data frame with 5 rows and 5 variables:\code{internalTaxonId},
#'  \code{scientificName}, \code{name}, \code{language}, \code{main}
#'  \describe{
#'   \item{internalTaxonId}{unique id of a species}
#'   \item{scientificName}{scientific name of a species}
#'   \item{name}{common name}
#'   \item{language}{}
#'   \item{main}{}
#' }
#' source Generated in EXCEL
"common_names"


#' Taxonomy information
#'
#' A data set containing imaginary taxonomic information for three example species A, B and C. Data structure is
#'  set out in such way, to simulate the data standards of the IUCN Red List of Threatened Species.
#'  Any similarity to real data from the IUCN Red List of Threatened Species is a mere coincidence.
#'  The variables (find more details for the variables in the IUCN Red List of Threatened Species website
#'  https://www.iucnredlist.org/) are as follows:
#'
#'  @format Object of class sf and data frame with 3 rows and 7 variables:\code{internalTaxonId},
#'   \code{scientificName}, \code{kingdomName}, \code{phylumName}, \code{className}, \code{orderName},
#'    \code{familyName}
#'  \describe{
#'   \item{internalTaxonId}{unique id of a species}
#'   \item{scientificName}{scientific name of a species}
#'   \item{kingdomName}{}
#'   \item{phylumName}{}
#'   \item{className}{}
#'   \item{orderName}{}
#'   \item{familyName}{}
#' }
#' source Generated in EXCEL
"taxonomy"



#' Taxonomic groups
#'
#'  Taxonomic ranks above the species level that are appropriate for applying
#'  KBA criterion B. The variables are as follows:
#'  @format Object of class sf and data frame with 354 rows and 12 variables:\code{Sort.Order},
#'   \code{Kingdom}, \code{Phylum}, \code{Class}, \code{Order},
#'   \code{Superfamily},\code{Taxonomic.group.level},
#'    \code{Number.RR.species.required.at.KBA.with.1..range.for.B2},
#'    \code{Area.for.25..B2.RR.definition..km2....otherwise.use.10.000.km2},
#'    \code{Median.range.size.for.B3.assessment.for.comprehensively.assessed.species},
#'    \code{Apply.Ecoregion..B3a..or.bioregion..B3b..restriction},
#'    \code{Notes}
#'  \describe{
#'   \item{Sort.Order}{}
#'   \item{Kingdom}{}
#'   \item{Phylum}{}
#'   \item{Class}{}
#'   \item{Order}{}
#'   \item{Superfamily}{}
#'   \item{Taxonomic.group.level}{}
#'   \item{Number.RR.species.required.at.KBA.with.1..range.for.B2}{}
#'   \item{Area.for.25..B2.RR.definition..km2....otherwise.use.10.000.km2}{}
#'   \item{Median.range.size.for.B3.assessment.for.comprehensively.assessed.species}{}
#'   \item{Apply.Ecoregion..B3a..or.bioregion..B3b..restriction}{}
#'   \item{Notes}{}
#' }
#' source Downloaded from the WDKBA website
#' (https://www.keybiodiversityareas.org/working-with-kbas/proposing-updating/criteria-tools)
"taxonomic_groups"



#' Ecoregion Bioregion restricted
#'
#'  List of Ecoregion/bioregion restricted species: Criterion B3 requires users
#'  to identify ecoregion-restricted or bioregion-restricted species at a site.
#'  Here is a list of species that meet eco/bioregion restricted status for
#'  terrestrial, freshwater and marine eco/bioregions. The variables are as follows:
#'
#'  @format Object of class data frame with 18901 rows and 24 variables:\code{taxid},
#'   \code{scientific_name}, \code{group_level}, \code{Taxonomic.group},
#'   \code{kingdom}, \code{phylum},\code{class},\code{order},
#'    \code{family},\code{genus},\code{terrestrial.species},
#'    \code{Freshwater.species},\code{Marine.species},
#'    \code{B3a.or.B3b},\code{Restricted.to.Terrestrial.ecoregion},
#'    \code{terrestrial_ecoregion_name},\code{Restricted.to.a.FW.ecoregion},
#'    \code{freshwater_ecoregion_name},\code{Restricted.to.marine.ecoregion},
#'    \code{marine_ecoregion_name},\code{Restricted.to.FW.bioregion},
#'    \code{freshwater_bioregion_name},\code{Restricted.to.Marine.Bioregion},
#'    \code{marine_bioregion_name}
#'  \describe{
#'   \item{taxid}{}
#'   \item{scientific_name}{}
#'   \item{group_level}{}
#'   \item{Taxonomic.group}{}
#'   \item{kingdom}{}
#'   \item{phylum}{}
#'   \item{class}{}
#'   \item{order}{}
#'   \item{family}{}
#'   \item{genus}{}
#'   \item{terrestrial.species}{}
#'   \item{Freshwater.species}{}
#'   \item{Marine.species}{}
#'   \item{B3a.or.B3b}{}
#'   \item{Restricted.to.Terrestrial.ecoregion}{}
#'   \item{terrestrial_ecoregion_name}{}
#'   \item{Restricted.to.a.FW.ecoregion}{}
#'   \item{freshwater_ecoregion_name}{}
#'   \item{Restricted.to.marine.ecoregion}{}
#'   \item{marine_ecoregion_name}{}
#'   \item{Restricted.to.FW.bioregion}{}
#'   \item{freshwater_bioregion_name}{}
#'   \item{Restricted.to.Marine.Bioregion}{}
#'   \item{marine_bioregion_name}{}
#' }
#' source Downloaded from the WDKBA website
#' (https://www.keybiodiversityareas.org/working-with-kbas/proposing-updating/criteria-tools)
"eco_bioregion_restricted"



#' Multi-site KBA data form
#'
#' KBA Single/multi-site Proposal form 1.2 that can be used to test data acquired
#' for a site to ensure it meets the KBA criteria as well as help a proposer compile
#' all the necessary documentation. The variables are as follows:
#'
#'  @format Object of class Workbook:
#' source Downloaded from the WDKBA website
#' (https://www.keybiodiversityareas.org/working-with-kbas/proposing-updating/criteria-tools)
"data_form_multi_site"


#' Triggers GIS
#' 
#' KBAscope test species that trigger KBA criteria in KBAscope test spatial units. 
#' It is added to KBAscope to increase the understanding of applying KBAscope and #
#' to assist examples in several functions.  
#' 
#' @format Object of class sf and data frame with 92 rows and 39 variables: 
#'    \code{SiteID},\code{LEGEND},\code{ScientificName},\code{internalTaxonId},
#'    \code{CommonName},\code{GlobalRedListCategory},\code{AssessAgainstA1c_A1d},
#'    \code{YearOfSiteValues},\code{AssessmentParameter},\code{DerivationOfEstimate},
#'    \code{SourceOfData},\code{Range_Restricted},\code{Eco_BioRestrictedeID},
#'    \code{phylum},\code{class},\code{order},\code{superfamily},\code{family},
#'    \code{TaxonomicGroup},\code{rr_size},\code{B2_RR},\code{Eco_bio_system},
#'    \code{GlobalRange}, \code{RR_determined},\code{SiteID},\code{Eco_bio_list},
#'    \code{Eco_BioName},\code{SiteRange},\code{proportion},\code{Criterion_A1},
#'    \code{Criterion_B1},\code{Criterion_B2},\code{Criterion_B3},\code{Criteria},
#'    \code{nB2},\code{site_B2},\code{nB3},\code{site_B3},\code{geom}
#'  \describe{
#'    \item{SiteID}{}
#'    \item{LEGEND}{}
#'    \item{ScientificName}{}
#'    \item{internalTaxonId}{}
#'    \item{CommonName}{}
#'    \item{GlobalRedListCategory}{}
#'    \item{AssessAgainstA1c_A1d}{}
#'    \item{YearOfSiteValues}{}
#'    \item{AssessmentParameter}{}
#'    \item{DerivationOfEstimate}{}
#'    \item{SourceOfData}{}
#'    \item{Range_Restricted}{}
#'    \item{Eco_BioRestrictedeID}{}
#'    \item{phylum}{}
#'    \item{class}{}
#'    \item{order}{}
#'    \item{superfamily}{}
#'    \item{family}{}
#'    \item{TaxonomicGroup}{}
#'    \item{rr_size}{}
#'    \item{B2_RR}{}
#'    \item{Eco_bio_system}{}
#'    \item{GlobalRange}{}
#'    \item{RR_determined}{}
#'    \item{SiteID}{}
#'    \item{Eco_bio_list}{}
#'    \item{Eco_BioName}{}
#'    \item{SiteRange}{}
#'    \item{proportion}{}
#'    \item{Criterion_A1}{}
#'    \item{Criterion_B1}{}
#'    \item{Criterion_B2}{}
#'    \item{Criterion_B3}{}
#'    \item{Criteria}{}
#'    \item{nB2}{}
#'    \item{site_B2}{}
#'    \item{nB3}{}
#'    \item{site_B3}{}
#'    \item{geom}{}
#' }
#' 
"triggers_gis"

