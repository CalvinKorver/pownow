'use strict';

var AWS = require("aws-sdk");
AWS.config.update({
  region: "us-west-2",
  endpoint: "http://localhost:8000"
});
var sns = new AWS.SNS();
var dynamodb = new AWS.DynamoDB.DocumentClient();

exports.handler = (event, context, callback) => {

    event.Records.forEach((record) => {
        console.log('Stream record: ', JSON.stringify(record, null, 2));
        var open = isOpeningHours(record.dynamodb.ApproximateCreationDateTime);
        if (open && record.eventName == 'MODIFY') {
            var users = getUsersForLift(record);
            handlePublish(users, record);
        }
    });
    callback(null, `Successfully processed ${event.Records.length} records.`);
};

function getUsersForLift(record) {
    var lift = JSON.stringify(record.dynamodb.NewImage.LiftName.S);
    var status = JSON.stringify(record.dynamodb.NewImage.Status.S);
    var expressionAttribute = {":liftname": { "S": lift }};


    var params = {
    TableName : "LiftsUsers",
    ProjectionExpression: "Username",
    KeyConditionExpression: "LiftId = #liftname",
    ExpressionAttributeNames:{
        "#liftname": "LiftId"
    },
    ExpressionAttributeValues: expressionAttribute
};

}

function handlePublish(users, record) {
    console.log(record.dynamodb.NewImage);
    var lift = JSON.stringify(record.dynamodb.NewImage.LiftName.S);
    var status = JSON.stringify(record.dynamodb.NewImage.Status.S);
    for (user in users) {
        print(user);
    }

    var params = {
        Subject: 'Lift Status Changed',
        Message: 'Lift: ' + lift + ' has status ' + status,
        TopicArn: 'arn:aws:sns:us-east-1:612585781060:liftTopic'
    };
    sns.publish(params, function (err, data) {
        if (err) {
            console.error("Unable to send message. Error JSON:", JSON.stringify(err, null, 2));
        } else {
            console.log("Results from sending message: ", JSON.stringify(data, null, 2));
        }
    });
}

function isOpeningHours(creation_epoch) {
    var date = new Date(creation_epoch * 1000);
    var hours = date.getHours();
    var res = (hours > 16 && hours < 23);
    console.log('Hour: ' + hours);
    res ? console.log('Within opening hours.') : console.log('Outside of opening hours');
    return res;
}
