#!/usr/bin/python
import yaml
import os

from argparse import ArgumentParser
from jinja2 import Environment, FileSystemLoader


def strip_dict(dct, replace_value=""):
    if type(dct) is dict:
        for k, v in dct.items():
            if type(v) is dict:
                v = strip_dict(v)
            elif v is None:
                dct[k] = ""

    return dct


parser = ArgumentParser()
parser.add_argument('partition_file', default=os.path.join(os.getcwd(), "mp-partitions.yaml"))
parser.add_argument('jinja_template', default=os.path.join(os.getcwd(), "slurm-cluster-mp.jinja"))

results = parser.parse_args()
jinja_template_file = results.jinja_template
partitions_file = results.partition_file

new_file = "{}.yaml".format(os.path.splitext(jinja_template_file)[0])
env = Environment(loader=FileSystemLoader('.'), trim_blocks=True, lstrip_blocks=True)
template = env.get_template(jinja_template_file)

with open(partitions_file, "r") as f:
    partitions = yaml.load(f.read())["partitions"]
    for i in range(len(partitions)):
        partitions[i] = strip_dict(partitions[i])
    new_config = template.render(partitions=partitions)
print(new_config)
