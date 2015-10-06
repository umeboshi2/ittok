# -*- coding: utf-8 -*-

"""
Created on 2015-10-05
:author: Joseph Rawson (joseph.rawson.works@gmail.com)
"""

pytest_plugins = "kotti"

from pytest import fixture


@fixture(scope='session')
def custom_settings():
    import ittok.resources
    ittok.resources  # make pyflakes happy
    return {
        'kotti.configurators': 'kotti_tinymce.kotti_configure '
                               'ittok.kotti_configure'}
