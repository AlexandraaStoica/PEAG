import random

def generate_population(n, dim):
    population = []
    for _ in range(dim):
        permutation = random.sample(range(1, n+1), n)  # Generăm o permutare aleatoare
        quality = calculate_quality(permutation)       # Calculăm calitatea
        population.append((permutation, quality))     # Adăugăm permutarea și calitatea în populație
    return population

def calculate_quality(permutation):
    quality = 0
    n = len(permutation)
    for i in range(n):
        for j in range(i+1, n):
            if permutation[i] < permutation[j] and permutation[permutation[i]-1] == permutation[j] and permutation[permutation[j]-1] == permutation[i]:
                quality += 1
    return quality

def mutation_operator(population, pm):
    new_population = []
    for individual in population:
        chromosome, quality = individual
        if random.random() < pm:  # Probabilitatea de mutație
            # Aplicăm mutația prin inserare
            idx = random.randint(0, len(chromosome)-1)
            element = random.randint(1, len(chromosome))
            chromosome.insert(idx, element)
        new_quality = calculate_quality(chromosome)
        new_population.append((chromosome, new_quality))
    return new_population

# Exemplu de utilizare:
n = 5  # Numărul de elemente din permutare
dim = 10  # Dimensiunea populației inițiale
pm = 0.1  # Probabilitatea de mutație

population = generate_population(n, dim)
print("Populație inițială:", population)

new_population = mutation_operator(population, pm)
print("Populație după mutație:", new_population)
