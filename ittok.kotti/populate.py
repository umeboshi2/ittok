"""
Populate contains two functions that are called on application startup
(if you haven't modified kotti.populators).
"""

from pyramid.i18n import LocalizerRequestMixin
from pyramid.threadlocal import get_current_registry

from kotti import get_settings
from kotti.resources import DBSession
from kotti.resources import get_root
from kotti.resources import Document

from kotti.security import get_principals
from kotti.security import SITE_ACL
from kotti.util import _
from kotti.workflow import get_workflow



def populate():
    """
    Create the base page...
    """
    root = get_root()
    tenyu = root.get('tenyu', Document())
    tenyu.title = 'tenyu'
    tenyu.default_view = 'tenyu'
    root['tenyu'] = tenyu

    ittok = root.get('ittok', Document())
    ittok.title = 'ittok'
    root['ittok'] = ittok
    
    
    
