class AppModel(
    private val generator: PositiveIntegerGenerator
) {
    companion object {
        const val SELECT_MODE_MESSAGE = "1: Single player game\n2: Multiplayer game\n3: Exit\nEnter selection: "
    }

    var completed = false
    var singlePlayerMode = false
    private val outputBuffer = StringBuilder(SELECT_MODE_MESSAGE)
    private var answer: Int = 0
    private var processor: Processor? = Processor(this::processModeSelection)

    fun isCompleted(): Boolean {
        return completed
    }

    fun flushOutput(): String {
        val output = outputBuffer.toString()
        outputBuffer.clear()
        return output
    }

    fun processInput(input: String) {
        processor = processor?.run(input)
    }

    private fun print(message: String) {
        outputBuffer.append(message)
    }

    private fun println(message: String) {
        outputBuffer.append(message + "\n")
    }

    private fun processModeSelection(input: String): Processor? {
        return when (input) {
            "1" -> {
                println("Single player game")
                println("I'm thinking of a number between 1 and 100.")
                print("Enter your guess: ")
                singlePlayerMode = true
                answer = generator.generateLessThanOrEqualToHundred()
                getSinglePlayerGameProcessor(answer, 1)
            }
            "2" -> {
                println("Multiplayer game")
                print("Enter player names separated with commas: ")
                startMultiPlayerGame()
            }
            else -> {
                completed = true
                null
            }
        }
    }

    private fun startMultiPlayerGame(): Processor {
        return Processor {
            val players = it.split(",").map(String::trim).toTypedArray()
            println("I'm thinking of a number between 1 and 100.")
            val answer = generator.generateLessThanOrEqualToHundred()
            getMultiplayerGameProcessor(players, answer, 1)
        }
    }

    private fun getMultiplayerGameProcessor(players: Array<String>, answer: Int, tries: Int): Processor {
        val player = players[(tries - 1) % players.size]
        print("Enter $player's guess: ")
        return Processor { input ->
            val guess = input.toInt()
            when {
                guess < answer -> {
                    println("$player's guess is too low.")
                    return@Processor getMultiplayerGameProcessor(players, answer, tries + 1)
                }
                guess > answer -> {
                    println("$player's guess is too high.")
                    return@Processor getMultiplayerGameProcessor(players, answer, tries + 1)
                }
                else -> {
                    print("Correct! ")
                    println("$player wins.")
                    print(SELECT_MODE_MESSAGE)
                    return@Processor Processor(this::processModeSelection)
                }
            }
        }
    }

    private fun getSinglePlayerGameProcessor(answer: Int, tries: Int): Processor? {
        return Processor { input ->
            val guess = input.toInt()
            when {
                guess < answer -> {
                    println("Your guess is too low.")
                    print("Enter your guess: ")
                    getSinglePlayerGameProcessor(answer, tries + 1)
                }
                guess > answer -> {
                    println("Your guess is too high.")
                    print("Enter your guess: ")
                    getSinglePlayerGameProcessor(answer, tries + 1)
                }
                else -> {
                    println("Correct! $tries ${if (tries == 1) "guess" else "guesses"}.")
                    print(SELECT_MODE_MESSAGE)
                    singlePlayerMode = false
                    processModeSelection(input)
                }
            }
        }
    }

    fun interface Processor {
        fun run(input: String): Processor?
    }
}