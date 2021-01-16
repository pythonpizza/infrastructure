import os
import httpx


def main():
    GITHUB_TOKEN = os.getenv('GITHUB_TOKEN')
    REPOSITORY_NAME = os.getenv('REPOSITORY_NAME')
    SHA = os.getenv('SHA')
    PR_NUMBER = os.getenv('PR_NUMBER', '')
    EVENT_NAME = os.getenv('EVENT_NAME', False)

    event_from_repo_name = REPOSITORY_NAME.replace('.python.pizza', '')

    headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/vnd.github.v3+json',
        'authorization': f'Bearer {GITHUB_TOKEN}'
    }

    if PR_NUMBER:
        base_domain = event = f'pr{PR_NUMBER}-{event_from_repo_name}'
    else:
        event = event_from_repo_name
        base_domain = event_from_repo_name

    data = {
        'event_type': 'prod_push',
        'client_payload': {
            'repository': REPOSITORY_NAME,
            'event': event,
            'domain': base_domain,
            'sha': SHA,
            'is_pr': EVENT_NAME == 'pull_request'
        }
    }

    request = httpx.post(
        'https://api.github.com/repos/pythonpizza/infrastructure/dispatches',
        headers=headers,
        json=data
    )

    request.raise_for_status()


main()
