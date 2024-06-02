import os

def insert_initial_paintings():
    print('Entro en insert_initial_paintings')
    base_dir = 'assets/images/bd'
    
    paintings = []

    if os.path.exists(base_dir):
        entities = []
        for root, dirs, files in os.walk(base_dir):
            for file in files:
                entities.append(os.path.join(root, file))
        
        print(f'Procesando entidad: {len(entities)}')

        for entity in entities:
            if entity.endswith('.png'):
                parts = entity.split(os.sep)
                print(parts)
                if len(parts) >= 3:
                    style = parts[1]
                    author = parts[2].replace('_', ' ')
                    title = parts[3].replace('_', ' ').replace('.png', '')

                    painting = {
                        'title': title,
                        'imagePath': entity,
                        'style': style,
                        'author': author,
                    }
                    paintings.append(painting)
                    print(f'Added painting: {painting}')  # Verificación de la adición
    else:
        print(f'El directorio {base_dir} no existe')

    return paintings

# Example usage:
paintings = insert_initial_paintings()

# Visualizar todos los resultados
for painting in paintings:
    print(painting)
