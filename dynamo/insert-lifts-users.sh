aws dynamodb batch-write-item \
    --request-items '{
        "LiftsUsers": [
            {
                "PutRequest": {
                    "Item": {
                        "Username": {"S": "jerry"},
                        "LiftId": {"S": "Headwall"},
                        "Date": {"N": "1583496500"}
                    }
                }
            },
            {
                "PutRequest": {
                    "Item": {
                        "Username": {"S": "matto"},
                        "LiftId": {"S": "Headwall"},
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