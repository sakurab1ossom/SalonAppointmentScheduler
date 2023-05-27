#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon -t -c"
echo -e "\n~~~~~ MY SALON ~~~~~"

MAIN_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  
  echo -e "\nWelcome to My Salon, how can I help you?\n"

  AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
  echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done
  
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
    1) CUT_MENU ;;
    2) COLOR_MENU ;;
    3) PERM_MENU ;;
    *) MAIN_MENU "I could not find that service. What would you like today?" ;;
  esac
}

CUT_MENU(){
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi
  echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
  read SERVICE_TIME
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID, 1, '$SERVICE_TIME')")

  echo -e "\nI have put you down for a cut at $SERVICE_TIME, $CUSTOMER_NAME."
}

COLOR_MENU(){
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi
  echo -e "\nWhat time would you like your color, $CUSTOMER_NAME?"
  read SERVICE_TIME
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID, 2, '$SERVICE_TIME')")

  echo -e "\nI have put you down for a color at $SERVICE_TIME, $CUSTOMER_NAME."
}

PERM_MENU(){
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi
  echo -e "\nWhat time would you like your perm, $CUSTOMER_NAME?"
  read SERVICE_TIME
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID, 3, '$SERVICE_TIME')")

  echo -e "\nI have put you down for a perm at $SERVICE_TIME, $CUSTOMER_NAME."
}

MAIN_MENU
