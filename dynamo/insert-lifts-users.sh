aws dynamodb batch-write-item \
    --request-items '{
        "LiftsUsers": [
            {
                "PutRequest": {
                    "Item": {
                        "Username": {"S": "cjkorver"},
                        "LiftId": {"S": "Aerial Tram"},
                        "Date": {"N": "1583496500"}
                    }
                }
            },
            {
                "PutRequest": {
                    "Item": {
                        "Username": {"S": "cjkorver"},
                        "LiftId": {"S": "Belmont"},
                        "Date": {"N": "1583496000"}
                    }
                }
            },
            {
                "PutRequest": {
                    "Item": {
                        "Username": {"S": "cjkorver"},
                        "LiftId": {"S": "Big Blue Express"},
                        "Date": {"N": "1583496000"}
                    }
                }
            },
            {
                "PutRequest": {
                    "Item": {
                        "Username": {"S": "cjkorver"},
                        "LiftId": {"S": "Broken Arrow"},
                        "Date": {"N": "1583496000"}
                    }
                }
            },
            {
                "PutRequest": {
                    "Item": {
                        "Username": {"S": "cjkorver"},
                        "LiftId": {"S": "Emigrant"},
                        "Date": {"N": "1583496000"}
                    }
                }
            },
            {
                "PutRequest": {
                    "Item": {
                        "Username": {"S": "cjkorver"},
                        "LiftId": {"S": "Exhibition"},
                        "Date": {"N": "1583496000"}
                    }
                }
            },
            {
                "PutRequest": {
                    "Item": {
                        "Username": {"S": "cjkorver"},
                        "LiftId": {"S": "Funitel"},
                        "Date": {"N": "1583496000"}
                    }
                }
            },
            {
                "PutRequest": {
                    "Item": {
                        "Username": {"S": "cjkorver"},
                        "LiftId": {"S": "KT22 Express"},
                        "Date": {"N": "1583496000"}
                    }
                }
            },
            {
                "PutRequest": {
                    "Item": {
                        "Username": {"S": "cjkorver"},
                        "LiftId": {"S": "Siberia Express"},
                        "Date": {"N": "1583496000"}
                    }
                }
            },
            {
                "PutRequest": {
                    "Item": {
                        "Username": {"S": "cjkorver"},
                        "LiftId": {"S": "Silverado"},
                        "Date": {"N": "1583496000"}
                    }
                }
            },
            {
                "PutRequest": {
                    "Item": {
                        "Username": {"S": "cjkorver"},
                        "LiftId": {"S": "Solitude"},
                        "Date": {"N": "1583496000"}
                    }
                }
            }
        ]
    }'

# We can query for specific lifts and usernames

aws dynamodb query \
    --table-name LiftsUsers \
    --key-condition-expression "LiftId = :liftname" \
    --projection-expression "Username" \
    --expression-attribute-values '{
        ":liftname": { "S": "KT-22" }
    }' \