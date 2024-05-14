###Perm
import numpy


#Functia fitness
def fitness():

#Generarea populatiei initiale
def gen():

#Selectie parinti
def ruleta():

#Crossover
def crossover_populatie():

#Mutatie interschimbare
def mutatie_copii():


#Selectie populatie urmatoare
def elitism(pop_curenta, pop_mutanta, dim, n):
    pop_curenta = numpy.asarray(pop_curenta)
    pop_mutanta = numpy.asarray(pop_mutanta)
    pop_urmatoare = numpy.copy(pop_mutanta)

    max_curent = numpy.max(pop_curenta[:, -1])
    max_mutant = numpy.max(pop_mutanta[:, -1])

    if max_curent > max_mutant:
        poz = numpy.where(pop_curenta[:, -1] == max_curent)
        imax = poz[0][0]
        ir = numpy.random.randint(dim)
        pop_urmatoare[ir, 0:n] = pop_curenta[imax, 0:n].copy()
        pop_urmatoare[ir, n] = max_curent
    return pop_urmatoare


#Algoritmul genetic final
def GA(dim, NMAX, pc, pm):
    populatia_init, dim, n, c = gen()
    populatia_init = numpy.asarray(populatia_init)
    istoric_v = [numpy.max(populatia_init[:, -1])]
    it = 0
    gata = False
    nrm = 1
    n = 10

    while it < NMAX and not gata:
        parinti = ruleta()
        pop_copii = crossover_populatie()
        pop_copii_mutanti = mutatie_copii()
        pop_urmatoare = elitism(populatia_init, pop_copii_mutanti, dim, n)
        minim = numpy.min(pop_urmatoare[:, -1])
        maxim = numpy.max(pop_urmatoare[:, -1])

        if maxim == istoric_v[it]:
            nrm = nrm + 1
        else:
            nrm = 0

        if maxim == minim or nrm == int(NMAX / 4):
            gata = True
        else:
            it = it + 1

        istoric_v.append(numpy.max(pop_urmatoare[:, -1]))

    poz_max = numpy.where(pop_urmatoare[:, -1] == maxim)
    individ_max_gene = pop_urmatoare[poz_max[0][0], 0:n]
    individ_max_fitness = maxim
    return numpy.asarray(individ_max_gene), individ_max_fitness
