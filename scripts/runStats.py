from clocWithKeywords import *

repo_path = "/Users/emma/Desktop/Decision Maker/src/DecisionMaker"
keywords = ['#chatgpt']

line_count = count_lines_of_change_with_keywords(repo_path, keywords)
all_line_count = count_lines_of_change_all_time(repo_path)

print("ChatGPT has contributed " + str(line_count) + " lines of change to this branch.")
print("Overall, there have been " + str(all_line_count) + " lines of change to this branch.")
print("\nChatGPT has contributed " + str(int(line_count / all_line_count * 100)) + "% of the lines of change to this branch. Thanks chatGPT!")
