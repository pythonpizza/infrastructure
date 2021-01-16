import os
import httpx


def main():
    GITHUB_TOKEN = os.getenv('GITHUB_TOKEN')
    REPOSITORY_NAME = os.getenv('REPOSITORY_NAME')
    PR_NUMBER = os.getenv('PR_NUMBER', '')

    event_from_repo_name = REPOSITORY_NAME.replace('.python.pizza', '')
    event = f'pr{PR_NUMBER}-{event_from_repo_name}'

    headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/vnd.github.v3+json',
        'authorization': f'Bearer {GITHUB_TOKEN}'
    }

    data = {
        'event_type': 'delete_env',
        'client_payload': {
            'repository': REPOSITORY_NAME,
            'event': event,
            'domain': event,
        }
    }

    request = httpx.post(
        'https://api.github.com/repos/pythonpizza/infrastructure/dispatches',
        headers=headers,
        json=data
    )

    request.raise_for_status()


main()
