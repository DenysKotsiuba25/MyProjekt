import pytesseract
from PIL import Image

img = Image.open
pytesseract.tesseract.cmd = ''
text = pytesseract.image_to_string(img)