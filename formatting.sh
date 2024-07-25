#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table  -t --no-align --tuples-only -c"

#SET up type id

#Each row in your properties table should have a type_id value that links to the correct type from the types table

#TYPES=$($PSQL "SELECT * FROM types") 
#echo "$TYPES" | while IFS="|" read TYPE_ID TYPE
#do
#UPDATE_TYPE_ID=$($PSQL "UPDATE properties SET type_id = $TYPE_ID WHERE type = '$TYPE'")
#echo $TYPE_ID $TYPE
#done

#You should capitalize the first letter of all the symbol values in the elements table. Be careful to only capitalize the letter and not change any others

#ELEMENTS=$($PSQL "SELECT symbol FROM elements")
#echo "$ELEMENTS" | while read ELEMENT
#do
#if [[ $ELEMENT =~ ^[a-z] ]]
#then
#UPPERCASE_LETTER=$(echo $ELEMENT | sed 's/^\([a-z]\)/\U\1/')
#echo $UPPERCASE_LETTER - $ELEMENT
#UPDATE_UPPERCASE=$($PSQL "UPDATE elements SET symbol = '$UPPERCASE_LETTER' WHERE symbol = '$ELEMENT'")
#fi
#done

#remove all trailing zeros

#echo "$($PSQL "SELECT atomic_mass FROM properties ORDER BY atomic_number")" | while read ATOMIC_MASS
#do
##
#echo "$($PSQL "UPDATE properties SET atomic_mass = $UPDATED_MASS WHERE atomic_mass = $ATOMIC_MASS")"
#done

#update atomic number 9
INSERT_ELEMENTS=$($PSQL "INSERT INTO elements (atomic_number, symbol, name) VALUES (9, 'F', 'Fluorine'), (10, 'Ne', 'Neon')")
INSERT_PROPERTIES=$($PSQL "INSERT INTO properties (atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius) VALUES (9, 'nonmetal', 18.998, -220, -188.1), (10, 'nonmetal', 20.18, -248.6, -246.1)")