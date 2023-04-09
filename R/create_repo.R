#' Creates a specific folder structure to perform KBA scoping analysis.
#'
#' @param x A directory under which inputs and outputs of a KBA scoping
#'          analysis will be stored.
#'
#' @return Folder structure at a selected directory is created.
#' @export
#'
#' @examples x<- "C:/projects/KBA_scoping_analysis"
#'
create_repo<- function(x) {

  base::dir.create(base::paste0(x, "/input"))
    base::dir.create(base::paste0(x, "/input/spatial_units"))
    base::dir.create(base::paste0(x,"/input/eco_bioregions/"))
    base::dir.create(base::paste0(x, "/input/species"))
        base::dir.create(base::paste0(x, "/input/species/terrestrial"))
        base::dir.create(base::paste0(x, "/input/species/terrestrial/AOO"))
        base::dir.create(base::paste0(x, "/input/species/terrestrial/AOH"))
        base::dir.create(base::paste0(x, "/input/species/terrestrial/localities"))
        base::dir.create(base::paste0(x, "/input/species/terrestrial/population"))
        base::dir.create(base::paste0(x, "/input/species/terrestrial/range_maps"))
      base::dir.create(base::paste0(x, "/input/species/freshwater"))
        base::dir.create(base::paste0(x, "/input/species/freshwater/AOO"))
        base::dir.create(base::paste0(x, "/input/species/freshwater/AOH"))
        base::dir.create(base::paste0(x, "/input/species/freshwater/localities"))
        base::dir.create(base::paste0(x, "/input/species/freshwater/population"))
        base::dir.create(base::paste0(x, "/input/species/freshwater/range_maps"))
      base::dir.create(base::paste0(x, "/input/species/marine"))
        base::dir.create(base::paste0(x, "/input/species/marine/AOO"))
        base::dir.create(base::paste0(x, "/input/species/marine/AOH"))
        base::dir.create(base::paste0(x, "/input/species/marine/localities"))
        base::dir.create(base::paste0(x, "/input/species/marine/population"))
        base::dir.create(base::paste0(x, "/input/species/marine/range_maps"))
    base::dir.create(base::paste0(x, "/input/raw_species"))
    base::dir.create(base::paste0(x, "/input/IUCN_Red_List"))
  base::dir.create(base::paste0(x, "/output"))
    base::dir.create(base::paste0(x, "/output/terrestrial"))
      base::dir.create(base::paste0(x, "/output/terrestrial/AOO"))
      base::dir.create(base::paste0(x, "/output/terrestrial/AOH"))
      base::dir.create(base::paste0(x, "/output/terrestrial/localities"))
      base::dir.create(base::paste0(x, "/output/terrestrial/population"))
      base::dir.create(base::paste0(x, "/output/terrestrial/range_maps"))
    base::dir.create(base::paste0(x, "/output/freshwater"))
      base::dir.create(base::paste0(x, "/output/freshwater/AOO"))
      base::dir.create(base::paste0(x, "/output/freshwater/AOH"))
      base::dir.create(base::paste0(x, "/output/freshwater/localities"))
      base::dir.create(base::paste0(x, "/output/freshwater/population"))
      base::dir.create(base::paste0(x, "/output/freshwater/range_maps"))
    base::dir.create(base::paste0(x, "/output/marine"))
      base::dir.create(base::paste0(x, "/output/marine/AOO"))
      base::dir.create(base::paste0(x, "/output/marine/AOH"))
      base::dir.create(base::paste0(x, "/output/marine/localities"))
      base::dir.create(base::paste0(x, "/output/marine/population"))
      base::dir.create(base::paste0(x, "/output/marine/range_maps"))
  base::dir.create(base::paste0(x, "/results"))
    base::dir.create(base::paste0(x, "/results/terrestrial"))
    base::dir.create(base::paste0(x, "/results/freshwater"))
    base::dir.create(base::paste0(x, "/results/marine"))

  base::message("Ready to place files for KBA scoping analysis in the right folder!!")

  base::data.frame(z=c(
    "Download Terrestrial Ecoregions GIS data from https://ecoregions.appspot.com/,
    Freshwater Ecoregions GIS data from https://www.feow.org/download,
    Marine Ecoregions GIS data from https://data.unep-wcmc.org/datasets/38",
    "For Freshwater Ecoregions do not forget to download the Legend for Freshwater Ecoregions of the World")) %>%
    utils::write.table(base::paste0(x,"/input/eco_bioregions/README.txt"))
}
