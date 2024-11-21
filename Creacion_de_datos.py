import pandas as pd
from faker import Faker
import random
import os

# Initialization
fake = Faker()

# Scalability variable (adjust as needed)
TOTAL_DATOS = 10000000

# Entities and their counts (adjust proportions if needed)
USUARIOS = max(1, int(TOTAL_DATOS * 0.20))
VIDEOJUEGOS = max(1, int(TOTAL_DATOS * 0.15))
LOGROS = max(1, int(TOTAL_DATOS * 0.25))
MODS = max(1, int(TOTAL_DATOS * 0.10))
RESEÑAS = max(1, int(TOTAL_DATOS * 0.30))
INTERCAMBIOS = max(1, int(TOTAL_DATOS * 0.20))
OBJETOS = max(1, int(TOTAL_DATOS * 0.15))

# Data lists
usuarios, videojuegos, logros, mods = [], [], [], []
reseñas, intercambios, objetos = [], [], []

# Generate Usuarios
for i in range(USUARIOS):
    usuarios.append({
        'usuario_id': i + 1,
        'nombre': fake.name(),
        'apodo': fake.user_name(),
        'verificado': random.choice([True, False])
    })

# Generate Videojuegos
for i in range(VIDEOJUEGOS):
    videojuegos.append({
        'id_videojuego': i + 1,
        'nombre': f"Videojuego {fake.word().capitalize()}",
        'descripcion': fake.sentence(),
        'fecha_creacion': fake.date_between(start_date='-5y', end_date='today'),
        'precio': round(random.uniform(10, 60), 2)
    })


# Generate Logros
for i in range(LOGROS):
    logros.append({
        'id_logro': i + 1,
        'id_videojuego': random.choice(videojuegos)['id_videojuego'],  # Relationship
        'nombre': f"Logro {fake.word().capitalize()}",
        'descripcion': fake.sentence()
    })


# Generate Mods
for i in range(MODS):
    mods.append({
        'id_mod': i + 1,
        'id_videojuego': random.choice(videojuegos)['id_videojuego'],  # Relationship
        'descripcion': fake.sentence(),
        'tipo': fake.word()
    })

# Generate Reseñas
for i in range(RESEÑAS):
    reseñas.append({
        'id_reseña': i + 1,
        'id_videojuego': random.choice(videojuegos)['id_videojuego'], # Relationship
        'usuario_id': random.choice(usuarios)['usuario_id'], # Relationship
        'comentario': fake.paragraph(),
        'fecha_comentario': fake.date_this_year(),
        'horas_jugadas': random.randint(1, 100)
    })

# Generate Intercambios
for i in range(INTERCAMBIOS):
    intercambios.append({
        'id_intercambio': i + 1,
        'usuario_id_1': random.choice(usuarios)['usuario_id'], # Relationship
        'usuario_id_2': random.choice(usuarios)['usuario_id'], # Relationship
        'saldo_dado': round(random.uniform(5, 50), 2),
        'saldo_recibir': round(random.uniform(5, 50), 2),
        'fecha_transaccion': fake.date_this_month()
    })

# Generate Objetos
for i in range(OBJETOS):
    objetos.append({
        'objeto_id': i + 1,
        'id_videojuego': random.choice(videojuegos)['id_videojuego'],  # Relationship
        'nombre': f"Objeto {fake.word().capitalize()}",
        'descripcion': fake.sentence()
    })

# Function to save data to CSV
def save_to_csv(data, filename):
    folder = "datos_videojuegos"  # New folder for video game data
    if not os.path.exists(folder):
        os.makedirs(folder)
    filepath = os.path.join(folder, filename)
    pd.DataFrame(data).to_csv(filepath, index=False)
    print(f"{filepath} creado.")

# Save to CSV files
save_to_csv(usuarios, "usuarios.csv")
save_to_csv(videojuegos, "videojuegos.csv")
save_to_csv(logros, "logros.csv")
save_to_csv(mods, "mods.csv")
save_to_csv(reseñas, "reseñas.csv")
save_to_csv(intercambios, "intercambios.csv")
save_to_csv(objetos, "objetos.csv")