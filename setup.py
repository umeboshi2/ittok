import os

from setuptools import setup, find_packages

here = os.path.abspath(os.path.dirname(__file__))
with open(os.path.join(here, 'README.txt')) as f:
    README = f.read()
with open(os.path.join(here, 'CHANGES.txt')) as f:
    CHANGES = f.read()

install_requires = [
    'pyramid',
    'pyramid_chameleon',
    'pyramid_mako',
    'pyramid_tm',
    'SQLAlchemy',
    'transaction',
    'zope.sqlalchemy',
    'waitress',
    'repoze.workflow>=master',
    'Kotti>=master',
    'kotti_tinymce',
    'kotti_accounts',
    'kotti_blog',
    'kotti_calendar',
    'kotti_jsonapi>=master',
    'kotti_settings',
    'kotti_velruse',
    ]

development_requires = [
    'pyramid_debugtoolbar',
    'pyramid_tm',
    'repoze.debug',
    'repoze.tm2',
    'repoze.who',
    'repoze.what',
    ]


setup(name='ittok',
      version='0.0',
      description='ittok',
      long_description=README + '\n\n' + CHANGES,
      classifiers=[
        "Programming Language :: Python",
        "Framework :: Pyramid",
        "Topic :: Internet :: WWW/HTTP",
        "Topic :: Internet :: WWW/HTTP :: WSGI :: Application",
        ],
      author='',
      author_email='',
      url='',
      keywords='web wsgi bfg pylons pyramid',
      packages=find_packages(),
      include_package_data=True,
      zip_safe=False,
      test_suite='ittok',
      install_requires=install_requires,
      entry_points="""\
      [paste.app_factory]
      main = ittok:main
      [console_scripts]
      initialize_ittok_db = ittok.scripts.initializedb:main
      """,
      dependency_links=[
        'https://github.com/knowah/PyPDF2/archive/master.tar.gz#egg=PyPDF2-1.15dev',
        'https://github.com/repoze/repoze.workflow/archive/master.tar.gz#egg=repoze.workflow-master',
        'https://github.com/umeboshi2/trumpet/archive/master.tar.gz#egg=trumpet',
        'https://github.com/umeboshi2/Kotti/archive/master.tar.gz#egg=Kotti-1.2.2-dev',
        'https://github.com/umeboshi2/kotti_jsonapi/archive/master.tar.gz#egg=kotti_jsonapi-master',
        ],
      extras_require={
          'development': development_requires,
          },
      )
