#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table  -t --no-align --tuples-only -c"

ALTER1=$($PSQL "ALTER TABLE properties RENAME COLUMN weight TO atomic_mass")
ALTER2=$($PSQL "ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius")
ALTER3=$($PSQL "ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius")
ALTER4=$($PSQL "ALTER TABLE elements ADD UNIQUE (name)")
ALTER4=$($PSQL "ALTER TABLE elements ADD UNIQUE (symbol)")
ALTER5=$($PSQL "ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL")
ALTER6=$($PSQL "ALTER TABLE elements ALTER COLUMN name SET NOT NULL")
ALTER7=$($PSQL "ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL")
ALTER8=$($PSQL "ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL")
ALTER9=$($PSQL "ALTER TABLE properties ADD FOREIGN KEY (atomic_number) REFERENCES elements (atomic_number)")
ALTER10=$($PSQL "CREATE TABLE types ()")
ALTER11=$($PSQL "ALTER TABLE types ADD COLUMN type_id INT PRIMARY KEY")
ALTER12=$($PSQL "ALTER TABLE types ADD COLUMN type VARCHAR (15) NOT NULL")

ALTER13=$($PSQL "SELECT DISTINCT (type) FROM properties")
COUNT=1
echo "$ALTER13" | while read TYPE
do
echo $($PSQL " INSERT INTO types (type_id, type) VALUES ($COUNT, '$TYPE')")
COUNT=$((COUNT + 1))
done

ALTER14=$($PSQL "ALTER TABLE properties ADD COLUMN type_id INT NOT NULL DEFAULT 1")
ALTER15=$($PSQL "ALTER TABLE properties ADD FOREIGN KEY (type_id) REFERENCES types (type_id)")

#SET up type id

#Each row in your properties table should have a type_id value that links to the correct type from the types table

TYPES=$($PSQL "SELECT * FROM types") 
echo "$TYPES" | while IFS="|" read TYPE_ID TYPE
do
UPDATE_TYPE_ID=$($PSQL "UPDATE properties SET type_id = $TYPE_ID WHERE type = '$TYPE'")
echo $TYPE_ID $TYPE
done

#You should capitalize the first letter of all the symbol values in the elements table. Be careful to only capitalize the letter and not change any others

ELEMENTS=$($PSQL "SELECT symbol FROM elements")
echo "$ELEMENTS" | while read ELEMENT
do
if [[ $ELEMENT =~ ^[a-z] ]]
then
UPPERCASE_LETTER=$(echo $ELEMENT | sed 's/^\([a-z]\)/\U\1/')
echo $UPPERCASE_LETTER - $ELEMENT
UPDATE_UPPERCASE=$($PSQL "UPDATE elements SET symbol = '$UPPERCASE_LETTER' WHERE symbol = '$ELEMENT'")
fi
done

#remove all trailing zeros

echo "$($PSQL "SELECT atomic_mass FROM properties ORDER BY atomic_number")" | while read ATOMIC_MASS
do
UPDATED_MASS=$(echo $ATOMIC_MASS | sed -r 's/0*$//')
echo "$($PSQL "UPDATE properties SET atomic_mass = $UPDATED_MASS WHERE atomic_mass = $ATOMIC_MASS")"
done

#update atomic number 9 and 10
INSERT_ELEMENTS=$($PSQL "INSERT INTO elements (atomic_number, symbol, name) VALUES (9, 'F', 'Fluorine'), (10, 'Ne', 'Neon')")
INSERT_PROPERTIES=$($PSQL "INSERT INTO properties (atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius) VALUES (9, 'nonmetal', 18.998, -220, -188.1), (10, 'nonmetal', 20.18, -248.6, -246.1)")
ELEMENT_TYPE=$($PSQL "SELECT type FROM properties WHERE atomic_number = 9")
TYPE_ID=$($PSQL "SELECT type_id FROM types WHERE type = '$ELEMENT_TYPE'")
UPDATE_TYPE_ID=$($PSQL "UPDATE properties SET type_id = $TYPE_ID WHERE atomic_number = 9")

ELEMENT_TYPE=$($PSQL "SELECT type FROM properties WHERE atomic_number = 10")
TYPE_ID=$($PSQL "SELECT type_id FROM types WHERE type = '$ELEMENT_TYPE'")
UPDATE_TYPE_ID=$($PSQL "UPDATE properties SET type_id = $TYPE_ID WHERE atomic_number = 10")