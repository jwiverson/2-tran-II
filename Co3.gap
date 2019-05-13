#Create Co3 as a doubly transitive group, pulled from the ATLAS
G:=AtlasGroup("Co3",Transitivity,2);;
G0:=Stabilizer(G,1);;

#Get the linear characters of G0
lin:=LinearCharacters(G0);

#Notice that they are all real valued

#Find an involution in G that is not in G0
P:=SylowSubgroup(G,2);;
x:=First(Elements(P), x -> x^2=One(x) and not(x in G0) );

#Since x exists, all lines arising from the radicalizations are real