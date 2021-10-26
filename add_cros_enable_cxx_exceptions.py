#!/usr/bin/env python3
import os


OVERLAY_DIR = os.path.dirname(os.path.abspath(__file__))
CMD = "cros_enable_cxx_exceptions"
FUNCTION = "src_prepare"


def enable_exception(fp):
    lines = []
    mock = False
    with open(fp) as f:
        text = f.read()
        if CMD in text:
            return
        
        for l in text.split('\n'):
            if l.strip().startswith(FUNCTION) and l.replace(' ', '').startswith('src_prepare(){'):
                mock = True
                if l.strip() == FUNCTION + '() {':
                    lines.append(l)
                    lines.append(' '*8 + CMD)
                else:
                    print(fp, ':', 'mock src_prepare error')
            else:
                lines.append(l)

    if not mock:
        lines.append(FUNCTION + '() {')
        lines.append(' '*8 + CMD)
        lines.append('}')

    with open(fp, 'w') as f:
        f.write('\n'.join(lines))


def scan_ebuilds(folder):
    fps = []
    for root, dirs, files in os.walk(folder, topdown=False):
        for fp in files:
            if fp.endswith('.ebuild'):
                fps.append(os.path.join(root, fp))
    return fps


def main():
    for fp in scan_ebuilds(OVERLAY_DIR):
        enable_exception(fp)


if __name__ == "__main__":
    main()
