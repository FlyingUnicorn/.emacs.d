import os
import sys

lst_ext_src = ['c', 'cpp', 'cc']
lst_ext_hdr = ['h']

lst_dir_src = ['src', 'Src', 'source', 'Source', 'sources', 'Sources']
lst_dir_hdr = ['inc', 'Inc', 'include', 'Include', 'includes', 'Includes']

def assemble_path(f_base, f_dir, f_name, f_ext):
    f_target = '{}/{}/{}.{}'.format(f_base, f_dir, f_name, f_ext)
    #print('exist: {} target: {}'.format(os.path.isfile(f_target), f_target))
    return (os.path.isfile(f_target), f_target)

def find_src_hdr(path_buffer):
    try:
        #print(' -- {} --'.format(path_buffer))
        f_ext = path_buffer.split('.')[-1]
        f_name = '.'.join(path_buffer.split('.')[:-1]).split('/')[-1]
        f_split = path_buffer.split('/')
        f_dir = f_split[-2]
        f_base = '/'.join(f_split[:-2])
        #print('base: {}'.format(f_base))
        #print('ext: {}'.format(f_ext))
        #print('dir: {}'.format(f_dir))
        #print('name: {}'.format(f_name))

        lst_dir_asso = [f_dir]
        lst_ext_asso = []

        # source
        if f_ext in lst_ext_src:
            if f_dir in lst_dir_src:
                lst_dir_asso.extend(lst_dir_hdr)
            lst_ext_asso = lst_ext_hdr

        #header
        elif f_ext in lst_ext_hdr:
            if f_dir in lst_dir_hdr:
                lst_dir_asso.extend(lst_dir_src)
            lst_ext_asso = lst_ext_src

        else:
            return

        for dir_asso in lst_dir_asso:
            for ext in lst_ext_asso:
                (found, target) = assemble_path(f_base, dir_asso, f_name, ext)
                if found:
                    sys.stdout.write('{}'.format(target))
                    return
    except:
        pass
    return

if __name__ == '__main__':
    find_src_hdr(sys.argv[1])
