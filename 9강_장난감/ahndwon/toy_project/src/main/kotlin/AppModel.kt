class AppModel(
    private val generator: PositiveIntegerGenerator
) {
    companion object {
        const val SELECT_MODE_MESSAGE = "1: Single player game\n2: Multiplayer game\n3: Exit\nEnter selection: "
    }

    var completed = false
    var output = SELECT_MODE_MESSAGE
    var singlePlayerMode = false
    private var answer: Int = 0
    private var processor: Processor? = Processor(this::processModeSelection)

    fun isCompleted(): Boolean {
        return completed
    }

    fun flushOutput(): String {
        return output
    }

    fun processInput(input: String) {
        processor = processor?.run(input)
    }

    private fun processModeSelection(input: String): Processor? {
        return if (input == "1") {
            output = "Single player game \nI'm thinking of a number between 1 and 100.\nEnter your guess: "
            singlePlayerMode = true
            answer = generator.generateLessThanOrEqualToHundred()
            getSinglePlayerGameProcessor(answer, 1)
        } else {
            completed = true
            null
        }
    }

    private fun getSinglePlayerGameProcessor(answer : Int, tries: Int): Processor? {
        return Processor { input ->
            val guess = input.toInt()
            if (guess < answer) {
                output = "Your guess is too low.\nEnter your guess: "
                getSinglePlayerGameProcessor(answer, tries + 1)
            } else if (guess > answer) {
                output = "Your guess is too high.\nEnter your guess: "
                getSinglePlayerGameProcessor(answer, tries + 1)
            }

            output =
                "Correct! $tries ${if (tries == 1) "guess" else "guesses"}.\n$SELECT_MODE_MESSAGE"
            singlePlayerMode = false
            processModeSelection(input)
        }
    }

    fun interface Processor {
        fun run(input: String): Processor?
    }
}