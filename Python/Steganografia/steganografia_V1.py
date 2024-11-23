from stegano import lsb
import sys
sys.stdout.reconfigure(encoding='utf-8')

secret = lsb.hide('Adres_zdjęcia', 'Teks_dodawany_do_zdjecia')
secret.save('Adres_nowego_zdjęcia')

result = lsb.reveal('Adres_nowego_zdjęcia')
print(result)
