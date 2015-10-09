# -*- coding: utf-8 -*-

"""
Created on 2015-10-05
:author: Joseph Rawson (joseph.rawson.works@gmail.com)
"""

from pyramid.view import view_config
from pyramid.view import view_defaults

from kotti.interfaces import IContent

from ittok import _
from ittok.resources import CustomContent
from ittok.fanstatic import css_and_js
from ittok.views import BaseView

@view_config(name='apiuserview', renderer='json', xhr=True)
def userview(context, request):
    udata = None
    user = request.user
    if user is not None:
        udata = dict()
        for key in ['id', 'email', 'groups', 'name', 'title']:
            udata[key] = getattr(user, key)
        for dt in ['creation_date', 'last_login_date']:
            value = getattr(user, dt)
            if value is not None:
                value = value.isoformat()
            udata[dt] = value
    return udata
    
@view_config(name='apiview', context=IContent, permission='view',
             renderer='json')
def view(context, request):
    cdata = dict()
    for key in ['annotations', 'body', 'default_view',
                'description', 'title', 'state',
                'name', 'owner', 'path', 'type']:
        cdata[key] = getattr(context, key)
    for dt in ['creation_date', 'modification_date']:
        cdata[dt] = getattr(context, dt).isoformat()
    #import pdb ; pdb.set_trace()
    return dict(context=cdata)



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
