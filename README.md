# AWS-OnDemand-Server-Discord-Interaction

![AWS-OnDemand-Server-Discord-Interaction](/AWS-OnDemand-Server-Discord-Interaction.png)

AWS-based solution for managing an on-demand server through Discord interactions.

## Prerequisites

1. [AWS Account](https://aws.amazon.com/)
2. [Discord Account](https://discord.com/)

## Setup AWS EC2 Instance

[Get started with Amazon EC2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html)

* Required settings:
    * Application and OS Images (Amazon Machine Image):
        * Ubuntu Server 24.04 LTS
    * Edit Network settings:
        * Add security group rule (open ports for your server)

* Optional settings:
    * Configure storage (Advanced):
        * Delete on termination: `No`
    * Advanced details (Request Spot Instances):
        * Request type: `Persistent`
        * Interruption behavior: `Stop`

Please refer to [EC2 On-Demand Pricing](https://aws.amazon.com/tw/ec2/pricing/on-demand/)
and [Spot Instances Pricing](https://aws.amazon.com/tw/ec2/spot/pricing/) for more information.

> [!WARNING]
> If you no longer want your Spot Instance, to ensure that no new Spot Instance is launched, you must first cancel the
> Spot Instance request.
> (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-requests.html#terminating-a-spot-instance)

## Setup Discord Bot

1. Create a new application on the [Discord Developer Portal](https://discord.com/developers/applications)
2. Navigate to the `OAuth2` tab
3. Under `OAuth2 URL Generator`, select `applications.commands`
4. Copy the generated URL, paste it into your browser, and then add the bot to your Discord server

## Installation

1. [Open and connect to your EC2 instance](https://console.aws.amazon.com/ec2/home?#Instances)
2. Clone this repository:
    ```bash
    git clone https://github.com/yxliaoyx/AWS-OnDemand-Server-Discord-Interaction.git
    ```
3. Edit `config.ini`:
    * `STACK_NAME` identifies the stack
    * `APPLICATION_ID` and `APPLICATION_PUBLIC_KEY` can be found in the `General Information` tab of
      your [Discord Application](https://discord.com/developers/applications)
    * `DISCORD_BOT_TOKEN` can be found in the `Bot` tab. If you can't view token, click `Reset Token` to generate
4. Run the installation script:
    ```bash
    cd AWS-OnDemand-Server-Discord-Interaction
    sudo /bin/bash install.sh
    ```
5. This script will prompt you to set up the AWS CLI. Follow
   this [guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-authentication-user.html) to get your access key

> [!WARNING]
> To avoid security risks, don't use IAM users for authentication when developing purpose-built software or working with
> real data

6. `DiscordInteractionUrl` will be generated on the console. Configure the `Interactions Endpoint URL` in
   the `General Information` tab of your [Discord Application](https://discord.com/developers/applications)
7. Install your server software. You can find some examples in the `Example Server` folder

## Usage

Discord commands:

* `/start` - Start the server
* `/stop` - Stop the server

## Credits
This project is inspired by [MineCloud](https://github.com/VeriorPies/MineCloud).
