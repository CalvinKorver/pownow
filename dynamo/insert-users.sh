
aws dynamodb put-item \
  --table-name UsersTable \
  --item '{
  "Username": {"S" : "cjkorver"},
  "CountryCode": {"S" : "1"},
  "AreaCode": {"S" : "206"},
  "PhoneNumber": {"S" : "8490192"},
  "Email": {"S" : "calvin.korver@gmail.com"},
  "FirstName": {"S" : "Calvin"},
  "LastName": {"S" : "Korver"}
  }' \
  --condition-expression "attribute_not_exists(#u)" \
  --expression-attribute-names '{
  "#u" : "Username"
  }'

aws dynamodb get-item --table-name UsersTable --key '{
"Username" : {"S": "cjkorver"}
}'

aws dynamodb get-item --table-name UsersTable \
  --projection-expression "FirstName, AreaCode, PhoneNumber" \
  --key '{
  "Username": {"S": "cjkorver"}
  }'