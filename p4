##4. Fie 𝑓:[−1,1] × [0,1] × [−2,1] → ℝ, 𝑓(𝑥1, 𝑥2, 𝑥3) = 1 + 𝑠𝑖𝑛(2𝑥1 − 𝑥3) + 𝑐𝑜𝑠(𝑥2) funcţia obiectiv 
##a unei probleme de maxim. Un genotip este un vector 𝑥 = (𝑥1, 𝑥2, 𝑥3)𝑇, 𝑥 ∈[−1,1] × [0,1] × [−2,1]
##a. Scrieţi o funcţie Python pentru generarea aleatoare a unei populaţii, pop, cu dimensiunea dim; 
##indivizii populaţiei sunt însoţiţi de funcţia merit (sunt vectori cu 4 componente).
##b. Pentru o probabilitate de recombinare dată, pc, scrieţi o funcţie de recombinare utilizând 
##operatorul de recombinare aritmetică totală care, pe baza populaţiei pop obţine o nouă populaţie, 
##popc. Populaţia rezultată are tot dim indivizi (este utilizată şi recombinarea asexuată şi calitatea 
##fiecărui individ este memorată la sfârşitul fiecărei reprezentări cromozomiale).

import numpy as np


def fitness(x):
    return 1 + 2 * np.sin(x[0] - x[2]) + np.cos(x[1])


def cerinta_a(dim):
    populatie = np.zeros([dim, 4])
    for i in range(dim):
        populatie[i, 0] = np.random.uniform(-1, 1)
        populatie[i, 1] = np.random.uniform(0, 1)
        populatie[i, 2] = np.random.uniform(-2, 1)
        populatie[i, 3] = fitness(populatie[i, :3])
    return populatie


def aritmetica_t(x, y, alpha):
    r1 = alpha * x + (1 - alpha) * y
    r2 = alpha * y + (1 - alpha) * x
    return r1, r2


def cerinta_b(populatie, pc, alpha):
    dim = populatie.shape[0]
    populatie_c = populatie.copy()
    for i in range(0, dim - 1, 2):
        r = np.random.uniform(0, 1)
        if r <= pc:
            print('\nCrossover in \n', populatie[i, :-1], ' calitatea ', populatie[i, -1], '\n', populatie[i + 1, :-1],
                  ' calitatea ', populatie[i + 1, -1])
            populatie_c[i, :-1], populatie_c[i + 1, :-1] = aritmetica_t(populatie[i, :-1],
                                                                        populatie[i + 1, :-1],
                                                                        alpha)
            populatie_c[i, -1] = fitness(populatie_c[i, :-1])
            populatie_c[i + 1, -1] = fitness(populatie_c[i + 1, :-1])
            print('Rezulta\n', populatie_c[i, :-1], ' calitatea ', populatie_c[i, -1], '\n', populatie_c[i + 1, :-1],
                  ' calitatea ', populatie_c[i + 1, -1])
    return populatie_c


if __name__ == "__main__":
    dim = 10
    pc = 0.7
    alpha = 0.25
    populatie = cerinta_a(dim)
    print(populatie)
    populatie_c = cerinta_b(populatie, pc, alpha)
    print("------------------------------------------------")
    print(populatie_c)
