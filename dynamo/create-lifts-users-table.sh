aws dynamodb create-table \
    --table-name LiftsUsers \
    --attribute-definitions '[
      {
          "AttributeName": "Username",
          "AttributeType": "S"
      },
      {
          "AttributeName": "LiftId",
          "AttributeType": "S"
      }
    ]' \
    --key-schema '[
      {
          "AttributeName": "LiftId",
          "KeyType": "HASH"
      },
      {
          "AttributeName": "Username",
          "KeyType": "RANGE"
      }
    ]' \
    --provisioned-throughput '{
      "ReadCapacityUnits": 1,
      "WriteCapacityUnits": 1
    }' \

aws dynamodb list-tables