#Construct PSL(2,11) acting on 11 points
all:=AllTransitiveGroups(NrMovedPoints,11,Transitivity,2);
G:=all[2];;

#Construct SL(2,11) and obtain a Schur covering map
Gast:=SL(2,11);;
hom:=NaturalHomomorphismByNormalSubgroupNC(Gast,Center(Gast));;
g:=Image(hom);;
iso:=IsomorphismGroups(g,G);;
pi:=CompositionMapping2(iso,hom);;

#Pull back the stabilizer of a point and find all of its linear characters
G0:=Stabilizer(G,1);;
G0ast:=PreImage(pi,G0);;
lin:=LinearCharacters(G0ast);

#Since G0ast has no nontrivial linear characters, radicalization can only produce trivial lines