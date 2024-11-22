project('CompassDL', 'C')

c_args = ['-pg', '-no-pie']
link_args = ['-pg', '-no-pie']

lib = shared_library('CompassDL', 'src/_core/lexer.c', 'src/_core/utils.c', 'src/_core/database.c', 'src/_core/map.c', 'src/_core/parser.c')

executable('compass', 'src/_core/main.c', link_with: lib)
