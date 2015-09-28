#!/usr/bin/python -u

import requests
import sys

from os.path import expanduser


URL = 'https://api.github.com/orgs/datasift/repos'
CONTENT_URL = 'https://api.github.com/repos/datasift/{repo}/contents/{path}'
HEADERS = {'Authorization': ''}


def do_request(page=1):
    response = requests.get(URL + '?page={0}'.format(page), headers=HEADERS)

    relations = dict([(x.split('; ')[1], x.split('; ')[0])
                      for x in response.headers['link'].split(', ')])

    return (relations, response.json())


def get_repos():
    page = 1
    relations, data = do_request(page=page)
    repos = []
    while "rel=\"next\"" in relations:
        page += 1
        relations, data = do_request(page=page)
        repos.extend([r['name'] for r in data])
        sys.stderr.write(".")

    print

    return repos


def does_repo_contain_chef(repo):
    sys.stderr.write("+")
    paths = [
        'metadata.rb',
        'chef/cookbook/metadata.rb',
        'cookbooks'
    ]

    for path in paths:
        response = requests.get(CONTENT_URL.format(repo=repo, path=path),
                           headers=HEADERS)
        if response.status_code == 200:
            return True

    return False

try:
    with open(expanduser('~') + '/.git-token', 'r') as f:
        HEADERS['Authorization'] = 'token ' + f.read().rstrip()
except IOError:
    print "Please put your github token into ~/.git-token"
    sys.exit(1)

repos = "\n".join(sorted(["{0} | git@github.com:datasift/{0}.git".format(repo)
                          for repo in get_repos()
                          if does_repo_contain_chef(repo)]))

print repos

