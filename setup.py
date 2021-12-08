import os
import os.path
from setuptools import setup


def exhaust_files_for_pkg_data(top_dir):
    result = []
    # traverse root directory, and list directories as dirs and files as files
    for root, dirs, files in os.walk(top_dir):
        path = root.split(os.sep)
        if path[-1] == '__pycache__':
            continue
        for file in files:
            result.append(os.path.join(os.sep.join(path), file))
    return result


def dir_to_pkg(top_dir, top_pkg):
    processed = set()
    len_top_dir_path = len(top_dir)
    # add the separator
    len_top_dir_path += 1

    def _travers_dir(top_d):
        # traverse root directory, and list directories as dirs and files as files
        for root, dirs, files in os.walk(top_d):
            root_trimmed = root[len_top_dir_path:]
            path = root_trimmed.split(os.sep)
            if path[-1] == '__pycache__':
                continue
            full_pkg = '.'.join(path)
            if full_pkg in processed:
                continue
            processed.add(full_pkg)

    actual_top_dir = os.path.join(top_dir, top_pkg)
    _travers_dir(actual_top_dir)
    lst_pkg = list(processed)
    # print(lst_pkg)
    return lst_pkg


setup(
    name='mix_grpc_proto',
    version='1.0',
    packages=dir_to_pkg('./src', 'nuance') + dir_to_pkg('./src', 'google'),
    package_dir = {
        '': './src'
    },
    package_data = {
        'nuance': exhaust_files_for_pkg_data('nuance'),
        'google': exhaust_files_for_pkg_data('google')
    },
    url='https://mix.nuance.com',
    license='MIT',
    author='Nuance Communication',
    author_email='zhuoyan.li@nuance.com',
    description='Nuance Mix gRPC Proto Python bindings'
)
