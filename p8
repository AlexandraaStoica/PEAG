##8. Fie 𝑓: 𝒫(𝑛) → ℕ funcţia obiectiv definită pentru problema celor n regine astfel:
##𝑝𝜖𝒫(𝑛), 𝑓(𝑝) = 𝑛 × 𝑛−1 2− |{(𝑖,𝑗)⁄𝑖 < 𝑗, |𝑝(𝑖) − 𝑝(𝑗)| = |𝑖 − 𝑗|}|, unde 𝒫(𝑛) desemnează mulţimea permutărilor de n elemente. 
##a. Scrieţi o funcţie Python pentru generarea aleatoare a unei populaţii, pop, cu dimensiunea dim; 
##calitatea fiecărui individ este memorată la sfârşitul fiecărei reprezentări cromozomiale;
##b. Aplicaţi funcţia de generare implementată mai sus pentru obţinerea a două populaţii, pop1, pop2 
##cu câte dim indivizi. Scrieţi o funcţie Python care obţine o nouă populaţie prin aplicarea unei 
##proceduri de tip elitist celor două populaţii, unde pop2 este considerată populaţia progeniturilor lui 
##pop1. Populaţia rezultată are tot dim indivizi.

import numpy as np


def fitness(x):
    counter = 0
    n = len(x)
    for i in range(n - 1):
        for j in range(i + 1, n):
            if x[i] - x[j] == i - j:
                counter += 1
    return n * (n - 1) / 2 - counter


def gen(dim, n):
    pop = []
    for i in range(dim):
        x = np.random.permutation(n)
        x = list(x)
        f = fitness(x)
        x.append(f)
        pop.append(x)
    return pop


def elitism(pop_curenta, pop_mutanta, dim):
    n = len(pop_mutanta[0]) - 1
    pop_curenta = np.asarray(pop_curenta)
    pop_mutanta = np.asarray(pop_mutanta)
    pop_urmatoare = np.copy(pop_mutanta)

    max_curent = np.max(pop_curenta[:, -1])
    print("max_curent", max_curent)
    max_mutant = np.max(pop_mutanta[:, -1])
    print("max_mutant", max_mutant)

    if max_curent > max_mutant:
        poz = np.where(pop_curenta[:, -1] == max_curent)[0]
        print("poz:", poz)
        imax = poz[0]
        ir = np.random.randint(dim)
        pop_urmatoare[ir, :n] = pop_curenta[imax, :n].copy()
        pop_urmatoare[ir, n] = max_curent
    return pop_urmatoare


pop1 = gen(10, 10)
pop2 = gen(10, 10)
pop_urmatoare = elitism(pop1, pop2, 10)
# print(pop_urmatoare)
