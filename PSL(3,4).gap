#Pull the Schur cover of PSL(3,4) from the perfect groups library
Gast:=PerfectGroup(IsPermGroup,967680,4);;

#Verify that its center is contained in its commutator subgroup
IsSubgroup(DerivedSubgroup(Gast),Center(Gast));

#Verify that its center is isomorphic to the Schur multiplier of PSL(3,4)
StructureDescription(Center(Gast));

#Construct the quotient by the center
hom1:=NaturalHomomorphismByNormalSubgroup(Gast,Center(Gast));;
g:=Image(hom1);;

#Produce an isomorphism with PSL(3,4) in its doubly transitive representation
G:=PSL(3,4);;
Transitivity(G);

iso:=IsomorphismGroups(g,G);;
hom:=CompositionMapping(iso,hom1);;

#Get the stabilizer of a point in PSL(3,4) and pull it back to the Schur cover
G0:=Stabilizer(G,1);;
G0ast:=PreImage(hom,G0);;

#Get the linear characters of G0ast
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
List([2,3],j->RadIsHP(Gast,G0ast,lin[j]));

#Since none of the nontrivial characters works, there is no
#nontrivial ETF with PSL(3,4)-symmetry