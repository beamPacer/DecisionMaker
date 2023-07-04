import os
from clocWithKeywords import *
from countCommits import *

repo_path = os.getcwd()
keywords = ['#chatgpt']

line_count		= count_lines_of_change_with_keywords(repo_path, keywords)
all_line_count		= count_lines_of_change_all_time(repo_path)

all_commits_count	= get_commit_count(repo_path)
tagged_commits_count	= get_commit_count_with_keyword(repo_path, "#chatgpt")

print("Only considering .swift and .strings files:")
print()
print("ChatGPT has contributed " + str(line_count) + " lines of change to this branch.")
print("Overall, there have been " + str(all_line_count) + " lines of change to this branch.")
print("ChatGPT has contributed " + str(int(line_count / all_line_count * 100)) + "% of the lines of change to this branch.")
print()
print("Additionally, ChatGPT has contributed " + str(tagged_commits_count) + " out of " + str(all_commits_count) + " commits to this branch, or " + str(int(tagged_commits_count / all_commits_count * 100)) + "%.")
print()
print("Thanks chatGPT!")

