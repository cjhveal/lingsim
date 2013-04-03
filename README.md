Genetic Algoirthm for Interagent language simulation.



Population of agents with a "natural" fitness chosen acording to a normal distribution.
Language is defined by a genome. It imparts a "linguistic fitness" to the agent.

Total fitness = k*fitness_natural + l*fitness_linguistic

the linguistic fitness of an agent is proportional by the sum of the population's fitnesses,
weighted by the inverse of the edit distance between the two agent's linguistic genomes.
The constant of proportionality is a function of the agent's natural fitness.

fitness_linguistic =

We run many rounds of linguistic crossover per generation.
