# -*- coding: utf-8 -*-

"""
Created on 2015-10-05
:author: Joseph Rawson (joseph.rawson.works@gmail.com)
"""

from kotti.resources import File
from pyramid.i18n import TranslationStringFactory

_ = TranslationStringFactory('ittok')


def kotti_configure(settings):
    """ Add a line like this to you .ini file::

            kotti.configurators =
                ittok.kotti_configure

        to enable the ``ittok`` add-on.

    :param settings: Kotti configuration dictionary.
    :type settings: dict
    """

    settings['pyramid.includes'] += ' ittok pyramid_mako'
    settings['kotti.alembic_dirs'] += ' ittok:alembic'
    settings['kotti.available_types'] += ' ittok.resources.CustomContent'
    #settings['kotti.fanstatic.view_needed'] = ' ittok.fanstatic.css_and_js'
    File.type_info.addable_to.append('CustomContent')


def includeme(config):
    """ Don't add this to your ``pyramid_includes``, but add the
    ``kotti_configure`` above to your ``kotti.configurators`` instead.

    :param config: Pyramid configurator object.
    :type config: :class:`pyramid.config.Configurator`
    """

    config.add_translation_dirs('ittok:locale')
    config.add_static_view('static-ittok', 'ittok:static')
    config.add_view(
        name='tenyu',
        renderer='ittok:templates/tenyu.pt')
    config.scan(__name__)
    
