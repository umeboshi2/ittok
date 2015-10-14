from pyramid.config import Configurator
from sqlalchemy import engine_from_config

import kotti

from .models import (
    DBSession,
    Base,
    )


# All of these can be set by passing them in the Paste Deploy settings:
default_settings = {
    'kotti.asset_overrides': '',
    'kotti.authn_policy_factory': 'kotti.authtkt_factory',
    'kotti.authz_policy_factory': 'kotti.acl_factory',
    'kotti.available_types': ' '.join([
        'kotti.resources.Document',
        'kotti.resources.File',
        'kotti.resources.Image',
        ]),
    'kotti.base_includes': ' '.join([
        'kotti',
        'kotti.filedepot',
        'kotti.events',
        'kotti.sanitizers',
        'kotti.views',
        'kotti_jsonapi.rest',
        'kotti.views.cache',
        'kotti.views.view',
        'kotti.views.edit',
        'kotti.views.edit.actions',
        'kotti.views.edit.content',
        'kotti.views.edit.default_views',
        'kotti.views.edit.upload',
        'kotti.views.file',
        'kotti.views.image',
        'kotti.views.login',
        'kotti.views.navigation',
        'kotti.views.users',
        ]),
    'kotti.populators': 'kotti.populate.populate',
    'kotti.principals_factory': 'kotti.security.principals_factory',
    'kotti.request_factory': 'kotti.request.Request',
    'kotti.root_factory': 'kotti.resources.default_get_root',
    'kotti.use_tables': '',
    'pyramid.includes': 'ittok pyramid_mako',
    }

def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    settings2 = default_settings.copy()
    settings2.update(settings)
    
    config = kotti.base_configure(global_config, **settings2)
    config.add_static_view(name='static', path='ittok:static', cache_max_age=3600)
    
    engine = engine_from_config(config.registry.settings, 'sqlalchemy.')
    kotti.resources.initialize_sql(engine)

    DBSession.configure(bind=engine)
    Base.metadata.bind = engine

    config.include('pyramid_chameleon')
    config.add_route('home', '/')
    config.scan()
    return config.make_wsgi_app()
