import math
import os
import sys


def align_non_comments(noncomments):
    min_len = math.inf
    for i, line in enumerate(noncomments):
        line = line.strip()
        line = line.split()
        noncomments[i] = line
        if len(line) < min_len:
            min_len = len(line)

    for i in range(min_len):
        max_str_len = 0
        for j in range(len(noncomments)):
            max_str_len = max(max_str_len, len(noncomments[j][i]))

        for j in range(len(noncomments)):
            curr_len = len(noncomments[j][i])
            len_diff = max_str_len - curr_len
            centered_str = " " * (len_diff - len_diff // 2) + noncomments[j][i] + " " * (len_diff // 2)
            noncomments[j][i] = centered_str


def beautify_file(file):
    # read file
    with open(file, "r") as f:
        lines = f.readlines()
    noncomments = [line for line in lines if not line.startswith("#") and not len(line.strip()) == 0]
    align_non_comments(noncomments)
    # write file
    counter = 0
    file = file.replace(".txt", "_beautified.txt")
    with open(file, "w") as f:
        for line in lines:
            if line.startswith("#") or len(line.strip()) == 0:
                f.write(line)
            else:
                f.write(" \t ".join(noncomments[counter]) + "\n")
                counter += 1



def main():
    # read tablefiles dir path from command line
    tablefiles_dir_path = sys.argv[1]
    if tablefiles_dir_path == "-h":
        print("Usage: python3 beautify_tablefiles.py <tablefiles_dir_path>")
        return
    if not os.path.isdir(tablefiles_dir_path):
        print("Error: tablefiles_dir_path is not a directory")
        return
    # beautify each output file
    for file in os.listdir(tablefiles_dir_path):
        if file.startswith("tablefiles_") and file.endswith(".txt"):
            beautify_file(os.path.join(tablefiles_dir_path, file))


if __name__ == "__main__":
    main()
