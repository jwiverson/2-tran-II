#Construct the representation of A7 on 15 points, and create a Schur cover

all:=AllTransitiveGroups(NrMovedPoints,15,Transitivity,2);
G:=all[1];;
hom:=EpimorphismSchurCover(G);;
gast:=Source(hom);;
G0:=Stabilizer(G,1);;
g0ast:=PreImage(hom,G0);;

#Find a representation of the Schur cover as a permutation group to speed calculations
iso:=IsomorphismPermGroup(gast);;
Gast:=Image(iso);;
G0ast:=Image(iso,g0ast);;

#Find all the linear characters of G0ast
lin:=LinearCharacters(G0ast);;

#Make a program to test characters
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


#Test all of the linear characters
hp:=Filtered(lin, alpha -> RadIsHP(Gast,G0ast,alpha) );

#Only the trivial character works, so all such lines are trivial (hence real)

