import os


# first exercise

# using os.walk() to list files in directory and subdirectories

def find_files(suffix, path):
    """
    Find all files within a path, with a given file name suffix. Note that a path may contain further
    subdirectories and those subdirectories may also contain further subdirectories. There is no limit
    to the depth of the subdirectories.

    Arguments:
    suffix(str): suffix if the file name to be found

    path(str): path of the file system

    Returns:
    a list of paths and file names that match the suffix

    """

    result = []

    for root, dirs, files in os.walk(path):
        for file in files:
            if file.endswith(suffix):
                result.append(os.path.join(root, file))
    return result


print(find_files(".c", r"testdir"))
