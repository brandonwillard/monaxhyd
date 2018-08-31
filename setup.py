#! /usr/bin/env python
## monaxhyd -- Monads for Hy
## Copyright (c) 2014 Gergely Nagy <algernon@madhouse-project.org>
## Heavily based on clojure.algo.monads by Konrad Hinsen and others.
##
## The use and distribution terms for this software are covered by the
## Eclipse Public License 1.0 which can be found in the file
## epl-v10.html at the root of this distribution. By using this
## software in any fashion, you are agreeing to be bound by the terms
## of this license. You must not remove this notice, or any other,
## from this software.

from setuptools import find_packages, setup

setup(
    name="monaxhyd",
    version="0.2.1",
    install_requires = ['hy>=0.10.0'],
    packages=find_packages(exclude=['tests']),
    package_data={
        'monaxhyd': ['*.hy'],
    },
    author="Gergely Nagy",
    author_email="algernon@madhouse-project.org",
    long_description="""monaxhyd is a loose port of Clojure's algo.monads library to Hy """,
    license="EPL-1.0",
    url="https://github.com/algernon/monaxhyd",
    platforms=['any'],
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Intended Audience :: Developers",
        "License :: DFSG approved",
        "License :: OSI Approved",
        "Operating System :: OS Independent",
        "Programming Language :: Lisp",
        "Topic :: Software Development :: Libraries",
    ]
)
