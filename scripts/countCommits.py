import subprocess

def get_commit_count_with_keyword(repo_path, keyword):
    command = ['git', '-C', repo_path, 'shortlog', '-sne', '--grep', keyword]
    try:
        output = subprocess.check_output(command, stderr=subprocess.DEVNULL, shell=False, universal_newlines=True)
        commit_count = int(output.strip().split()[0])
        return commit_count
    except subprocess.CalledProcessError:
        return 0

def get_commit_count(repo_path):
    command = ['git', '-C', repo_path, 'rev-list', '--count', 'HEAD']
    try:
        output = subprocess.check_output(command, stderr=subprocess.DEVNULL, shell=False, universal_newlines=True)
        commit_count = int(output.strip())
        return commit_count
    except subprocess.CalledProcessError:
        return 0

