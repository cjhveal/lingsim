require 'underscore'

class Utilities

  # random number uniformly distributed over range [n, m]
  randomRange: (n, m) ->
    n + (m-n) * Math.random()

  # standardly distributed random number
  # with mean 0 and std_dev 1
  stdRandom: =>
    @randomRange(-1, 1) + @randomRange(-1, 1) + @randomRange(-1, 1)

  # gaussian distribution about mean with stdDeviation
  gaussianRandom: (mean, stdDeviation) =>
    mean + stdDeviation * @stdRand()

  # sum a list of numbers
  sum: (numbers) ->
    _.reduce numbers, (memo, n) -> memo + n

  # safe inverse
  inv: (n) ->
    if n is 0 then 0 else 1/n

  editDistance: (str1, str2) =>
    pairs = _.zip str1.split(''), str2.split('')
    @count pairs, (a, b) -> a isnt b

  count: (array, iterator) =>
    @sum _.map(array, (x) => if iterator(x) then 1 else 0)

  # return a letter of the alphabet
  # n = 0 -> a, n = 1 -> b, n = 2 -> c, ...
  alpha: (n) =>
    String.fromCharCode 101 + n

  # return a random letter from the first n
  randomAlpha: (n) =>
    @alpha @randomRange(0,n)


Utils = new Utilities()

class Language
  GENOME_SIZE: 6

  constructor: ->
    @genome = @generateGenome()

  generateGenome: =>
    @genome = []
    _.times GENOME_SIZE, => @genome.push Utils.randomAlpha()

  distance: (otherLanguage) =>
    Utils.editDistance @genome, otherLanguage.genome

class Agent
  NAT_FITNESS_WEIGHT: 0.8
  LING_FITNESS_WEIGHT: 1 - NAT_FITNESS_WEIGHT

  constructor: (@population) ->
    @naturalFitness = @gaussianRandom(100, 10)
    @language = new Language()

  naturalMutate: =>
    @naturalFitness += @gaussianRandom(0, 5)

  lingusiticFitness: =>
    Utils.sum _.map @population, (agent) ->
      agent.naturalFitness * Utils.inv @language.distance(agent.language)

  linguisticMutate: =>
    @language.mutate()

  fitness: =>
    NAT_FITNESS_WEIGHT * @naturalFitness + LING_FITNESS_WEIGHT * @linguisticFitness()

class Environment
  constructor: (n) ->
    @population = []
