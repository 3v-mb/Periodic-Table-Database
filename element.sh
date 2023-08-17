
INPUT=$1

if [[ -z $INPUT ]]
then
  echo "Please provide an element as an argument."
  exit
fi

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
FLAG=0

if [[ $INPUT =~ [0-9]+ ]]
then
  ATOMIC_NUMBER=$INPUT
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
  TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
  MP=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  BP=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  FLAG=1
fi

if [[ $INPUT =~ [A-Z][a-z]? ]]
then
  SYMBOL=$INPUT
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$SYMBOL'")
  NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$SYMBOL'")
  TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
  MP=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  BP=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  FLAG=1
fi
  
if [[ $INPUT =~ [A-Z][a-z][a-z]+ ]]
then
  NAME=$INPUT
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$NAME'")
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
  TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
  MP=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  BP=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  FLAG=1
fi

if [[ $FLAG == 0 ]]
then
  echo -e "I could not find that element in the database."
else
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
fi
