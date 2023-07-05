import os
from clocWithKeywords import *
from countCommits import *

repo_path = os.getcwd()
keywords = ['#chatgpt']

all_lines_count			= count_lines_of_change_all_time(repo_path)
tagged_lines_count		= count_lines_of_change_with_keywords(repo_path, keywords)
percent_lines_tagged	= int(tagged_lines_count / all_lines_count * 100)

all_commits_count		= get_commit_count(repo_path)
tagged_commits_count	= get_commit_count_with_keyword(repo_path, "#chatgpt")
percent_commits_tagged	= int(tagged_commits_count / all_commits_count * 100)

def percent_str(input):
	return str(input) + "%"

print('As of the previous commit, and only considering .swift and .strings files:')
print()
print(f'ChatGPT has contributed {str(tagged_lines_count)} lines of change to this branch.')
print(f'Overall, there have been {str(all_lines_count)} lines of change to this branch.')
print(f'So, chatGPT has contributed {percent_str(percent_lines_tagged)} of the lines of change to this branch.')
print()
print(f'Additionally, ChatGPT has contributed {str(tagged_commits_count)} out of {str(all_commits_count)} commits to this branch, or { percent_str(percent_commits_tagged)}.')
print()
print('Thanks chatGPT!')
print()
print('|   | Total | chatGPT 4 | Portion thereof |')
print('|---|-------|-----------|-----------------|')
print(f'|Lines of change|{str(all_lines_count)}|{str(tagged_lines_count)}|{percent_str(percent_lines_tagged)}|')
print(f'|Commits|{str(all_commits_count)}|{str(tagged_commits_count)}|{percent_str(percent_commits_tagged)}|')
