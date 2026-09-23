project(
    'capy',
    'cpp',
    meson_version: '>= 1.3.0',
    version: '0.1',
    default_options: ['warning_level=3'],
)

qt6 = import('qt6')
qt6_dep = dependency('qt6', modules: ['Core', 'Gui', 'Qml', 'Quick'])
qt_processed = qt6.preprocess(
  qresources: 'resources.qrc'
)
dependencies = [qt6_dep]

sources = [
    'capy.cpp',
]

headers = []

exe = executable(
    'capy',
    sources + headers,
    qt_processed,
    dependencies: dependencies,
    install: true,
)

test('basic', exe)
