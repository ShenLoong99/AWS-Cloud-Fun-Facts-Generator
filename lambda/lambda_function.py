import boto3
import random
import json

# Create DynamoDB client
dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table("CloudFacts")

def lambda_handler(event, context):
    # Scan entire table (not efficient for huge tables, but fine here)
    response = table.scan()
    items = response.get("Items", [])

    if not items:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": "No facts found"})
        }

    # Pick random fact
    fact = random.choice(items)["FactText"]

    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps({"fact": fact})
    }