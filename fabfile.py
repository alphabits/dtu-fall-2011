from glob import glob
import os
from fabric.api import local, run

path = os.path.dirname(__file__)

def update_campusnet_files():
    files = glob(path+'/*/campusnet/cn.zip')
    for f in files:
        local('unzip -o %s -d %s' % (f, os.path.dirname(f)))
        local('rm %s' % f)
ucf = update_campusnet_files

def build_docs():
    local('sphinx-build -c {0}/doc/ {0} {0}/doc/'.format(path))
doc = build_docs
