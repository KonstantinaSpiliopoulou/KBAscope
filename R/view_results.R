#' Visualize results.
#'
#' @param x Object of class data frame. The "ptrigger_species.csv" file
#'          generated from KBAscope::potential_kbas.
#' @param y Object of class sf and data frame. The "ptrigger_species.gpkg"
#'          file generated from KBAscope::potential_kbas.
#' @param pic Object of class logical. Takes values TRUE for adding a taxonomy picture or FALSE for not adding a taxonomy picture.
#'
#' @return Creates figures of summary results.
#' @export
#'
#' @examples
#' \dontrun{
#'   df<- sf::st_drop_geometry(triggers_gis)
#'   view_results(df,triggers_gis, pic=TRUE)
#' }
#'

view_results <- function(x,y, pic=TRUE) {
  
  #Set parameters
  TaxonomicGroup=ScientificName=Taxonomic.group.level=.=km=SiteID=n=NULL
  
  #Create basis for top right info
  df1<- x %>% dplyr::group_by(TaxonomicGroup) %>%
    dplyr::summarise(n=dplyr::n_distinct(ScientificName))
  z<-max(df1$n) + 0.2 * max(df1$n) # add some space 
  
  #Create top left graph
  
  
  a1<- ggpubr::ggbarplot(df1, x = "TaxonomicGroup", y = "n",width = 0.3,
                         fill = "#D0B800",
                         color = "#D0B800",
                         sort.val = "desc",
                         ylim=c(0,z),
                         x.text.angle = 40,
                         ylab = "Number of\nTrigger Species\n",
                         xlab = FALSE,
                         lab.size=11
  )+
    ggpubr::font("x.text", size = 9) + ggplot2::scale_y_continuous(expand = c(0,0))
  
  #Add taxonomy picture to columns
  if (pic==TRUE) {
    # select group and y lim 
    df1.naomit <- stats::na.omit(df1)
    df1.naomit <- df1.naomit[order(df1.naomit$n, decreasing=T),] # remove NA if applies 
    
    temp1 <- df1.naomit$n 
    temp2 <- 1:length(temp1)
    grp <- df1.naomit$TaxonomicGroup
    h.adjust <- 0.1*max(df1$n)
    
    # loop to integrate the pics #
    for(i in 1:length(temp1)){ 
      a1 <- a1 + rphylopic::add_phylopic(rphylopic::get_phylopic(
        base::unique(dplyr::filter(taxonomic_groups_codes, 
        Taxonomic.group.level==grp[i])$uui)), x=temp2[i], y=temp1[i]+h.adjust, ysize=8)
    }
    rm(temp1)
    rm(temp2)
    gc()
  } else {
    a1=a1
  }
  
  
  #Create bottom left graph
  A1<- sum(stringr::str_count(x$Criterion_A1, "A1"))
  B1<- sum(stringr::str_count(x$Criterion_B1, "B1"))
  B2<- sum(stringr::str_count(x$Criterion_B2, "B2"))
  B3<- sum(stringr::str_count(x$Criterion_B3, "B3"))
  D1<- sum(stringr::str_count(x$Criterion_D1, "D1"))
  D2<- sum(stringr::str_count(x$Criterion_D2, "D2"))
  D3<- sum(stringr::str_count(x$Criterion_D3, "D3"))
  
  
  df2<- base::data.frame(Criteria= c("A1", "B1", "B2", "B3", "D1", "D2", "D3"),
                         n= c(A1,B1,B2,B3,D1,D2,D3))
  
  z=max(df2$n) + 0.2 * max(df2$n) # add some space 
  
  a2<- ggpubr::ggbarplot(df2, x = "Criteria", y = "n", width=0.4,
                         fill = "#00AFBB",
                         color = "#00AFBB",
                         sort.by.groups = FALSE,
                         ylab = "Count\n",
                         xlab = "Criteria",
  ) + ggplot2::scale_y_continuous(expand = c(0,0), limits = c(0, z)) 
  
  #Create top right text
  number<- nrow(y)
  area<- y %>% sf::st_make_valid() %>%
    dplyr::mutate(area=base::as.numeric(units::set_units(sf::st_area(.), km^2))) %>%
    sf::st_drop_geometry()
  total_area<- area %>% dplyr::summarise(sum(area))
  mean_area<- area %>% dplyr::summarise(mean(area))
  
  b1<- base::data.frame(name= c("Number of pKBAs:",
                                "Mean area of pKBAs(km2):",
                                "Total area(km2):"),
                        value= c(number,mean_area[1,1], total_area[1,1]))
  b1$value<- round(b1$value, digits =0)
  
  
  table_grob1 <- gridExtra::tableGrob(b1,
    cols = NULL, rows = rep('', nrow(b1)),theme = gridExtra::ttheme_minimal())
  ## title
  title_grob1 <- grid::textGrob("pKBAs stats", gp = grid::gpar(fontsize = 18))
  ## add title
  table_grob1 <- gtable::gtable_add_rows(table_grob1,
    heights = grid::grobHeight(title_grob1) +grid::unit(5,'mm'), pos = 0)
  table_grob1 <- gtable::gtable_add_grob(table_grob1, title_grob1, 1, 1, 1,
    ncol(table_grob1), clip = "off")
  
  
  
  #Create bottom right text
  b2<- x %>% dplyr::group_by(SiteID)%>%
    dplyr::summarise(n=dplyr::n_distinct(ScientificName)) %>%
    dplyr::arrange(dplyr::desc(n)) %>%
    dplyr::rename("Site ID"="SiteID", "Number of\n trigger species"="n")
  b2<- b2[1:5,1:2]
  base::row.names(b2)<- c("1","2","3","4","5")
  
  
  table_grob2 <- gridExtra::tableGrob(b2, theme = gridExtra::ttheme_minimal())
  separators <- replicate(ncol(table_grob2),
    grid::segmentsGrob(x1 = grid::unit(0, "npc"), gp=grid::gpar(lty=2)),
    simplify=FALSE)
  ## add vertical lines on the left side of columns (after 2nd)
  table_grob2 <- gtable::gtable_add_grob(table_grob2, grobs = separators,
    t = 2, b = nrow(table_grob2), l = c(3),r=c(3))
  
  
  
  ## title
  title_grob2 <- grid::textGrob("Top 5 pKBAs with the highest\nnumber of trigger species",
    gp = grid::gpar(fontsize = 17))
  ## add title
  table_grob2 <- gtable::gtable_add_rows(table_grob2,
    heights = grid::grobHeight(title_grob2) + grid::unit(5,'mm'), pos = 0)
  table_grob2 <- gtable::gtable_add_grob(table_grob2, title_grob2, 1, 1, 1,
    ncol(table_grob2), clip = "off")
  
  #Create and save picture
  grDevices::png(filename = "view_results.png", width = 3000, height = 2400,
                 res = 330)
  
  g<- gridExtra::grid.arrange(a1,table_grob1,a2,table_grob2,
                              nrow=2,ncol=2,
                              widths = c(1.5, 1),
                              clip = FALSE)
  grDevices::dev.off()
}



