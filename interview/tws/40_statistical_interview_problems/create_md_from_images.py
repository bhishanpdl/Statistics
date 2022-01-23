#!python
# -*- coding: utf-8 -*-#
"""
* File Name : create_md_from_images.py

* Purpose : Create markdown file from images

* Creation Date : Mar 08, 2021 Mon

* Last Modified : Mon Mar  8 20:57:57 2021

* Created By :  Bhishan Poudel

"""
# Imports
import os


with open('40_statistics_int_prb.md','w') as fo:
    for i in range(1,41):
        if i != 33:
            line = "![Qn {}](images/{:02d}.png)\n".format(i,i)
            fo.write(line)
