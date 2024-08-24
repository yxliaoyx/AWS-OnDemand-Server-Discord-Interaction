import os

import boto3
import requests


def followup(token, content):
    requests.post(
        f"https://discord.com/api/webhooks/{os.getenv('DISCORD_APPLICATION_ID')}/{token}",
        json={"content": content},
        timeout=30,
    )


def handler(event, context):
    if event["data"]["name"] == "start":
        ec2 = boto3.resource("ec2")
        instance = ec2.Instance(os.getenv("INSTANCE_ID"))

        if instance.state["Name"] == "stopped":
            instance.start()
            instance.wait_until_running()

        followup(event["token"], instance.public_ip_address)

    if event["data"]["name"] == "stop":
        ec2 = boto3.resource("ec2")
        instance = ec2.Instance(os.getenv("INSTANCE_ID"))
        instance.stop()
        instance.wait_until_stopped()

        followup(event["token"], "Stopped")
