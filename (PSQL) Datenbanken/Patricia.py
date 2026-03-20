import os

def split_text(text, chunk_size):
    return [text[i:i + chunk_size] for i in range(0, len(text), chunk_size)]

# Datei einlesen
def read_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        return file.read()

# Textabschnitte in separaten Dateien auf dem Desktop speichern
def save_chunks(chunks, save_directory):
    for idx, chunk in enumerate(chunks):
        chunk_file_path = os.path.join(save_directory, f'chunk_{idx + 1}.txt')
        with open(chunk_file_path, 'w', encoding='utf-8') as file:
            file.write(chunk)
        print(f'{chunk_file_path} gespeichert.')

# Hauptfunktion
def main():
    desktop_path = os.path.join(os.path.expanduser("~"), 'Desktop')
    file_path = os.path.join(desktop_path, 'Patricia.txt')  # Pfad zu deiner Datei auf dem Desktop
    chunk_size = 4050  # Größe der Textabschnitte in Zeichen

    text = read_file(file_path)
    chunks = split_text(text, chunk_size)
    save_chunks(chunks, desktop_path)

if __name__ == "__main__":
    main()
