from configparser import ConfigParser

from aws_cdk import App, CfnOutput, Duration, Stack, aws_iam, aws_lambda, aws_lambda_python_alpha
from constructs import Construct

config = ConfigParser()
config.read("config.ini")


class CdkStack(Stack):
    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        with open("/var/lib/cloud/data/instance-id", encoding="utf-8") as file:
            instance_id = file.read().strip()

        command_handler = aws_lambda_python_alpha.PythonFunction(
            self,
            "CommandHandler",
            runtime=aws_lambda.Runtime.PYTHON_3_12,
            entry="lambda/command_handler",
            environment={
                "DISCORD_APPLICATION_ID": config.get("DISCORD", "APPLICATION_ID"),
                "INSTANCE_ID": instance_id,
            },
            initial_policy=[
                aws_iam.PolicyStatement(
                    actions=["ec2:StartInstances", "ec2:StopInstances", "ec2:DescribeInstances"],
                    resources=["*"],
                )
            ],
            memory_size=1024,
            timeout=Duration.seconds(30),
        )

        discord_interaction = aws_lambda_python_alpha.PythonFunction(
            self,
            "DiscordInteraction",
            runtime=aws_lambda.Runtime.PYTHON_3_12,
            entry="lambda/discord_interaction",
            environment={
                "COMMAND_HANDLER_FUNCTION_NAME": command_handler.function_name,
                "DISCORD_APPLICATION_PUBLIC_KEY": config.get("DISCORD", "APPLICATION_PUBLIC_KEY"),
            },
            initial_policy=[
                aws_iam.PolicyStatement(
                    actions=["lambda:InvokeFunction"],
                    resources=["*"],
                )
            ],
            memory_size=1024,
            timeout=Duration.seconds(30),
        )

        discord_interaction_url = discord_interaction.add_function_url(auth_type=aws_lambda.FunctionUrlAuthType.NONE)
        CfnOutput(self, "DiscordInteractionUrl", value=discord_interaction_url.url)


def main():
    app = App()
    CdkStack(app, config.get("AWS", "STACK_NAME"))
    app.synth()


if __name__ == "__main__":
    main()
