#Display ATLAS info for a double cover of the Higman-Sims group
DisplayAtlasInfo("2.HS");

#Pull a double cover of the Higman-Sims group from the Atlas
Gast:=AtlasGroup("2.HS");;

#Find all conjugacy classes of subgroups with index n=176
indices:=List([1..12], j -> Size(Gast)/Size(AtlasSubgroup(Gast,j)) );;
pos:=Positions(indices,176);

#We have two AtlasSubgroups to consider: numbers 2 and 3

#Starting with the first candidate, find its linear characters and test them
G0ast:=AtlasSubgroup(Gast,pos[1]);;
lin:=LinearCharacters(G0ast);;

#Make a program to test linear characters
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


#Test all the characters for the first candidate subgroup
hp:=Filtered(lin, alpha -> RadIsHP(Gast,G0ast,alpha) );

#The only characters that work are real-valued

#Find an involution in Gast that is not in G0ast
P:=SylowSubgroup(Gast,2);;
x:=First(Elements(P), x -> x^2=One(x) and not(x in G0ast) );

#Since x exists, all lines arising from the radicalizations are real


#Repeat for the other candidate subgroup
G0ast:=AtlasSubgroup(Gast,pos[2]);;
lin:=LinearCharacters(G0ast);;
hp:=Filtered(lin, alpha -> RadIsHP(Gast,G0ast,alpha) );

#Once again, only real characters create a Higman pair through radicalization
#As above, all resulting lines are real

#Overall, our results show that only real lines can have the Higman-Sims
#group as automorphisms