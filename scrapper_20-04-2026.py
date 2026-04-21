import requests
from bs4 import BeautifulSoup, Comment
import re

# Definir la URL de la página web.
# Hacer una petición HTTP a la página.
# Obtener el contenido HTML de la respuesta.
# Analizar el HTML usando un parser.
# Buscar todos los textos dentro del HTML.
# Filtrar solo los que sean comentarios.
# Guardar esos comentarios en una lista.
# Buscar correos electrónicos usando una expresión regular.
# Guardar los correos encontrados en otra lista.
# Crear un archivo de salida.
# Escribir en el archivo:
# Primero los comentarios.
# Luego los correos electrónicos.
# Cerrar el archivo.
# Fin

url = "https://eminus.uv.mx/eminus4"

response = requests.get(url)
html = response.text

soup = BeautifulSoup(html, "html.parser")

comentariosTODOS = soup.find_all(string=True)
comentarios = []

for texto in comentariosTODOS:
    if isinstance(texto, Comment):
        comentarios.append(texto)

correos = re.findall(r"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+", html)

with open("resultado", "w", encoding="utf-8") as archivo:
    archivo.write("COMENTARIOS\n")
    for c in comentarios:
        archivo.write(c + "\n")

    archivo.write("\nCORREOS\n")
    for correo in correos:
        archivo.write(correo + "\n")

