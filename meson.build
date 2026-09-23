project(
    'capy',
    'cpp',
    meson_version: '>= 1.3.0',
    version: '0.1',
    default_options: ['warning_level=3'],
)


qt6 = import('qt6')
qt6_dep = dependency('qt6', modules: ['Core', 'Gui', 'Widgets'])
moc_files = qt6.compile_moc(headers: 'capy.hpp',
                            extra_args: ['-DMAKES_MY_MOC_HEADER_COMPILE'],
                            dependencies: qt6_dep)

dependencies = [qt6_dep]

sources = [
    'capy.cpp',
]

headers = ['capy.hpp']

exe = executable(
    'capy',
    sources + headers,
    moc_files,
    dependencies: dependencies,
    install: true,
)

test('basic', exe)
