# Guides & Tips for Launching an AWS EC2 Instance for Your Server

Open the [Amazon EC2 console](https://console.aws.amazon.com/ec2/) and spin up an instance with these settings.

* Required settings:
    * Application and OS Images (Amazon Machine Image, AMI):
      **`Ubuntu Server 24.04 LTS`**

* Customize the following settings based on your need:
    * Instance type (ex: `t3.large`, `t3.xlarge`)
    * Server ports ("Network settings" => "Edit" => "Add security group rule"):
        * Type: `Custom TCP` / `Custom UDP`
        * Port range
        * Source Type: `Anywhere`
    * Disk Size / Configure storage (Advanced):
        * Size (GiB)
        * Delete on termination: `No`
    * Purchasing option: **`Spot instances`**
        * Under "Customize Spot instance options":
            * Request type: `Persistent`
            * Interruption behavior: `Stop`

> [!TIP]
> Spot instance is recommendeded for cheap on-demand game servers - just make sure to use `Request type: Persistent`,
> otherwise all the server data will gone after the insance shutdown!

> [!CAUTION]
> If you no longer want your Spot Instance, to ensure that no new Spot Instance is launched, you must first cancel the
> Spot Instance request:
> https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-requests.html#terminating-a-spot-instance

For more information about EC2 pricing, please refer
to [EC2 On-Demand Pricing](https://aws.amazon.com/ec2/pricing/on-demand/)
and [Spot Instances Pricing](https://aws.amazon.com/ec2/spot/pricing/) pages.
