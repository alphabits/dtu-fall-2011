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

def generate_cropped_pdfs(globstr):
    files = glob(globstr)
    for f in files:
        local('ps2pdf {0}'.format(f))
        local('pdfcrop {0} {0}'.format(f.replace('eps', 'pdf')))
gcp = generate_cropped_pdfs

def replace_exponentials(globstr):
    files = glob(globstr)
    for f in files:
        local(r"sed -i 's/\([0-9]*\.[0-9]*\)e\([-+][0-9][0-9]\)/$\1\\cdot 10^{\2}$/g' "+f)
re = replace_exponentials
