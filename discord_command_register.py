from configparser import ConfigParser

import requests


def main():
    config = ConfigParser()
    config.read("config.ini")

    slash_commands = [
        {"name": "start", "description": "start EC2 instance"},
        {"name": "stop", "description": "stop EC2 instance"},
    ]

    response = requests.put(
        f"https://discord.com/api/v10/applications/{config.get('DISCORD', 'APPLICATION_ID')}/commands",
        headers={"Authorization": f"Bot {config.get('DISCORD', 'BOT_TOKEN')}"},
        json=slash_commands,
        timeout=30,
    )

    print(response.json())


if __name__ == "__main__":
    main()
