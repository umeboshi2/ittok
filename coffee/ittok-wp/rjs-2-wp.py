#!/usr/bin/env python
import os, sys
import socket
import hashlib
import cPickle as Pickle
import subprocess
from ConfigParser import ConfigParser
import zipfile


#from useless.base.path import path
from unipath.path import Path as path
from unipath import FILES, DIRS, LINKS



def check_file(filename):
    has_define = False
    spaced_proper = True
    newlines = list()
    for line in file(filename):
        if has_define and line.startswith('define'):
            raise RuntimeError, "Too many defines"
        if line.startswith('define'):
            has_define = True
            continue
        if line.strip() and not line.startswith('  '):
            raise RuntimeError, "Bad line in %s" % filename
        else:
            if not line.strip():
                newlines.append('\n')
            else:
                nl = line[2:]
                if nl.startswith('module.exports'):
                    nl = nl[7:]
                newlines.append(nl)
    if not has_define:
        raise RuntimeError, "%s has no define" % filename
    return newlines

    
    
for pathobj in path('.').walk():
    if os.path.isfile(pathobj) and pathobj.endswith('.coffee'):
        newlines = check_file(pathobj)
        #print 66*"+"
        #print pathobj
        #print 66*"+"
        #print ''.join(newlines)
        with file(pathobj, 'w') as outfile:
            for line in newlines:
                outfile.write(line)
                
