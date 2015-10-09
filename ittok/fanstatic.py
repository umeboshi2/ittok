# -*- coding: utf-8 -*-

"""
Created on 2015-10-05
:author: Joseph Rawson (joseph.rawson.works@gmail.com)
"""

from __future__ import absolute_import

from fanstatic import Group
from fanstatic import Library
from fanstatic import Resource


library = Library("ittok", "static")

fontawesome = Resource(
    library,
    'font-awesome.css',
    )
bootstrap_custom = Resource(
    library,
    "bootstrap-custom-BlanchedAlmond.css",
    depends=[fontawesome],
    )
fullcalendar = Resource(
    library,
    'fullcalendar.css',
    )
css = Group([fontawesome, bootstrap_custom, fullcalendar])

requirejs = Resource(
    library,
    'components/requirejs/require.js',
    )

main_js = Resource(
    library,
    'apps/ittok/main-local.js',
    depends=[requirejs],
    )

#js = Group([requirejs])
css_and_js = Group([css])
