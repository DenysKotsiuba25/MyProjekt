from stegano import exifHeader
import sys
sys.stdout.reconfigure(encoding='utf-8')
AdresZdjęcia = input('Podaj adres zdjęcia do szyfrowania: ')
AdresNowegoZdjęcia = input('Podaj adres zdjęcia po szyfrowaniu:')
TekstDoSzyfrowania = input('Podaj tekst do szyfrowania: ')

secret = exifHeader.hide(AdresZdjęcia, 
                         AdresNowegoZdjęcia, 
                         TekstDoSzyfrowania)

result = exifHeader.reveal(AdresNowegoZdjęcia)
result = result.decode()
print('W pliku zaszyfrowano: ', result)
