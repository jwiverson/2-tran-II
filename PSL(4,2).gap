#Create PSL(4,2) and find a Schur cover
G:=PSL(4,2);;
hom:=EpimorphismSchurCover(G);;
gast:=Source(hom);;

#Convert to a permutation group for computational efficiency
#(This takes a long time!)
iso:=IsomorphismPermGroup(gast);;
Gast:=Image(iso);;

#Get the composed covering map of Gast onto G
inv:=InverseGeneralMapping(iso);;
homm:=CompositionMapping(hom,inv);

#Find the stabilizer and its pre-image in the covering group
G0:=Stabilizer(G,1);;
G0ast:=PreImage(homm,G0);;

#Get the linear characters of G0ast
lin:=LinearCharacters(G0ast);

#There are no nontrivial characters, so there is no nontrivial ETF with PSL(4,2)-symmetry