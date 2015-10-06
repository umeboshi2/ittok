# -*- coding: utf-8 -*-

"""
Created on 2015-10-05
:author: Joseph Rawson (joseph.rawson.works@gmail.com)
"""

from pyramid.view import view_config
from pyramid.view import view_defaults

from ittok import _
from ittok.resources import CustomContent
from ittok.fanstatic import css_and_js
from ittok.views import BaseView


@view_defaults(context=CustomContent, permission='view')
class CustomContentViews(BaseView):
    """ Views for :class:`ittok.resources.CustomContent` """

    @view_config(name='view', permission='view',
                 renderer='ittok:templates/custom-content-default.pt')
    def default_view(self):
        """ Default view for :class:`ittok.resources.CustomContent`

        :result: Dictionary needed to render the template.
        :rtype: dict
        """

        return {
            'foo': _(u'bar'),
        }

    @view_config(name='alternative-view', permission='view',
                 renderer='ittok:templates/custom-content-alternative.pt')
    def alternative_view(self):
        """ Alternative view for :class:`ittok.resources.CustomContent`.
        This view requires the JS / CSS resources defined in
        :mod:`ittok.fanstatic`.

        :result: Dictionary needed to render the template.
        :rtype: dict
        """

        css_and_js.need()

        return {
            'foo': _(u'bar'),
        }
