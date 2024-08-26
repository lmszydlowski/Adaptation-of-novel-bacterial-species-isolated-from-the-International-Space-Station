library(UpSetR)
library(ggplot2)
library(ComplexUpset)

# define input
input = c("M.mcarthurae&A.burdickii&L.williamsii&M.meiriae&P.vandeheii"=1778,
"M.mcarthurae&A.burdickii&M.meiriae&P.vandeheii"=79,
"M.mcarthurae&A.burdickii&L.williamsii&P.vandeheii"=71,
"M.mcarthurae&A.burdickii&L.williamsii&M.meiriae"=27,
"M.mcarthurae&L.williamsii&M.meiriae&P.vandeheii"=51,
"A.burdickii&L.williamsii&M.meiriae&P.vandeheii"=108,
"M.mcarthurae&A.burdickii&P.vandeheii"=45,
"M.mcarthurae&A.burdickii&M.meiriae"=14,
"M.mcarthurae&A.burdickii&L.williamsii"=21,
"M.mcarthurae&M.meiriae&P.vandeheii"=19,
"M.mcarthurae&L.williamsii&P.vandeheii"=13,
"M.mcarthurae&L.williamsii&M.meiriae"=14,
"A.burdickii&M.meiriae&P.vandeheii"=64,
"A.burdickii&L.williamsii&P.vandeheii"=56,
"A.burdickii&L.williamsii&M.meiriae"=18,
"L.williamsii&M.meiriae&P.vandeheii"=43,
"M.mcarthurae&A.burdickii"=12,
"M.mcarthurae&P.vandeheii"=36,
"M.mcarthurae&M.meiriae"=12,
"M.mcarthurae&L.williamsii"=3,
"A.burdickii&P.vandeheii"=116,
"A.burdickii&M.meiriae"=30,
"A.burdickii&L.williamsii"=5,
"P.vandeheii&M.meiriae"=66,
"P.vandeheii&L.williamsii"=59,
"L.williamsii&M.meiriae"=9,
M.mcarthurae=21,
A.burdickii=70,
M.meiriae=63,
L.williamsii=16,
P.vandeheii=380)

arm <- as.data.frame(fromExpression(input))

# generate query
query=list(upset_query(
    intersect=c("M.mcarthurae","A.burdickii","L.williamsii","M.meiriae","P.vandeheii"),
    color="green3",
    fill="green3",
    only_components=c('intersections_matrix', 'Intersection size')))

#generate upset plot

upset_plot =upset(arm,
           intersect=c("M.mcarthurae","A.burdickii","L.williamsii","M.meiriae","P.vandeheii"),
           queries = query,
           base_annotations=list('Intersection size'=intersection_size(counts=TRUE)),
           themes=upset_modify_themes(
    list('intersections_matrix'=theme(text=element_text(size=15,face = "italic")))),
  min_size=1,
  width_ratio=0.1,
  name='',
  height_ratio=1,
  set_sizes = FALSE)

upset_plot



