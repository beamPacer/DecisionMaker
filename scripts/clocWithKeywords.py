# Written by chatGPT 4

import subprocess
import os

def count_lines_of_change_with_keywords(repo_path, keywords):
    command = ['git', '-C', repo_path, 'log', '--grep']
    command.extend(keywords)
    command.extend(['--pretty=format:""', '--numstat'])

    try:
        output = subprocess.check_output(command, stderr=subprocess.DEVNULL, shell=False, universal_newlines=True)
        lines_of_change = output.strip().split('\n')
        line_count = 0

        for line in lines_of_change:
            if line.strip():
                fields = line.strip().split('\t')
                if len(fields) >= 3:
                    added, deleted, filename = fields[:3]
                    if filename.endswith(('.swift', '.strings')):
                        line_count += int(added) + int(deleted)

        return line_count
    except subprocess.CalledProcessError:
        return 0

def count_lines_of_change_all_time(repo_path):
    command = ['git', '-C', repo_path, 'log', '--pretty=format:""', '--numstat']

    try:
        output = subprocess.check_output(command, stderr=subprocess.DEVNULL, shell=False, universal_newlines=True)
        lines_of_change = output.strip().split('\n')
        line_count = 0

        for line in lines_of_change:
            if line.strip():
                fields = line.strip().split('\t')
                if len(fields) >= 3:
                    added, deleted, filename = fields[:3]
                    if filename.endswith(('.swift', '.strings')):
                        line_count += int(added) if added != '-' else 0
                        line_count += int(deleted) if deleted != '-' else 0

        return line_count - 835  # Subtract the number of lines of change in the initial commit
    except subprocess.CalledProcessError:
        return 0

