# Neighbourhood Preserving Quantisation for LSH

Current version: 0.1. Distributed under a Creative Commons Attribution-NonCommercial License: http://creativecommons.org/licenses/by-nc/4.0/deed.en_US

This code is an implementation of the Neighbourhood Preserving Quantisation (NPQ) model introduced in the paper:

[Sean Moran, Victor Lavrenko and Miles Osborne. Neighbourhood Preserving Quantisation for LSH. SIGIR, 2013](http://dl.acm.org/citation.cfm?id=2484162)

Prerequisites:

1. Matlab

If you use the NPQ code for a publication, please cite the following paper:

@inproceedings{Moran:2013:NPQ:2484028.2484162,
 author = {Moran, Sean and Lavrenko, Victor and Osborne, Miles},
 title = {Neighbourhood Preserving Quantisation for LSH},
 booktitle = {Proceedings of the 36th International ACM SIGIR Conference on Research and Development in Information Retrieval},
 series = {SIGIR '13},
 year = {2013},
 isbn = {978-1-4503-2034-4},
 location = {Dublin, Ireland},
 pages = {1009--1012},
 numpages = {4},
 url = {http://doi.acm.org/10.1145/2484028.2484162},
 doi = {10.1145/2484028.2484162},
 acmid = {2484162},
 publisher = {ACM},
 address = {New York, NY, USA},
 keywords = {approximate nearest neighbour search, hamming distance, image retrieval, locality sensitive hashing, manhattan distance},
} 


# Usage

1. Obtain the pre-processed dataset files for MNIST, CIFAR-10 and NUSWIDE here: 
https://www.dropbox.com/sh/pvso066sqd2z8ja/AABu7dxMx92lhlLLXLUpg_jMa?dl=0

2. Edit the properties in initialise.m to fit your system and requirements (e.g. hashcode length, dataset, amount of supervision, paths to datasets and results directory etc).

3. run_quant.m

# Copyright

Copyright (C) by Sean Moran, University of Edinburgh

Please send any bug reports to sean.j.moran@gmail.com
