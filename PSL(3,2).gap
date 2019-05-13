#Create PSL(3,2) and find a Schur cover
G:=PSL(3,2);;
hom:=EpimorphismSchurCover(G);;
gast:=Source(hom);;

#Convert to a permutation group for computational efficiency
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

#Make a program to test the linear characters
RadIsHP:=function(Gast,G0ast,alpha)
	#Input:		A group Gast which is a Schur cover of a 2-transitive group G,
	#		a subgroup G0ast which is the inverse image of a point
	#		stabilizer in G, and a linear character alpha of G0ast.
	#Output:	True, if the radicalization of (Gast,G0ast,alpha) is a Higman
	#		pair. Otherwise, false.
	#Note:		This function implements the "Higman Pair Detector" described
	#		in the paper "Doubly transitive lines II: Almost simple
	#		symmetries", by J.W. Iverson and D.G. Mixon.

	local x,ker,result,xi;

	#find x in Gast but not G0ast
	x:=Random(Gast);
	while x in G0ast do
		x:=Random(Gast);
	od;

	ker:=KernelOfCharacter(alpha);

	result:=true;

	for xi in G0ast do
		if not(x*xi*x^(-1) in G0ast) then
			continue;
		fi;

		if not(x*xi*x^(-1)*xi^(-1) in ker) then
			result:=false;
			break;
		fi;
	od;

	return result;
end;;


#test the only nontrivial character of G0ast
alpha:=lin[2];;

RadIsHP(Gast,G0ast,alpha);

#the result shows that the nontrivial character of G0ast does not produce a Higman pair through radicalization

