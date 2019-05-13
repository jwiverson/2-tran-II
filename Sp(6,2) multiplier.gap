#Create Sp(6,2) and find an isomorphic permutation group
G:=Sp(6,2);;
iso:=IsomorphismPermGroup(G);;
g:=Image(iso);;

#Find all prime divisors of the order of g
primes:=PrimeDivisors(Size(g));;

#Load the "cohomolo" package for computing Schur multipliers
LoadPackage("cohomolo");;

#For each prime dividing the order of g, compute the p-part of the Schur multiplier
mult:=[];;
for p in primes do
	#create a CHR object as required by the "cohomolo" package
	chr:=CHR(g,p);;
	#compute the p-part of the Schur multiplier and add it to our list
	mult:=Concatenation(mult,SchurMultiplier(chr));;
od;

#Display the result
mult;

#Therefore, the Schur multiplier of Sp(6,2) is Z_2