import pyAesCrypt
import os

import sys
sys.stdout.reconfigure(encoding='utf-8')


def encryption(file, password):

    buffer_size = 512 * 1024

    pyAesCrypt.encryptFile(
        str(file),
        str(file) + '.crp',
        password,
        buffer_size
    )

    print("[Plik'" + str(os.path.basename(file)) + "'zaszyfrowany]")

    os.remove(file)


def walking_by_dirs(dir, password):

    for name in os.listdir(dir):
        path = os.path.join(dir, name)

        if os.path.isfile(path):
            try:
                encryption(path, password)
            except Exception as ex:
                print(ex)
        elif os.path.isdir(path):
            walking_by_dirs(path, password)


password = input("Podaj haslo: ")
dir = input('Podaj adres foldera: ')
walking_by_dirs(dir, password)
