import json
import os

import boto3
from nacl.exceptions import BadSignatureError
from nacl.signing import VerifyKey


def handler(event, context):
    verify_key = VerifyKey(bytes.fromhex(os.getenv("DISCORD_APPLICATION_PUBLIC_KEY")))
    signature = event["headers"]["x-signature-ed25519"]
    timestamp = event["headers"]["x-signature-timestamp"]

    try:
        verify_key.verify(f"{timestamp}{event['body']}".encode(), bytes.fromhex(signature))
    except BadSignatureError:
        return {
            "statusCode": 401,
            "body": json.dumps("invalid request signature"),
        }

    body = json.loads(event["body"])

    if body["type"] == 1:
        return {
            "statusCode": 200,
            "body": json.dumps({"type": 1}),
        }

    if body["type"] == 2:
        lambda_client = boto3.client("lambda")
        lambda_client.invoke(
            FunctionName=os.getenv("COMMAND_HANDLER_FUNCTION_NAME"),
            InvocationType="Event",
            Payload=json.dumps(body),
        )

        return {
            "statusCode": 200,
            "body": json.dumps({"type": 5}),
        }

    return {
        "statusCode": 400,
        "body": json.dumps({"message": "Bad Request"}),
    }
