# AWS-OnDemand-Server-Discord-Interaction

![AWS-OnDemand-Server-Discord-Interaction](/docs/AWS-OnDemand-Server-Discord-Interaction.png)

A lightweight Utility to convert your AWS EC2 instance into an On-demand server for your Discord community within
minutes.

## Features

1. Easy setup - convert your AWS EC2 instance into an On-demand server for your Discord community within minutes.
2. Auto shutdown support when no one is online.
3. Low cost (≈75 cents for 20 hr play/month with a t3.large spot instances).

## Usage

Supported Discord Commands:

* `/start`: Launch the server and post the IP address in the Discord channel
* `/stop`: Manually stop the server

## How does it work?

AWS-OnDemand-Server-Discord-Interaction is based on CDK, given configurations, the setup script will set up all required
environments (e.g. AWS CLI, CDK, and Python env), grab the EC2 instance ID and deploy a CloudFormation stack that
contains all the Lambdas resources needed to convert the EC2 instance into an on-demand server controlled by Discord
BOT.

## How to Use?

### 0. Prerequisites

An EC2 server instance on your [AWS Account](https://aws.amazon.com/) (preferably running *Ubuntu Server 24.04 LTS*
with > 4GB RAM and > 8GB storage)

If haven't, here are some [Guides & Tips for Launching an AWS EC2 Instance for Your Server](docs/Launch-EC2-Guides.md).

### 1. Setup Discord Bot

1. Create a new application on the [Discord Developer Portal](https://discord.com/developers/applications)
2. Navigate to the `OAuth2` tab
3. In `OAuth2 URL Generator`, select `applications.commands`
4. Copy the generated URL, paste it into the Discord App, and click it to add the BOT to your Discord server.

### 2. Install AWS-OnDemand-Server-Discord-Interaction

1. [Connect to your EC2 instance terminal](https://console.aws.amazon.com/ec2/home?#Instances)
2. Clone this project:
    ```bash
    git clone https://github.com/yxliaoyx/AWS-OnDemand-Server-Discord-Interaction.git
    ```
3. Update `config.ini` to include the following:
    * `STACK_NAME`: CloudFormation Stack name
    * `APPLICATION_ID` and `APPLICATION_PUBLIC_KEY` can be found in the `General Information` tab of
      your [Discord Application](https://discord.com/developers/applications)
    * `DISCORD_BOT_TOKEN` can be found in the `Bot` tab. If you can't view the token, click `Reset Token` to generate
      one.

   Example `config.ini` format:
    ```
    [AWS]
    STACK_NAME = DemoStack

    [DISCORD]
    APPLICATION_ID = 1234567890
    APPLICATION_PUBLIC_KEY = 1a2b3c4d5e6f7g8h9i0j
    BOT_TOKEN = A1B2C3D4E5F6G7H8I9J0K
    ```

4. Run the installation script in the project folder:
    ```bash
    cd AWS-OnDemand-Server-Discord-Interaction
    sudo /bin/bash install.sh
    ```
5. When finished environment setup (5~10 minutes), it will prompt to set up the AWS CLI with Access Key:
    - Go to IAM => Users => Create User
    - In Permission Options, select `Attach policies directly`
    - Click "Create Policy", this will open a new tab
    - Copy and paste [these policies JSON](docs/policies.json) into to the Policy editor in the JSON view
    - Navigate back to the Create User tab, click refresh, select the policies just created, then create the user.
    - Select the user just created, Security Credentials => Create Access Key (Use case: "Command Line Interface")
    - Copy the "Access key" and "Secret access key"

6. After setting up Access Key, AWS-OnDemand-Server-Discord-Interaction will start deploying the CloudFormation stack
   via CDK. When done, `DiscordInteractionUrl` will be printed to the console, copy and paste it to the
   `Interactions Endpoint URL` field in the `General Information` tab of
   your [Discord Application](https://discord.com/developers/applications).
    - You can also grab the `DiscordInteractionUrl` from  `CloudFormation/<StackName>/Outputs` tab.

7. You are all set.Try typing `/start` or `/stop` command in your Discord server to give it a try!

## Credits

This project is inspired by [MineCloud](https://github.com/VeriorPies/MineCloud).
