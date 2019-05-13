#Construct an extension of the Schur cover of Sz(8) from the Atlas
GGast:=AtlasGroup("2^2.Sz(8).3");;

#Extract a maximal subgroup isomorphic to the Schur cover
max:=ConjugacyClassesMaximalSubgroups(GGast);;
Gast:=Representative(max[1]);;

#Verify that the center equals the Schur multiplier of Sz(8)
StructureDescription(Center(Gast));

#Construct the quotient of Gast by its center
hom1:=NaturalHomomorphismByNormalSubgroup(Gast,Center(Gast));;
g:=Image(hom1);;

#Construct Sz(8) as a doubly transitive permutation group
G:=PrimitiveGroup(65,6);;

#Find an isomorphism between the quotient group g and Sz(8)
#(This simultaneously verifies that Gast is the Schur cover.)
iso:=IsomorphismGroups(g,G);;
hom:=CompositionMapping(iso,hom1);;

#Get the stabilizer of a point in G and pull it back to Gast
G0:=Stabilizer(G,1);;
G0ast:=PreImage(hom,G0);;

#Find the linear characters of G0ast
lin:=LinearCharacters(G0ast);;

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

#Test each of the nontrivial characters
List([2..7],k->RadIsHP(Gast,G0ast,lin[k]));